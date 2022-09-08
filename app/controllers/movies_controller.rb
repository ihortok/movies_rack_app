# frozen_string_literal: true

class MoviesController < AplicationController
  def index
    status = 200
    headers = { 'Content-Type' => 'application/json' }
    body = [{ greeting: 'Hello, world!' }.to_json]

    [status, headers, body]
  end
end
