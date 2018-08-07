# google-automator

A demo Selenium3 application for automating Google application workflows

## Purpose

Google-Automator is an attempt to address the lack of decent Ruby-based Selenium Webdriver sample projects. The ultimate goal is to demonstrate the creation of a Selenium suite that supports all WebDriver-capable browsers, parallel test execution, Selenium Grid implementation, and proper Page Object design. As this is primarily an educational venture focused on automation principles, _full_ test coverage for Google's application will not be provided.

## Requirements

* __Ruby__ >= 2.5.0
  * Bundler gem ~ 1.16
* __Operating Systems__
  * macOS >= 10.10
  * Linux (kernel >= 3.13)
  * Windows 10 >= 1706 (requires Ubuntu subsystem)
* __Browsers__
  * __Linux__
    * Chrome
    * Firefox
  * __macOS__
    * Chrome
    * Firefox
    * Safari
  * __Windows__
    * Chrome
    * Edge
    * Firefox

## Installation

Clone this repository and then run `bundle` in the project root. Once Bundler finishes installing the required gems, the project can be executed via `bundle exec rake`. If the required browsers are installed, the Google tests should run automatically.
