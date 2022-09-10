# frozen_string_literal: true

require './db/database'

class BaseModel
  attr_accessor :errors

  def initialize(*params)
    @params = params.first || {}
    @errors = {}
  end

  private

  attr_reader :params

  def conn
    @conn ||= Database.call
  end
end
