class Scenario < ActiveRecord::Base
  include Capybara::DSL
  
  belongs_to :website
  has_many :steps
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: proc { |s| s[:action].blank? }
  
  validates_presence_of :website, :name
  
  scope :passing, -> { where latest_result: true }
  scope :failing, -> { where latest_result: false }
  
  def run
    pass = true
      
  	begin
      Capybara.current_driver = :webkit
      Capybara.reset_sessions!
      
      sts = steps.order("ordinal asc")
      
      sts.each do |step|
        case step.action
        when "visit"
          if step.expects.include? "http"
            visit step.expects
          else
            visit "#{step.website.default_url}#{step.expects}"
          end
        when "click_link"
          a = page.all("a", text: step.expects, visible: true).first
          a ? a.click : raise(TypeError, "Link was not found on the page.")
        when "click_button"
          click_button step.expects
        when "fill_in"
          fill_in step.target, with: step.expects.gsub(/^\*/, "")
        when "select"
          select(step.expects, from: step.target)
        when "sleep"
          sleep step.expects.to_f
        when "confirm"
          page.driver.accept_js_confirms!
        when "not_assert_page_content"
          step.complete = !page.source.include?(step.expects)
          raise TypeError, "Text was found on the page." unless step.complete
        when "assert_page_content"
          step.complete = page.source.include? step.expects
          raise TypeError, "Text was not found on the page." unless step.complete
        end

        step.complete = true
      end
    rescue => e
      sts.each do |s|
        if pass && !s.complete
          s.reason = e
          s.trace = page.source if s.action == "assert_page_content"
          pass = false
        end
      end
    end
    
    update_columns latest_result: pass, latest_result_at: Time.zone.now
        
    { pass: pass, steps: sts }
  end
end
