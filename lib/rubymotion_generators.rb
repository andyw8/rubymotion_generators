require "rubymotion_generators/version"
require 'thor'

module RubymotionGenerators
  class Core < Thor
    include Thor::Actions

    desc "generate", "Generate a new file of the specified type"
    #desc "generate_table_view_controller", "Generate a new class which inherits from UITableViewController"

    def generate(*args)
      # unsure why this flatten step is needed
      args = args.flatten
      puts args.inspect
      template_name = args[0]
      name = args[1]
      unless name
        puts "Missing name parameter"
        exit 1
      end
      case template_name
      when 'v'
        generate_view name
      when 'tvc'
        generate_table_view_controller name
      when 'vc'
        generate_view_controller name
      when 'tvcell'
        generate_table_view_cell
      else
        puts "Invalid template name '#{template_name}'"
        exit 1
      end
    end

    private

    def generate_view(name)
      output_path = "#{name}_view.rb"
      template('templates/view.rb', output_path)
      class_name = name.capitalize + "View"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_table_view_controller(name)
      output_path = "#{name}_table_view_controller.rb"
      template('templates/table_view_controller.rb', output_path)
      class_name = name.capitalize + "TableViewController"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_view_controller(name)
      output_path = "#{name}_view_controller.rb"
      template('templates/view_controller.rb', output_path)
      class_name = name.capitalize + "ViewController"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_table_view_cell(name)
      output_path = "#{name}_table_view_cell.rb"
      template('templates/table_view_cell.rb', output_path)
      class_name = name.capitalize + "TableViewCell"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def self.source_root
      File.dirname(__FILE__)
    end
  end
end
