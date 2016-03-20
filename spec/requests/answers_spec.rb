require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do

  before :each do
    @token = FactoryGirl.create(:token, expires_at: DateTime.now + 1.month )
    @poll = FactoryGirl.create(:poll_with_questions, user: @token.user)
    @question = @poll.questions[0]
  end
  
  let(:valid_params){ {description: "Ruby", question_id: @question.id} }
  
  describe "POST /polls/:poll_id/answers" do
    context "con usuario válido" do
      before :each do
        post api_v1_poll_answers_path(@poll),
          { answer: valid_params, token: @token.token }
      end
      it{ expect(response).to have_http_status(200) }
      it "cambia el contador de respuestas en +1" do
        expect{
          post api_v1_poll_answers_path(@poll),
            { answer: valid_params, token: @token.token }
        }.to change(Answer,:count).by(1)
      end
      it "responde con la respuesta creada" do
        json = JSON.parse(response.body)
        expect(json["description"]).to eq(valid_params[:description])
      end      
    end
    context "con usuario inválido" do
   
    end
  end
  
  describe "PUT/PATCH /polls/:poll_id/answers/:id" do

  end
  
  
  describe "DELETE /polls/:poll_id/answers/:id" do
    
  end
  
end
