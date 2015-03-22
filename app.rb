require 'sinatra'
require 'slim'
require 'byebug'

get '/' do 
  render :slim, :index
end

