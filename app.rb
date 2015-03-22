require 'bundler'
Bundler.require(:default)
Dotenv.load

require_relative 'config.rb'

class Record < ActiveRecord::Base
  self.inheritance_column = nil
  TYPES = %w[article tutorial video book other]
end

get '/' do
  Record::TYPES.each do |type|
    instance_variable_set("@#{type}s".to_sym, Record.where(type: type).order(created_at: :desc).to_a)
  end

  render(:slim, :index)
end

post '/records' do
  params[:records].split(/[\n\r]+/).each do |r|
    puts "PARAMS url=#{r} type=#{params[:type]}"
    record = Record.new(url: r, type: params[:type])
    if !record.save
      halt 422, record.errors.full_messages.inspect
    end
  end
  redirect '/'
end
