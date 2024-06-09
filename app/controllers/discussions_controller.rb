class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_discussion, only: %i[ edit update destroy ]

  # GET /discussions or /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1 or /discussions/1.json
  def show
    @discussion = Discussion.find(params[:id])
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
  end

  # GET /discussions/1/edit
  def edit; end

  # POST /discussions or /discussions.json
  def create
    @discussion = current_user.discussions.build(discussion_params)

    if @discussion.save
      redirect_to forum_discussion_url(@discussion.forum, @discussion), notice: "Discussion was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /discussions/1 or /discussions/1.json
  def update
    if @discussion.update(discussion_params)
      redirect_to forum_discussion_url(@discussion.forum, @discussion), notice: "Discussion was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /discussions/1 or /discussions/1.json
  def destroy
    @discussion.destroy!
    redirect_to forum_discussions_url(@discussion.forum), notice: "Discussion was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = current_user.discussions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def discussion_params
    params.require(:discussion).permit(:forum_id, :user_id, :title, :body)
  end
end
