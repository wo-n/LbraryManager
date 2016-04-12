class News < ActiveRecord::Base
  attr_accessible :news_id, :title, :body, :released_at, :member_id
end
