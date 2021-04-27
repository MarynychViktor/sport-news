Given(/^I go to "(.*)" page/) do |path|
  visit(path)
end

When(/^I click (.*)/) do |name|
  click_on name
end

Then(/^I see the popover with ([\w\s]+) title/) do |title|
  within('#modal') do
    page.has_content?(title)
  end
end

And(/^I see (\w+) button/) do |name|
  expect(page.has_content?(name)).to be(true)
end

Then(/I see popover with title ([\w\s]+) is closed/) do |title|
  page.find('#modal', visible: :hidden)
  expect(page.has_content?(title)).to be(false)
end
