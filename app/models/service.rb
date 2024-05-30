class Service < ApplicationRecord
  belongs_to :vendor
  belongs_to :category, optional: true

  has_many :priority_boostings, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :common_questions, dependent: :destroy
  has_many :addresses, dependent: :destroy, inverse_of: :service
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true

  has_one :main_address, dependent: :destroy

  validates :name, :description, :category_id, presence: true
  validates :name, length: { maximum: 100 }

  # override to_param to make model_path construct a path using the model’s name instead of the model’s id
  def to_param
    "#{id}-#{name.parameterize}"
  end

  # This method is used to search the services based on the search term (service's name, category's name), district, and province.
  # Service with the highest priority level will be shown first. Level 1 is the highest priority level.
  # Rails will lazy load your query, so don't worry about performance here
  def self.search(search_term = "", district: nil, province: nil)
    services = Service.left_joins(:addresses)
                      .joins("LEFT JOIN categories ON categories.id = services.category_id")
                      .joins("LEFT JOIN priority_boostings ON priority_boostings.service_id = services.id AND priority_boostings.status = 'ACTIVE' AND priority_boostings.start_time <= NOW() AND priority_boostings.end_time >= NOW()")
                      .where(published: true)
                      .where(["categories.name LIKE :search OR services.name LIKE :search",
                              { search: "%#{search_term}%" }])

    # Apply optional filters
    services = services.where("addresses.district LIKE ?", "%#{district}%") if district.present?
    services = services.where("addresses.province LIKE ?", "%#{province}%") if province.present?

    services.group(:id)
            .select("services.*, COALESCE(MAX(priority_boostings.level), 4) AS max_priority_level")
            .order("max_priority_level ASC, services.updated_at DESC")
  end
end
