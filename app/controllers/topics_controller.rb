class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show ]

  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.includes(:ideas, :topic_category).find(params[:id])

    @pagy, @ideas = pagy_countless(@topic.ideas.with_attached_main_image.where(published: true).order(id: :desc), item: 10)

    @categories = TopicCategory.includes(:topics).all
  end
end
