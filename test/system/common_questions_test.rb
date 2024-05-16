require "application_system_test_case"

class CommonQuestionsTest < ApplicationSystemTestCase
  setup do
    @common_question = common_questions(:one)
  end

  test "visiting the index" do
    visit common_questions_url
    assert_selector "h1", text: "Common questions"
  end

  test "should create common question" do
    visit common_questions_url
    click_on "New common question"

    fill_in "Answer", with: @common_question.answer
    fill_in "Question", with: @common_question.question
    click_on "Create Common question"

    assert_text "Common question was successfully created"
    click_on "Back"
  end

  test "should update Common question" do
    visit common_question_url(@common_question)
    click_on "Edit this common question", match: :first

    fill_in "Answer", with: @common_question.answer
    fill_in "Question", with: @common_question.question
    click_on "Update Common question"

    assert_text "Common question was successfully updated"
    click_on "Back"
  end

  test "should destroy Common question" do
    visit common_question_url(@common_question)
    click_on "Destroy this common question", match: :first

    assert_text "Common question was successfully destroyed"
  end
end
