# frozen_string_literal: true

require 'pg'
require 'pry'

class Database
  def self.call
    new.call
  end

  def call
    conn
  end

  def migrate
    sql = File.open('db/schema.sql', 'rb', &:read)

    conn.exec sql
  end

  private

  def conn
    @conn ||= PG.connect(
      dbname: ENV['DATABASE_NAME'],
      host: ENV['DATABASE_HOST'],
      port: ENV['DATABASE_PORT'],
      user: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD']
    )
  end
end
