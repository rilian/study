db_settings = { adapter: 'postgresql', encoding: 'unicode' }
%i[host port pool database username password].each do |param|
  val = ENV["DB_#{param.upcase}"]
  if val != '' && val != nil
    db_settings.merge!(param => ENV["DB_#{param.upcase}"])
  end
end
ActiveRecord::Base.establish_connection(db_settings)

tables = ActiveRecord::Base.connection.execute("select * from pg_tables where tablename='records'").to_a
if tables.size == 0
  ActiveRecord::Base.connection.execute(File.read(File.join(File.dirname(__FILE__), './structure.sql')))
  puts 'Created "records" table'
end
