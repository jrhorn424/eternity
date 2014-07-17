namespace :db do

  desc "drops, creates, migrates, and seeds database"
  task :nuke_pave => :environment do
    unless Rails.env == "Production"
      Rake::Task["db:drop"].invoke
      logfile = Rails.root.join("log", "#{Rails.env}.log").to_s
      `rm #{logfile}`
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
      Rake::Task["db:seed"].invoke
      Rake::Task["db:sample"].invoke
      Rake::Task["db:sample"].invoke if ["development"].include?(Rails.env)
      puts "Nuke and pave of #{Rails.env} complete."
    end
  end

  desc "Drop drafts shadow database"
  task :drop_draft do
    with_env("draft_#{Rails.env}") do
      Rake::Task["db:drop"].execute
    end
    puts 'Dropped drafts database'
  end
  task :drop => [:environment, :drop_draft] do
  end

  desc "Create drafts shadow database"
  task :create_draft do
    with_env("draft_#{Rails.env}") do
      Rake::Task["db:create"].execute
    end
    puts 'Created drafts database'
  end
  task :create => [:environment, :create_draft] do
  end

  desc "Migrate drafts shadow database"
  task :migrate_draft do
    with_env("draft_#{Rails.env}") do
      Rake::Task["db:migrate"].execute
      puts 'Migrated drafts database'
    end
  end
  task :migrate => [:environment, :migrate_draft] do
  end

  task :sample => :environment do
    load File.join(Rails.root, "db", "samples.rb")
  end

end
