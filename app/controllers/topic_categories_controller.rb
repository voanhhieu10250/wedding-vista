class TopicCategoriesController < ApplicationController
  before_action :set_topic_category, only: %i[ show ]

  def show; end

  private

  def set_topic_category
    @category = TopicCategory.includes(:topics, :ideas).find(params[:id])
    @pagy, @ideas = pagy_countless(@category.ideas.with_attached_main_image.where(published: true).order(id: :desc),
                                   item: 10)

    @categories = TopicCategory.includes(:topics).all
  end
end
