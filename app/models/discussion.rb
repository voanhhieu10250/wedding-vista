class Discussion < ApplicationRecord
  SORTABLE = %w[views created_at updated_at].freeze

  belongs_to :forum, counter_cache: true
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user

  has_rich_text :body

  validates :title, :body, :forum_id, :user_id, presence: true

  def plain_text_body
    # Parse the rich text content
    doc = Nokogiri::HTML.fragment(body.body.to_html)

    # # Remove unwanted elements (like images, figures, etc.)
    # doc.search("img,figure,action-text-attachment").remove

    # Find unwanted elements (like images, figures, etc.) and replace them with non-breaking spaces
    doc.search("img,figure,action-text-attachment").each { |node| node.replace(" ") }

    # Remove empty <p> tags
    doc.search("p").each { |node| node.remove if node.text.strip.empty? }

    # Extract and return the plain text
    doc.text
  end

  # Get the first attachment from the body if exists
  def first_body_previewable_attachment_url
    # # This will query all the attachments then get the first one, which is not efficient
    # attributes = body.body.attachments.first.full_attributes

    attachment_nodes = body.body.fragment.find_all(ActionText::Attachment.tag_name)
    url = nil

    attachment_nodes.each do |node|
      attachment = ActionText::Attachment.from_node(node).with_full_attributes
      attributes = attachment.full_attributes

      # break out of the loop if the attachment is an image or previewable
      if attributes["content_type"].start_with?("image/") && attributes["previewable"]
        url = attributes["url"]
        break
      end
    end

    url
  end
end
