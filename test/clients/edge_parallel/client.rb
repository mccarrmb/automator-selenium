# frozen_string_literal: true

class Client
  PROPERTIES = {
    app: 'app.com',
    protocol: 'https'
  }.freeze

  CAPABILITIES = {
    url: "#{PROPERTIES[:protocol]}//#{PROPERTIES[:app]}",
    browser: :edge,
    platformName: 'any',
    platformVersion: 'any',
    remote: false,
    parallel: true
  }.freeze
end
