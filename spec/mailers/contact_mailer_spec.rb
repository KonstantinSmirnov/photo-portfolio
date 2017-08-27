require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
  describe 'instructions' do
    let!(:admin) { FactoryGirl.create(:admin) }
    let(:email) { FactoryGirl.build(:email) }
    let(:sent_email) { FactoryGirl.build(:email).send_contact_email }

    it 'renders the subject' do
      expect(sent_email.subject).to eq('Letter from photopage')
    end

    it 'renders the receiver email' do
      expect(sent_email.to).to eq([admin.email.to_s])
    end

    it 'renders the sender email' do
      expect(sent_email.from).to eq(['photo@smiplay.com'])
    end

    it 'contains header' do
      expect(sent_email.body.encoded).to match('Hi! You have a new letter from photo page')
    end

    it 'contains name' do
      expect(sent_email.body.encoded).to match(email.name)
    end

    it 'contains email' do
      expect(sent_email.body.encoded).to match(email.email)
    end

    it 'contains topic' do
      expect(sent_email.body.encoded).to match(email.topic)
    end

    it 'contains message' do
      expect(sent_email.body.encoded).to match(email.message)
    end
  end
end
