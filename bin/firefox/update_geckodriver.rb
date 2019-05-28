#!/usr/bin/env ruby
# frozen_string_literal: true

require 'net/http'
require 'zip'
require 'zlib'
require 'json'

DRIVERS = { linux64: '.tar.gz',
            macos: '.targ.gz',
            win64: '.zip' }.freeze

# get latest release number from json at https://api.github.com/mozilla/geckodriver/releases
release_req = Net::HTTP.new('api.github.com', Net::HTTP.https_default_port)
release_req.use_ssl = true
release_data = release_req.get('/repos/mozilla/geckodriver/releases').body
releases = JSON.parse(release_data)
@version = releases[0]['tag_name']

# get https://github.com/mozilla/geckodriver/releases/download/<LATEST_RELEASE_VERSION>/geckodriver-<LATEST_RELEASE_VERSION>-<OS_ARCH>[.tar.gz|.zip]
def poop
  begin
    DRIVERS.each do |os, archive|
      print "Attempting to download geckodriver for #{os.to_s}..."
      STDOUT.flush
      Net::HTTP.start('github.com') do |http|
        data = http.get("/mozilla/geckodriver/#{@version}/geckodriver-#{@version}-#{os.to_s}#{archive}")
        open("geckodriver-#{@version}-#{os.to_s}#{archive}", 'wb') do |file|
          file.write(data.body)
        end
        puts ' complete.'
        # extract all zip files to their directories
        driver_dir = File.join(File.expand_path(__dir__))
        FileUtils.mkdir_p(File.join(driver_dir, os.to_s))
        if os = :win64
          Zip::File.open(File.join(driver_dir, "geckodriver-#{@version}-#{os.to_s}#{archive}")) do |zip_file|
            print "Extracting #{os} geckodriver..."
            zip_file.each do |f|
              fpath = File.join(driver_dir, os, f.name)
              zip_file.extract(f, fpath) unless File.exist?(fpath)
            end
          end
        else
          unzipper = ZLib::Inflate.new
          buffer = unziiper.inflate()
          open("geckodriver-#{@version}-#{os.to_s}#{archive}", 'wb') do |file|
            file.write()
          end
        end
        File.delete(File.join(driver_dir, "geckodriver-#{@version}-#{os.to_s}#{archive}"))
      end
      puts ' complete.'
    end
    puts 'All drivers updated.'
  rescue Net::OpenTimeout => e
    puts 'Connection timed out.'
  end
end
