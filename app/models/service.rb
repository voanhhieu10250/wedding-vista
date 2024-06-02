class Service < ApplicationRecord
  belongs_to :vendor
  belongs_to :category, optional: true
  belongs_to :main_address, class_name: "Address", optional: true

  has_many :priority_boostings, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :common_questions, dependent: :destroy
  has_many :addresses, dependent: :destroy, inverse_of: :service
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true

  validates :name, :description, :category_id, presence: true
  validates :name, length: { maximum: 100 }

  # override to_param to make model_path construct a path using the model’s name instead of the model’s id
  def to_param
    "#{id}-#{name.parameterize}"
  end

  # This method is used to search the services based on the search term (service's name, category's name), district, and province.
  # Service with the highest priority level will be shown first. Level 1 is the lowest priority level.
  # Rails will lazy load your query, so don't worry about performance here
  def self.search(search_term = "", district: nil, province: nil)
    services = Service.left_joins(:addresses)
                      .joins("LEFT JOIN categories ON categories.id = services.category_id")
                      .joins("LEFT JOIN priority_boostings ON priority_boostings.service_id = services.id AND priority_boostings.status = 'ACTIVE'")
                      .where(published: true)
                      .where(["priority_boostings.start_time IS NULL OR priority_boostings.start_time <= :now AND priority_boostings.end_time >= :now",
                              { now: Time.zone.now }])
                      .where(["categories.name LIKE :search OR services.name LIKE :search",
                              { search: "%#{search_term}%" }])

    # Apply optional filters
    services = services.where("addresses.district LIKE ?", "%#{district}%") if district.present?
    services = services.where("addresses.province LIKE ?", "%#{province}%") if province.present?

    services.group(:id)
            .select("services.*, COALESCE(MAX(priority_boostings.level), 0) AS max_priority_level, MAX(priority_boostings.created_at) AS latest_priority_created_at")
            .order("max_priority_level DESC, latest_priority_created_at DESC")
  end

  # Pagy overrides the select statement of the query to include the count of the total records
  # Because of that the order clause will generate an error for not knowing the max_priority_level column
  # To fix this, we need to make the search query as a subquery and select count from it
  def self.custom_count(sql)
    Service.from("(#{sql}) services_search").count
  end

  def highest_active_boosting_level
    priority_boostings.active.order(level: :desc).first&.level || 0
  end

  def first_image_thumb_of_first_gallery(variant = :thumb)
    # I dont use with_attached_items because I only need the first image thumb
    # with_attached_items will load ALL images of the gallery which is unnecessary
    galleries.first&.items&.first&.variant(variant) if galleries.first&.items&.attached?
  end

  def items
    galleries.flat_map(&:items)
  end

  def total_items_count
    galleries.sum(&:attachments_count)
  end

  def first_four_items
    items.first(4)
  end

  def first_or_main_address
    main_address || addresses.first
  end

  def addresses_sorted_by_main_first
    addresses.sort_by { |address| address == main_address ? 0 : 1 }
  end
end
