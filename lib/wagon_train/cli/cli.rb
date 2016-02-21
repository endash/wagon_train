require 'thor'
require 'git'

require 'wagon_train'
require 'wagon_train/cli/project'
require 'wagon_train/cli/release'
require 'wagon_train/cli/commands/release'

module WagonTrain
  module CLI
    module Commands
      WorkingDirectoryNotClean = Class.new(StandardError)
      NoSchemaChanges = Class.new(StandardError)
    end

    class CLI < Thor
      attr_reader :project

      def initialize(*args)
        super(*args)
        @project = WagonTrain::CLI::Project.new(Git.open("."))
      end

      desc "release", "Generate a migration and save it and the new schema in the master branch"
      def release
        command = Commands::Release.new(project, project.git)
        command.guard!
        command.run!
      end
    end
  end
end