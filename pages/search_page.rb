# frozen_string_literal: true

require 'selenium-webdriver'
require 'page-object'
require 'page_object_base'
require 'pry'
require 'search_results_page'

# Page object for the Google landing page
class SearchPage < PageObjectBase
  include PageObject

  text_field(:search_field, name: 'q')
  button(:search, value: 'Google Search')
  button(:lucky, value: 'I\'m Feeling Lucky')

  def google_search(terms)
    search_field
    @browser.action.send_keys(terms).perform
    search
    if terms.empty?
      SearchPage.new(@browser)
    else
      SearchResultsPage.new(@browser)
    end
  end
end
