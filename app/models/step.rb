class Step < ActiveRecord::Base
  attr_accessor :complete, :reason, :trace

  belongs_to :scenario
  
  validates_presence_of :expects
  
  default_scope -> { order("ordinal asc") }
  
  before_save :set_description
  
  def set_description
    self.description = case action
    when "visit"
      "Visit \"#{expects}\"."
    when "click_link"
      "Click \"#{expects}\"."
    when "click_button"
      "Click \"#{expects}\"."
    when "fill_in"
      if expects.include? "*"
        "Fill in \"#{target}\" with \"********\"."
      else
        "Fill in \"#{target}\" with \"#{expects}\"."
      end
    when "assert_page_content"
      "Page should contain \"#{expects}\"."
    end
  end
end
