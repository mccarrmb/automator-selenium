require 'selenium-webdriver'
require 'page-object'

class SearchResultsPage
  include PageObject

  text_field(:search_field, name: 'q')
  button(:search, value: 'search')

  def google_search(terms)
    search_field = terms
    search
    SearchResultsPage.new(@browser)
  end

  def search_results; end

  def page_numbers; end

  def choose_page_number(page_number); end
end
