require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do

  before :each do
    @token = FactoryGirl.create(:token, expires_at: DateTime.now + 1.month )
    @poll = FactoryGirl.create(:poll_with_questions, user: @token.user)

  end
  describe "GET /polls/:poll_id/questions" do
    before :each do
      get "/api/v1/polls/#{@poll.id}/questions"
    end
    it{ expect(response).to have_http_status(200)}
    it "mande la lista de preguntas para la encuesta" do
      json = JSON.parse(response.body)
      expect(json.length).to eq(@poll.questions.count)
    end
    it "mande la descripcion y el id de una pregunta" do
      json = JSON.parse(response.body)
      question = json[0]
      expect(question.keys).to contain_exactly("id", "description")
    end
  end
  describe "POST /polls/:poll_id/questions" do
    context "con usuario válido" do
      before :each do
        post api_v1_poll_questions_path(@poll),
          { question: { description: "Cual es tu lenguaje favorita?"}, 
            token: @token.token }
      end
      it{ expect(response).to have_http_status(200)}
      it "cambia el número de preguntas +1" do
        expect{
          post api_v1_poll_questions_path(@poll),
            { question: { description: "Cual es tu lenguaje favorita?"},
              token: @token.token }
        }.to change(Question, :count).by(1)
      end
      it "responde con la pregunta creada" do
        json = JSON.parse(response.body)
        expect(json["description"]).to eq("Cual es tu lenguaje favorita?")
      end
    end
    context "con usuario inválido" do
    end
  end
end
