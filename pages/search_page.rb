require 'selenium-webdriver'
require 'page-object'

class SearchPage
  include PageObject
  
  text_field(:search_field, name: "q")
  button(:search, value: "Google Search")
  button(:lucky, value: "I'm Feeling Lucky")

  def google_search(terms)
    self.search_field = terms
    self.search
    return SearchResultsPage.new(@browser)
  end

end