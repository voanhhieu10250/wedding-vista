class PagesController < ApplicationController
  def index
    @categories = Category.all

    @topic_categories = TopicCategory.with_attached_image.all.limit(6)
    @ideas = Idea.includes(:vendor, :topic).with_attached_main_image
                 .where(published: true)
                 .order(created_at: :desc).limit(4)

    @discussions = Discussion.with_rich_text_body.order(id: :desc).limit(4)
  end
end
