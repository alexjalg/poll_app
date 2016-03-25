require 'rails_helper'

RSpec.describe Api::V1::MyPollsController, type: :request do

    describe "GET /polls" do
        before :each do
            FactoryGirl.create_list(:my_poll, 10)
            get "/api/v1/polls"
        end
        it{ expect(response).to have_http_status(200)}
        it "mande la lista de encuestas" do
            puts "\n\n #{response.body} \n\n"
            json = JSON.parse(response.body)
            expect(json.length).to eq(MyPoll.count)
        end
    end

    describe "GET /polls/:id" do
        before :each do
            @poll = FactoryGirl.create(:my_poll)
            get "/api/v1/polls/#{@poll.id}"
        end
        it{ expect(response).to have_http_status(200)}
        it "manda la encuesta solicitada" do
            json = JSON.parse(response.body)
            expect(json["id"]).to eq(@poll.id)
        end
        it "manda los atributos de la encuesta" do
            json = JSON.parse(response.body)
            expect(json.keys).to contain_exactly("id","title","description","user_id","expires_at")
        end
    end

    describe "POST /polls" do
      context "con token válido" do
        before :each do
          @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
          post "/api/v1/polls", {token: @token.token, poll: {title: "Hola mundo", description: "asdasdasd qqawsd qwd qwd qwdq", expires_at: DateTime.now}}
        end
        it{ expect(response).to have_http_status(200)}
        # it { change(MyPoll,:count).by(1) }  esto no funca, por eso es bueno que las pruebas escritas en un principio fallen
        it "crea una nueva encuesta" do
          expect{
            post "/api/v1/polls", {token: @token.token, poll: {title: "Hola mundo", description: "asdasdasd qqawsd qwd qwd qwdq", expires_at: DateTime.now}}
          }.to change(MyPoll,:count).by(1)
        end
        it "responde con la encuesta creada" do
          json = JSON.parse(response.body)
          expect(json["title"]).to eq("Hola mundo")
        end

      end
      context "con token inválido" do
        before :each do
          post "/api/v1/polls"
        end
      end
      context "unvalid params" do
          before :each do
              @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
              post "/api/v1/polls", {token: @token.token, poll: {title: "Hola mundo", expires_at: DateTime.now}}
          end
          it{ expect(response).to have_http_status(422)}
          it "responde con los errores al guardar la encuesta" do
               json = JSON.parse(response.body)
               expect(json["errors"]).to_not be_empty
          end
      end
  end
  describe "PATCH /polls/:id" do
    context "con token válido" do
      before :each do
        @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
        @poll = FactoryGirl.create(:my_poll, user: @token.user)
        patch api_v1_poll_path(@poll), {token: @token.token, poll: { title: "Nuevo titulo"}}
      end
      it{ expect(response).to have_http_status(200)}
      it "actualiza la encuesta indicada" do
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Nuevo titulo")
      end
    end
    context "con token inválido" do
      before :each do
        @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
        @poll = FactoryGirl.create(:my_poll, user: FactoryGirl.create(:dummy_user))
        patch api_v1_poll_path(@poll), {token: @token.token, poll: { title: "Nuevo titulo"}}
      end
      it{ expect(response).to have_http_status(401)}
    end
  end
  describe "DELETE /polls/:id" do
    context "con token válido" do
      before :each do
        @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
        @poll = FactoryGirl.create(:my_poll, user: @token.user)
      end
      it{
        delete api_v1_poll_path(@poll), {token: @token.token}
        expect(response).to have_http_status(200)
      }
      it "elimina la encuesta indicada" do
        expect{
          delete api_v1_poll_path(@poll), { token: @token.token }
        }.to change(MyPoll, :count).by(-1)
      end
    end
    context "con token inválido" do
      before :each do
        @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
        @poll = FactoryGirl.create(:my_poll, user: FactoryGirl.create(:dummy_user))
        delete api_v1_poll_path(@poll), {token: @token.token}
      end
      it{ expect(response).to have_http_status(401)}
    end
  end
end
