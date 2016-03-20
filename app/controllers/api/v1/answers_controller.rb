class Api::V1::AnswersController < ApplicationController

  before_action :authenticate, except: [ :index,:show ]
  before_action :set_answer, only: [ :update,:destroy ]
  before_action :set_poll
  before_action( only: [:update,:destroy,:create] ) { |c| c.authenticate_owner(@poll.user) }

  #POST /polls/1/answers
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      render template: "api/v1/answers/show"
    else
      render json: {error: @answer.errors }, status: :unprocessable_entity
    end
  end

  #PATCH PUT /polls/1/answers/1
  def update
    if @question.update(question_params)
      render template: "api/v1/answers/show"
    else
      render json: {error: @question.errors }, status: :unprocessable_entity
    end
  end

  #DELETE /polls/1/answers/1
  def destroy
    @question.destroy
    head :ok
  end

  private
  def answer_params
    params.require(:answer).permit(:description, :question_id)
  end
  def set_poll
    @poll = MyPoll.find(params[:poll_id])
  end
  def set_answer
    @question = Answer.find(params[:id])
  end
end
