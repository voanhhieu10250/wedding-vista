class IdeasController < ApplicationController
  before_action :set_idea, only: %i[ show ]

  # GET /ideas or /ideas.json
  def index
    @pagy, @ideas = pagy_countless(Idea.includes(:vendor, :topic)
                 .with_attached_main_image
                 .where(published: true)
                 .order(created_at: :desc), items: 3)

    @topic_categories = TopicCategory.with_attached_image.all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /ideas/1 or /ideas/1.json
  def show
    @idea.increment!(:views, 1, touch: false)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.includes(:vendor, :topic)
                .with_attached_main_image
                .with_rich_text_content_and_embeds
                .find_by!(id: params[:id], published: true)
  end

  # Only allow a list of trusted parameters through.
  def idea_params
    params.require(:idea).permit(:title, :description, :content, :vendor_id, :topic_id)
  end
end
