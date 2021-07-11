require 'rails_helper'

RSpec.describe('contacts/new', type: :view) do
  before(:each) do
    assign(:contact, Contact.new(
                       fname: 'MyString',
                       lname: 'MyText',
                       email: 'MyString',
                       phone: 'MyString',
                       message: 'MyString'
                     ))
  end

  it 'renders new contact form' do
    render
    assert_select 'form[action=?][method=?]', contacts_path, 'post' do
      assert_select 'input[name=?]', 'contact[fname]'
      assert_select 'input[name=?]', 'contact[lname]'
      assert_select 'input[name=?]', 'contact[email]'
      assert_select 'input[name=?]', 'contact[phone]'
      assert_select 'textarea[name=?]', 'contact[message]'
    end
  end
end
