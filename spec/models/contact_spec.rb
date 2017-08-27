require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'has a valid factory' do
    contact = FactoryGirl.build(:contact)

    expect(contact).to be_valid
  end

  describe 'Create' do
    it 'is invalid without image' do
      contact = FactoryGirl.build(:contact, image: '')

      expect(contact).to be_invalid
      expect(contact.errors[:image]).to include('поле не заполнено')
    end

    it 'is invalid wihtout text' do
      contact = FactoryGirl.build(:contact, text: '')

      expect(contact).to be_invalid
      expect(contact.errors[:text]).to include('поле не заполнено')
    end

    it 'is valid with correct data' do
      contact = FactoryGirl.build(:contact)

      expect(contact).to be_valid
    end
  end

  describe 'Update' do
    let(:contact) { FactoryGirl.create(:contact) }

    it 'is invalid without text' do
      contact.text = ''

      expect(contact).to be_invalid
      expect(contact.errors[:text]).to include('поле не заполнено')
    end

    it 'is valid with correct data' do
      contact.text = 'valid text'

      expect(contact).to be_valid
    end
  end
end
