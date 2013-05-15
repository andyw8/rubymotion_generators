require 'optparse'
require 'lib/rubymotion_generators'

module Motion
  module Project
    class GeneratorCommand < Command
      self.name = 'generate'
      self.help = 'Generate a view or view controller'

      def run(args)
        unless File.exist?('Rakefile')
          $stderr.puts "Run on Root Directoy of RubyMotion Project"
          exit 1
        end

        RubymotionGenerators::Core.new.generate ARGV
      end
    end
  end
end
