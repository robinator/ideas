require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  tests UserMailer
  test 'signup_notification' do
    user = users(:quentin)
    @expected.from    = 'idealogue@varietyour.com'
    @expected.to      = "#{user.login} <#{user.email}>"
    @expected.subject = 'Thanks for signing up!'
    @expected.body    = read_fixture('signup_notification')
    @expected.date    = Time.now
    
    assert_equal @expected.encoded, UserMailer.create_signup_notification(user).encoded
  end
  
  test 'forgot_password' do
    user = users(:quentin)
    @expected.from    = 'idealogue@varietyour.com'
    @expected.to      = "#{user.login} <#{user.email}>"
    @expected.subject = 'Password Recovery'
    @expected.body    = read_fixture('forgot_password')
    @expected.date    = Time.now
    
    assert_equal @expected.encoded, UserMailer.create_forgot_password(user, 'monkey').encoded
  end
end