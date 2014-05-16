class Step < ActiveRecord::Base
  attr_accessor :complete, :reason, :trace

  belongs_to :scenario
  has_one :website, through: :scenario
  
  validates_presence_of :action
  
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
      if expects[0] == "*"
        "Fill in \"#{target}\" with \"********\"."
      else
        "Fill in \"#{target}\" with \"#{expects}\"."
      end
    when "fill_in"
      "Select \"#{expects}\" from \"#{target}\""
    when "confirm"
      "Confirm popup alert"
    when "sleep"
      "Wait for #{expects.to_f} seconds"
    when "not_assert_page_content"
      "Page should not contain \"#{expects}\"."
    when "assert_page_content"
      "Page should contain \"#{expects}\"."
    end
  end
end
