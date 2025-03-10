class Vendors::IdeasController < Vendors::BaseController
  before_action :set_idea, only: %i[ update destroy publish unpublish pay ]
  before_action :set_idea_with_rich_text_content_and_embeds, only: %i[ edit show ]

  def index
    ideas = current_vendor.ideas.includes(:topic)
                          .with_attached_main_image
                          .order(created_at: :desc)

    if params[:search].present?
      params[:search] = params[:search].strip
      ideas = ideas.where("ideas.title LIKE ?", "%#{params[:search]}%")
    end

    @pagy, @ideas = pagy ideas, item: 10
  end

  def show; end

  def new
    @idea = Idea.new
    @topic_categories = TopicCategory.includes(:topics).all
  end

  def edit
    @topic_categories = TopicCategory.includes(:topics).all
  end

  def create
    @idea = current_vendor.ideas.build(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to vendor_idea_url(@idea), notice: "Idea was successfully created." }
        format.json { render :show, status: :created, location: @idea }
      else
        @topic_categories = TopicCategory.includes(:topics).all
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
        @topic_categories = TopicCategory.includes(:topics).all
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

    unless @idea.main_image.attached?
      flash.now[:error] = "Idea must have a main image attached to be published."
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

  def pay
    # check if the vendor has a post limit greater than 0
    if current_vendor.post_limit.positive?
      @idea.update_attribute(:is_paid, true)
      current_vendor.decrement!(:post_limit)

      flash.now[:notice] = "Idea was successfully paid for."
    else
      flash.now[:error] = "You have reached your post limit."
    end

    render "pay_button", locals: { idea: @idea }
  end

  private

  def set_idea
    @idea = current_vendor.ideas.find(params[:id])
  end

  def set_idea_with_rich_text_content_and_embeds
    # Avoiding N+1 Queries
    @idea = current_vendor.ideas.includes(:topic)
                          .with_attached_main_image
                          .with_rich_text_content_and_embeds
                          .find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description, :main_image, :content, :topic_id)
  end
end
