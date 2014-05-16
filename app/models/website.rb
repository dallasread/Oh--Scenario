class Website < ActiveRecord::Base
  has_many :scenarios, dependent: :destroy
  
  before_save :remove_last_slash
  
  def remove_last_slash
    self.default_url = default_url.gsub(/\/$/, "")
  end
end
