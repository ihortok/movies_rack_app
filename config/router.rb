# frozen_string_literal: true

require 'pry'
require 'json'

require './app/controllers/application_controller'
require './app/controllers/movies_controller'
require './db/database'

class Router
  ACTION_MAPPER = {
    root: 'Aplication#index',
    get_movies: 'Movies#index',
    get_one_of_movies: 'Movies#show',
    post_movies: 'Movies#create',
    patch_one_of_movies: 'Movies#update',
    delete_one_of_movies: 'Movies#destroy'
  }.freeze

  def call(env)
    req = Rack::Request.new(env)
    method = env['REQUEST_METHOD']
    path = req.path.split('/')

    params = { filters: Rack::Utils.parse_nested_query(env['QUERY_STRING']) }
    params[:id] = path[2] if path[2]
    params[:record_params] = req.params if req.post? || req.patch?

    action = if path.empty?
               :root
             elsif path.size == 2
               "#{method.downcase}_#{path[1]}"
             elsif path.size == 3 && path[2].to_i.positive?
               "#{method.downcase}_one_of_#{path[1]}"
             elsif path.size == 4 && path[2].to_i.positive?
               "#{method.downcase}_one_of_#{path[1]}_#{path[3]}"
             end&.to_sym

    return AplicationController.not_found unless ACTION_MAPPER.key? action

    controller = "#{ACTION_MAPPER[action].split('#').first}Controller"
    action = ACTION_MAPPER[action].split('#').last

    Object.const_get(controller).new(params).public_send action
  end
end
