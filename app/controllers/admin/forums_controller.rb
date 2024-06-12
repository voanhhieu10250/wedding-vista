class Admin::ForumsController < ApplicationController
  before_action :set_forum, only: %i[ show edit update destroy ]

  # GET /forums or /forums.json
  def index
    @forums = Forum.all
    @discussions = Discussion.with_rich_text_body.order(id: :desc).limit(4)
  end

  # GET /forums/1 or /forums/1.json
  def show
    @forums = Forum.all
    @discussions = @forum.discussions.with_rich_text_body.order(id: :desc)

    @pagy, @discussions = pagy(@discussions, item: 10)
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit; end

  # POST /forums or /forums.json
  def create
    @forum = Forum.new(forum_params)

    if @forum.save
      redirect_to admin_forum_url(@forum), notice: "Forum was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /forums/1 or /forums/1.json
  def update
    if @forum.update(forum_params)
      redirect_to admin_forum_url(@forum), notice: "Forum was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /forums/1 or /forums/1.json
  def destroy
    @forum.destroy!
    redirect_to admin_forums_url, notice: "Forum was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forum
    @forum = Forum.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def forum_params
    params.require(:forum).permit(:title, :description, :image)
  end
end
