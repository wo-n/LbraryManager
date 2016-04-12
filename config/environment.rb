# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LibraryManager::Application.initialize!

Amazon::Ecs.options = { #api_key
  :associate_tag => 'amaapi100-22',
  :AWS_access_key_id => 'AKIAIBIQJ6ICPFZUVQUQ',
  :AWS_secret_key => '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',
  :country => 'jp'
  #:idType => 'ISBN'
  #:SearchIndex => 'Books'
}
