class Website < ActiveRecord::Base
  has_many :scenarios, dependent: :destroy
end
