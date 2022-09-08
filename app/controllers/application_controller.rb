# frozen_string_literal: true

class AplicationController
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def index
    status = 200
    headers = { 'Content-Type' => 'plain/text' }
    body = ['Hello, world!']

    [status, headers, body]
  end
end
