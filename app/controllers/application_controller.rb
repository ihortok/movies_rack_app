# frozen_string_literal: true

class AplicationController
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def index
    [
      200,
      { 'Content-Type' => 'text/plain' },
      ['Hello, world!']
    ]
  end

  def not_found
    [
      404,
      { 'Content-Type' => 'text/plain' },
      ['404 not found']
    ]
  end

  def self.not_found
    new.not_found
  end
end
