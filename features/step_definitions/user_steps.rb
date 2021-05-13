Given(/^I go to "(.*)" page/) do |path|
  visit(path)
end

Given(/^I logged in as (\w*)/) do |role|
  @current_user = create(:user, admin: role == 'admin')

  step 'I go to "/users/sign_in" page'
  step "I fill user_email field with \"#{@current_user.email}\""
  step 'I fill user_password field with "secret123"'
  step 'I click Log in'
end

When(/^I click (.*)/) do |name|
  click_on name
end

Then(/^I see the popover with ([\w\s]+) title/) do |title|
  within('#modal') do
    page.has_content?(title)
  end
end

When(/^I fill ([\w\d\-_]+) field with "(.*)"/) do |field, value|
  fill_in(field, with: value)
end

And(/^I see (\w+) button/) do |name|
  expect(page.has_content?(name)).to be(true)
end

Then(/I see popover with title ([\w\s]+) is closed/) do |title|
  page.find('#modal', visible: :hidden)
  expect(page.has_content?(title)).to be(false)
end

Then(/^I see the ([\w\s]+) button in the page header$/) do |name|
  within('header') do
    expect(page.has_content?(name)).to be(true)
  end
end

Then(/^I redirected to "(.*)' page/) do |path|
  expect(page.current_path).to eq(path)
end

