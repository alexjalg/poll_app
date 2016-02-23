require 'rails_helper'

RSpec.describe Api::V1::MyPollsController, type: :request do
    
    describe "GET /polls" do
        before :each do
            FactoryGirl.create_list(:my_poll, 10)
            get "/api/v1/polls"
        end
        it { have_http_status(200) }
        it "mande la lista de encuestas" do
            json = JSON.parse(response.body)
            expect(json.length).to eq(MyPoll.count)
        end
    end
    
    describe "GET /polls/:id" do
        before :each do 
            @poll = FactoryGirl.create(:my_poll)
            get "/api/v1/polls/#{@poll.id}"
        end
        it { have_http_status(200) }
        it "manda la encuesta solicitada" do
            json = JSON.parse(response.body) 
            expect(json["id"]).to eq(@poll.id)
        end
        it "manda los atributos de la encuesta" do
            json = JSON.parse(response.body) 
            expect(json.keys).to contain_exactly("id","title","description","user_id","expires_at")
        end
    end
    
end
