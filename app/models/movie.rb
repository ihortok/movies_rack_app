# frozen_string_literal: true

require_relative 'base_model'

class Movie < BaseModel
  def all
    res = conn.exec 'select * from movies'
    all = []
    i = 0

    loop do
      all << res[i]
      i += 1
    rescue IndexError
      break
    end

    all
  end

  def find
    conn.exec("select * from movies where id = #{params[:id]} limit 1").first
  end

  def create
    begin
      if params.key?('title') && params['title'].size.positive?
        conn.exec("insert into movies (title) values ('#{params['title']}')")
      else
        (errors['title'] ||= []) << "can't be blank"
      end
    rescue StandardError => e
      (errors['base'] ||= []) << e
    end

    self
  end

  def update
    begin
      if params.key?('title')
        if params['title'].to_s.strip.size.zero?
          (errors['title'] ||= []) << "can't be blank"
        else
          conn.exec("update movies set title = '#{params['title']}' where id = #{params[:id]};")
        end
      end
    rescue StandardError => e
      (errors['base'] ||= []) << e
    end

    self
  end

  def destroy
    conn.exec("delete from movies where id = #{params[:id]}")
  end

  instance_methods(false).each do |method|
    define_singleton_method method do |*args|
      new(*args).public_send method
    end
  end
end
