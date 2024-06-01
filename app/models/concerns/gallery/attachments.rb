module Gallery::Attachments
  extend ActiveSupport::Concern

  class ActiveStorage::Attachment
    require "active_record/counter_cache"

    before_create :after_create_action, if: :record_gallery?
    before_destroy :after_destroy_action, if: :record_gallery?

    def after_create_action
      Gallery.increment_counter(:attachments_count, record_id, touch: true)
    end

    def after_destroy_action
      Gallery.decrement_counter(:attachments_count, record_id, touch: true)
    end

    def record_gallery?
      record_type == "Gallery"
    end
  end
end
