require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should_not allow_value("alexjalg@gmail").for(:email)}
  it { should allow_value("alexjalg@gmail.com").for(:email)}
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
end
