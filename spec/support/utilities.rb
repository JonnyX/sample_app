include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def should_have_errors
  it { should have_content('Name can\'t be blank') }
  it { should have_content('Email can\'t be blank') }
  it { should have_content('Email is invalid') }
  it { should have_content('Password can\'t be blank') }
  it { should have_content('Password is too short (minimum is 6 characters)') }
end

def valid_signup
  fill_in "Name",             with: "Example User"
  fill_in "Email",            with: "user@example.com"
  fill_in "Password",         with: "foobar"
  fill_in "Confirm Password", with: "foobar"
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end