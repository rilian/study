require 'bundler'
Bundler.require(:default)
Dotenv.load

require_relative 'config.rb'

class Record < ActiveRecord::Base
  self.inheritance_column = nil
  TYPES = %w[article tutorial video book other course conference]
end

get '/' do
  Record::TYPES.each do |type|
    instance_variable_set("@#{type}s".to_sym, Record.where(type: type).order(created_at: :asc).to_a)
  end

  render(:slim, :index)
end

post '/records' do
  records = params[:records].split(/\n+/).reject { |r| r.to_s.strip == '' }
  records.each do |r|
    record = Record.new(url: r, type: params[:type], note: params[:note].to_s.strip)
    if !record.save
      halt 422, record.errors.full_messages.inspect
    end
  end
  redirect '/'
end

patch '/records/:id' do
  record = Record.find(params[:id])
  if record.update(seen: params[:seen] == 'true')
    'OK'
  else
    halt 422, record.errors.full_messages.inspect
  end
end
