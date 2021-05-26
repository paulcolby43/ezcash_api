namespace :db do
  desc "Checks whether the database exists or not"
  task :exists do
    begin
      # Tries to initialize the application.
      # It will fail if the database does not exist
      Rake::Task['environment'].invoke
      ActiveRecord::Base.connection
    rescue
      # puts 'no database found'
      exit 1
    else
     # puts 'database found'
      exit 0
    end
  end
end