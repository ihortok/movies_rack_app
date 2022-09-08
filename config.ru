# frozen_string_literal: true

require_relative 'app'
require 'rack'

use Rack::Reloader

run App.new
