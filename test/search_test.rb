require 'test_base.rb'
require 'search_page.rb'
require 'search_results_page.rb'

class SearchTest < TestBase
  def setup
    super
    @browser.navigate.to(@google.app_url)
  end

  def teardown
    super
  end

  def test_searching_terms_from_data_file
    current_line = 0
    CSV.foreach(@test_data << 'valid_search_terms.csv') do |row|
      if current_line > 0
        @browser.navigate.to(@google.app_url)
        search = SearchPage.new(@browser)
        search_result = search.google_search(row[0])
        assert(search_result.is_a?(SearchResultsPage), 'Browser not displaying results page.')
      end
      current_line += 1
    end
  end
end
