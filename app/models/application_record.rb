class ApplicationRecord < ActiveRecord::Base
  include SoftDelete
  self.abstract_class = true
end
