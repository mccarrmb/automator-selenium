# frozen_string_literal: true

require 'selenium-webdriver'
require 'page-object'
require 'page_object_base'

class SearchResultsPage < PageObjectBase
  include PageObject

  text_field(:search_field, name: 'q')
  button(:search, value: 'search')

  def google_search(terms)
    search_field.click
    @browser.action.send_keys(terms).perform
    search
    if terms.empty?
      SearchPage.new(@browser)
    else
      SearchResultsPage.new(@browser)
    end
  end

  def search_results; end

  def page_numbers; end

  def choose_page_number(page_number); end
end
