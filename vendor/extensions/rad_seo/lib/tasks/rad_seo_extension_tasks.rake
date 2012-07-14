namespace :radiant do
  namespace :extensions do
    namespace :rad_seo do
      
      desc "Runs the migration of the Rad Seo extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RadSeoExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RadSeoExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Rad Seo to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[RadSeoExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RadSeoExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
