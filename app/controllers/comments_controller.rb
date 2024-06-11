class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :set_comment, only: %i[ edit update destroy show ]


  def show
    render :show, layout: false
  end

  def edit
    render :edit, layout: false
  end

  def create
    @discussion = Discussion.includes(:comments).find(params[:discussion_id])
    @comment = Comment.new(comment_params.merge(user: current_user, discussion: @discussion))

    if @comment.save
      flash.now[:notice] = "Comment was successfully created."
    else
      flash_errors_message @comment, now: true
    end

    @discussion.reload
  end

  def update
    if @comment.update(comment_params)
      flash.now[:notice] = "Comment was successfully updated."
    else
      flash_errors_message @comment, now: true
    end

    @discussion = @comment.discussion
  end

  def destroy
    @comment.destroy!
    @discussion = @comment.discussion
    flash.now[:notice] = "Comment was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
