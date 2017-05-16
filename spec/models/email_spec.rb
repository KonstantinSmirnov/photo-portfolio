require 'rails_helper'

RSpec.describe Email, type: :model do
  let(:email) { FactoryGirl.build(:email) }
  let!(:admin) { FactoryGirl.create(:admin) }

  it "has a valid factory" do
    expect(email).to be_valid
  end

  it "is invalid without name" do
    email.name = ''

    expect(email).to be_invalid
    expect(email.errors[:name]).to include("поле не заполнено")
  end

  it "is invalid wihtout email" do
    email.email = ''

    expect(email).to be_invalid
    expect(email.errors[:email]).to include("поле не заполнено")
  end

  it "is invalid wihtout topic" do
    email.topic = ''

    expect(email).to be_invalid
    expect(email.errors[:topic]).to include("поле не заполнено")
  end

  it "is invalid without message" do
    email.message = ''

    expect(email).to be_invalid
    expect(email.errors[:message]).to include("поле не заполнено")
  end

  it 'sends an email' do
    expect { email.send_contact_email }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
