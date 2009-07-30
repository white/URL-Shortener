class Link < ActiveRecord::Base
  validates_length_of :url, :minimum => 11, :allow_nil => false, :allow_blank => false
  validates_uniqueness_of :url
  validates_format_of :url, :with => URL_FORMAT
end
