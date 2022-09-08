# frozen_string_literal: true

require 'rack'
require_relative 'config/router'

use Rack::Reloader

run Router.new
