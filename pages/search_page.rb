require 'selenium-webdriver'
require 'page-object'

class SearchPage
  include PageObject
  
  text_field(:search_field, name: 'q')
  button(:search, value: 'Google Search')
  button(:lucky, value: 'I\'m Feeling Lucky')

  def google_search(terms)
    search_field = terms
    search
    if (terms.empty?)
      SearchPage.new(@browser)
    else
      SearchResultsPage.new(@browser)
    end
  end
end
