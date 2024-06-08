class Vendors::CommonQuestionsController < Vendors::BaseController
  before_action :set_service, except: %i[ index ]
  before_action :set_common_question, only: %i[ show edit update destroy ]

  def index
    @service = current_vendor.services.includes(:common_questions).find(params[:service_id])
    @common_questions = @service.common_questions.order(id: :desc)
  end

  def show; end

  def edit; end

  def create
    @common_question = @service.common_questions.build(common_question_params)

    if @common_question.save
      flash.now[:notice] = "Common question was successfully created."
    else
      flash_errors_message @common_question, now: true
    end
  end

  def update
    if @common_question.update(common_question_params)
      flash.now[:notice] = "Common question was successfully updated."
    else
      flash_errors_message @common_question, now: true
    end
  end

  def destroy
    @common_question.destroy!

    flash.now[:notice] = "Common question was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_common_question
    @common_question = @service.common_questions.find(params[:id])
  end

  def set_service
    @service = current_vendor.services.find(params[:service_id])
  end

  # Only allow a list of trusted parameters through.
  def common_question_params
    params.require(:common_question).permit(:question, :answer)
  end
end
