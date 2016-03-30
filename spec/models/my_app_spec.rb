require 'rails_helper'

RSpec.describe MyApp, type: :model do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user) }
    it "deberia generar un app_id antes de crear el registro" do
        my_app = FactoryGirl.create(:my_app)
        expect(my_app.app_id).to_not be_nil 
    end
    it "deberia generar un secret_key antes de crear el registro" do
        my_app = FactoryGirl.create(:my_app)
        expect(my_app.secret_key).to_not be_nil
    end
    it "deberia poder encontrar sus propios tokens" do
        
    end
end
