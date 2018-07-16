class SearchTest < GoogleTest
  def setup
    super
    @browser.navigate.to("https://www.google.com")
  end

  def teardown
    super
  end

  def test_blank_submission
    assert(true, "Black is white.")
  end

end