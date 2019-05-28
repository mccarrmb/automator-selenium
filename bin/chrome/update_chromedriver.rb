#!/usr/bin/env ruby
# frozen_string_literal: true

require 'net/http'
require 'zip'

DRIVERS = %w[linux64 mac64 win32].freeze

# get latest release number from https://chromedriver.storage.googleapis.com/LATEST_RELEASE

Net::HTTP.start('chromedriver.storage.googleapis.com') do |http|
  @version = http.get('/LATEST_RELEASE').body
end

# get https://chromedriver.storage.googleapis.com/<LATEST_RELEASE_VERSION>/chromedriver_<OS_ARCH>.zip
begin
  DRIVERS.each do |os|
    print "Attempting to download chromedriver for #{os}..."
    STDOUT.flush
    Net::HTTP.start('chromedriver.storage.googleapis.com') do |http|
      resp = http.get("/#{@version}/chromedriver_#{os}.zip")
      open("chromedriver_#{os}.zip", 'wb') do |file|
        file.write(resp.body)
      end
      puts ' complete.'
      # extract all zip files to their directories
      driver_dir = File.join(File.expand_path(__dir__))
      FileUtils.mkdir_p(File.join(driver_dir, os))
      Zip::File.open(File.join(driver_dir, "chromedriver_#{os}.zip")) do |zip_file|
        print "Extracting #{os} chromedriver..."
        zip_file.each do |f|
          fpath = File.join(driver_dir, os, f.name)
          zip_file.extract(f, fpath) unless File.exist?(fpath)
        end
      end
      File.delete(File.join(driver_dir, "chromedriver_#{os}.zip"))
    end
    puts ' complete.'
  end
  puts 'All drivers updated.'
rescue Net::OpenTimeout => e
  puts 'Connection timed out.'
end
