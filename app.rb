# frozen_string_literal: true

require 'json'

# App
class App
  def call(_env)
    status = 200
    headers = { 'Content-Type' => 'application/json' }
    body = [{ greeting: 'Hello, world!' }.to_json]

    [status, headers, body]
  end
end
