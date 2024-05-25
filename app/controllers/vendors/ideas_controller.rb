class Vendors::IdeasController < Vendors::BaseController
  before_action :set_idea, only: %i[ edit update destroy ]

  # GET /ideas or /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1 or /ideas/1.json
  def show
    # Avoiding N+1 Queries
    @idea = Idea.with_rich_text_content_and_embeds.find(params[:id])
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit; end

  # POST /ideas or /ideas.json
  def create
    # @idea = Idea.new(idea_params)
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

  # PATCH/PUT /ideas/1 or /ideas/1.json
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

  # DELETE /ideas/1 or /ideas/1.json
  def destroy
    @idea.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_ideas_url, notice: "Idea was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def publish
    @idea = current_vendor.ideas.find(params[:id])

    # if the idea is not paid, it can't be published
    unless @idea.is_paid?
      flash.now[:error] = "You need to pay for this idea before publishing it."
      render "toggle_publish", locals: { idea: @idea }
      return
    end

    if @idea.update(published: true)
      flash.now[:notice] = "Idea was successfully published."
    else
      flash.now[:error] = "Something went wrong. Please try again."
    end

    render "toggle_publish", locals: { idea: @idea }
  end

  def unpublish
    @idea = current_vendor.ideas.find(params[:id])

    if @idea.update(published: false)
      flash.now[:notice] = "Idea was successfully unpublished."
    else
      flash.now[:error] = "Something went wrong. Please try again."
    end

    render "toggle_publish", locals: { idea: @idea }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def idea_params
    params.require(:idea).permit(:title, :description, :main_image, :content, :topic_id)
  end
end
