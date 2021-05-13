namespace :elastic do

  namespace :articles do

    desc 'Creates articles index'
    task create_index: :environment do
      Article.__elasticsearch__.create_index!
    end

    desc 'Drops articles index'
    task drop_index: :environment do
      Article.__elasticsearch__.delete_index!
    end

    desc 'Reindex articles'
    task reindex: :environment do
      Article.__elasticsearch__.delete_index!
      Article.__elasticsearch__.create_index!
      Article.published.find_each { |article| article.__elasticsearch__.index_document }
    end
  end
end
