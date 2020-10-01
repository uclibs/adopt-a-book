require 'rails_helper'

RSpec.describe Admin, type: :model do
  it 'is valid admin if all required fields are provided' do
    admin = Admin.new(email: 'random@example.com', password: 'random@123')
    expect(admin).to be_valid
  end
  it 'is not valid without a single mandatory field (without email)' do
    admin = Admin.new(password: 'random@123')
    expect(admin).to_not be_valid
  end
  it 'is not valid without a single mandatory field (without password)' do
    admin = Admin.new(email: 'random@example.com')
    expect(admin).to_not be_valid
  end
end
