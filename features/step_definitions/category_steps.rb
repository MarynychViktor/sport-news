Given('I open new category modal') do
  self.categories_count = Category.count
  click_on '+ Add category'
end

Given(/I type the category name ([\w\s]+)/) do |name|
  fill_in('category_name', with: name)
end

And(/^the category is added/) do
  expect(Category.count).to be(categories_count + 1)
end

And(/^the category is not added/) do
  expect(Category.count).to be(categories_count)
end

And(/^I see this category with ([\w\s]+) name at the top of the list/) do |name|
  top_category = first('.categorized-item__content')
  expect(top_category.text).to eq(name)
end
