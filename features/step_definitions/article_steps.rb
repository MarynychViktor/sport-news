Then(/^I see first 25 articles for given category$/) do
  %r{categories/(.+)/articles}.match current_path

  Category.find($1).articles.take(25).each do |article|
    expect(page.has_content?(article.headline.slice(0, 25))).to be_truthy
  end

  # find('._subcategory_id .select2-container').click
  # find('.select2-dropdown .select2-results__option').click
end
