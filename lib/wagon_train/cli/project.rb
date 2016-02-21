module WagonTrain
  module CLI
    class Project
      attr_reader :git, :config

      def initialize(git)
        @git = git
      end

      def current_release
        commit = master_branch.gcommit
        Release.new(commit.sha, eval(schema_for_commit(commit)))
      end

      def master_branch
        git.branches["master"]
      end

      def schema_for_commit(commit)
        read_file("schema.rb", commit.gtree)
      end

      def current_schema
        eval(File.read("schema.rb"))
      end

      def release_schema
        current_release.schema
      end

      def read_file(path, object)
        git.show(object, path)
      end

      def migrations
        Dir["migrate/**/*.rb"]
      end

      def migration_file
        "migrate.rb"
      end
    end
  end
end