class Vendors::CommonQuestionsController < Vendors::BaseController
  before_action :set_common_question, only: %i[ show edit update destroy ]
  before_action :set_service

  def index
    @common_questions = CommonQuestion.all
  end

  def show; end

  def edit
  end

  def create
    @common_question = @service.common_questions.create(common_question_params)


    respond_to do |format|
      if @common_question.save
        format.html do
          redirect_to vendor_service_questions_url(params[:service_id]),
                      notice: "Common question was successfully created."
        end
        format.json { render :show, status: :created, location: @common_question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @common_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @common_question.update(common_question_params)
        format.html do
          redirect_to vendor_service_question_url(params[:service_id], @common_question),
                      notice: "Common question was successfully updated."
        end
        format.json { render :show, status: :ok, location: @common_question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @common_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @common_question.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_service_questions_url(params[:service_id]), notice: "Common question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_common_question
    @common_question = CommonQuestion.find(params[:id])
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  # Only allow a list of trusted parameters through.
  def common_question_params
    params.require(:common_question).permit(:question, :answer)
  end
end
