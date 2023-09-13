require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'user@example.com', password: '12345678', role: 1)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should be invalid' do
    @user.save
    @user2 = User.new(email: 'user@example.com', password: '87654321', role: 2)
    assert_not @user2.valid?
  end
end
