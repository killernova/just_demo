class Article < ApplicationRecord
  belongs_to :user

  def self.cached_search_result(word)
    Rails.cache.fetch "search:#{word}", expires: 1.hour do
      Article.where("title like '%#{word}%'").order(id: :desc).to_a
    end
  end
end
