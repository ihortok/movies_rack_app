# frozen_string_literal: true

require 'pry'
require 'json'

require './app/controllers/application_controller'
require './app/controllers/movies_controller'

class Router
  ACTION_MAPPER = {
    root: 'Aplication#index',
    get_movies: 'Movies#index'
  }.freeze

  def call(env)
    path = env['REQUEST_PATH'].split('/')

    params = { filters: Rack::Utils.parse_nested_query(env['QUERY_STRING']) }
    params[:id] = path[2] if path[2]

    action = if path.empty?
               :root
             elsif path.size == 2
               "#{env['REQUEST_METHOD'].downcase}_#{path[1]}"
             elsif path.size == 3 && path[2].to_i.positive?
               "#{env['REQUEST_METHOD'].downcase}_#{path[1]}"
             elsif path.size == 4 && path[2].to_i.positive?
               "#{env['REQUEST_METHOD'].downcase}_#{path[1]}_#{path[3]}"
             end&.to_sym

    return [404, { 'Content-Type' => 'plain/text' }, ['not found']] unless ACTION_MAPPER.key? action

    controller = "#{ACTION_MAPPER[action].split('#').first}Controller"
    action = ACTION_MAPPER[action].split('#').last

    Object.const_get(controller).new(params).public_send action
  end
end
