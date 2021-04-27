When(/^on the sign-up page I entered (.*) for (.*)/) do |value, field|
  fill_in("user_#{field}", with: value)
end

Then(/I see the error message "(.*)"/) do |message|
  page.has_content?(message)
end

When('I complete the sign-up form with valid data') do
  fill_in("user_first_name", with: 'John')
  fill_in("user_last_name", with: 'Smith')
  fill_in("user_email", with: 'john_smith@gmail.com')
  page.attach_file(Rails.root.join('spec/stub/uploads/test.jpeg').to_s) do
    page.find('#user_photo').click
  end
  fill_in("user_password", with: 'Backspace_123')
  fill_in("user_password_confirmation", with: 'Backspace_123')
end