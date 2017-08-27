require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    admin = FactoryGirl.create(:admin)

    expect(admin).to be_valid
  end

  it 'is invalid without email' do
    admin = FactoryGirl.build(:admin, email: '')

    expect(admin).to be_invalid
    expect(admin.errors[:email]).to include('поле не заполнено')
  end

  it 'is invalid without a password' do
    admin = FactoryGirl.build(:admin, password: '')

    expect(admin).to be_invalid
    expect(admin.errors[:password]).to include('минимум 3 символа')
  end

  it 'is invalid without a password confirmation' do
    admin = FactoryGirl.build(:admin, password_confirmation: '')

    expect(admin).to be_invalid
    expect(admin.errors[:password_confirmation]).to include('поле не заполнено')
  end

  it 'is invalid if password and password confirmation do not match' do
    admin = FactoryGirl.build(:admin, password_confirmation: 'not_match')

    expect(admin).to be_invalid
    expect(admin.errors[:password_confirmation]).to include('не совпадает с паролем')
  end

  it 'is invalid if duplicates email address' do
    admin = FactoryGirl.create(:admin)
    admin_2 = FactoryGirl.build(:admin)

    expect(admin_2).to be_invalid
    expect(admin_2.errors[:email]).to include('уже было использовано')
  end

  it 'is valid with email, password and password confirmation' do
    admin = FactoryGirl.create(:admin)

    expect(admin).to be_valid
  end

  describe 'Update' do
    it 'updates if we provide a new password' do
      admin = FactoryGirl.create(:admin)
      crypted_password_old = admin.crypted_password

      admin.password = 'new_password'
      admin.password_confirmation = 'new_password'
      admin.save!

      expect(admin).to be_valid
      expect(admin.crypted_password).not_to eq(crypted_password_old)
    end

    it 'is invalid without password confirmation' do
      admin = FactoryGirl.create(:admin)

      admin.password = 'new_password'
      admin.password_confirmation = ''

      expect(admin).to be_invalid
      expect(admin.errors[:password_confirmation]).to include('поле не заполнено')
    end

    it 'is invalid if password and password confirmation do not match' do
      admin = FactoryGirl.create(:admin)

      admin.password = 'new_password'
      admin.password_confirmation = 'another_new_password'

      expect(admin).to be_invalid
      expect(admin.errors[:password_confirmation]).to include('не совпадает с паролем')
    end
  end
end
