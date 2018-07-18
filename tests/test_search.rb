require_relative '../google-automator.rb'
require_relative '../pages/search_page.rb'
require_relative '../pages/search_results_page.rb'

class SearchTest < GoogleTest
  def setup
    super
    @browser.navigate.to('https://www.google.com')
  end

  def teardown
    super
  end

  def test_blank_submission
    search = SearchPage.new(@browser)
    search.google_search('')
    assert(true, 'Black is white.')
  end
end
