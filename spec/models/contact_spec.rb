require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject do
    described_class.new(fname: 'john', lname: 'doe', email: 'john@doe.com', phone: 'a12d', message: 'hello')
  end
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an fname' do
      subject.fname = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an lname' do
      subject.lname = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is valid without an phone' do
      subject.phone = nil
      expect(subject).to be_valid
    end

    it 'is not valid without an message' do
      subject.message = nil
      expect(subject).to_not be_valid
    end
  end
end
