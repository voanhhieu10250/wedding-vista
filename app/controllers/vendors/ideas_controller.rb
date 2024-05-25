class Vendors::IdeasController < Vendors::BaseController
  before_action :set_idea, only: %i[ update destroy publish unpublish ]
  before_action :set_idea_with_rich_text_content_and_embeds, only: %i[ edit show ]

  def index
    @ideas = current_vendor.ideas.with_rich_text_content_and_embeds
  end

  def show; end

  def new
    @idea = Idea.new
  end

  def edit; end

  def create
    @idea = current_vendor.ideas.build(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to vendor_idea_url(@idea), notice: "Idea was successfully created." }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to vendor_idea_url(@idea), notice: "Idea was successfully updated." }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_ideas_url, notice: "Idea was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def publish
    # if the idea is not paid, it can't be published
    unless @idea.is_paid?
      flash.now[:error] = "You need to pay for this idea before publishing it."
      render "toggle_publish", locals: { idea: @idea }
      return
    end

    if @idea.update_attribute(:published, true)
      flash.now[:notice] = "Idea was successfully published."
    else
      flash.now[:error] = "Something went wrong. Please try again."
    end

    render "toggle_publish", locals: { idea: @idea }
  end

  def unpublish
    if @idea.update_attribute(:published, false)
      flash.now[:notice] = "Idea was successfully unpublished."
    else
      flash.now[:error] = "Something went wrong. Please try again."
    end

    render "toggle_publish", locals: { idea: @idea }
  end

  private

  def set_idea
    @idea = current_vendor.ideas.find(params[:id])
  end

  def set_idea_with_rich_text_content_and_embeds
    # Avoiding N+1 Queries
    @idea = current_vendor.ideas.with_rich_text_content_and_embeds.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description, :main_image, :content, :topic_id)
  end
end
