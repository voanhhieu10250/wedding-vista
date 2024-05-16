require "test_helper"

class CommonQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @common_question = common_questions(:one)
  end

  test "should get index" do
    get common_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_common_question_url
    assert_response :success
  end

  test "should create common_question" do
    assert_difference("CommonQuestion.count") do
      post common_questions_url, params: { common_question: { answer: @common_question.answer, question: @common_question.question } }
    end

    assert_redirected_to common_question_url(CommonQuestion.last)
  end

  test "should show common_question" do
    get common_question_url(@common_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_common_question_url(@common_question)
    assert_response :success
  end

  test "should update common_question" do
    patch common_question_url(@common_question), params: { common_question: { answer: @common_question.answer, question: @common_question.question } }
    assert_redirected_to common_question_url(@common_question)
  end

  test "should destroy common_question" do
    assert_difference("CommonQuestion.count", -1) do
      delete common_question_url(@common_question)
    end

    assert_redirected_to common_questions_url
  end
end
