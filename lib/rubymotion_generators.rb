require "rubymotion_generators/version"
require 'thor'

module RubymotionGenerators
  class Core < Thor
    include Thor::Actions

    desc "generate", "Generate a new file of the specified type"

    def generate(*args)
      # unsure why this flatten step is needed
      args = args.flatten
      template_name = args[0]
      name = args[1]
      unless name
        puts "Missing name parameter"
        exit 1
      end
      case template_name
      when 'view'
        generate_view name
      when 'vc'
        generate_view_controller name
      when 'tvc'
        generate_table_view_controller name
      when 'cell'
        generate_table_view_cell
      when 'tbapp'
        generate_tab_bar_app_delegate name
        generate_view_controller 'first'
        generate_view_controller 'second'
      else
        puts "Invalid template name '#{template_name}'"
        exit 1
      end
    end

    private

    def generate_view(name)
      output_path = "app/views/#{name}_view.rb"
      template('templates/view.rb', output_path)
      class_name = name.capitalize + "View"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_table_view_controller(name)
      output_path = "app/controllers/#{name}_table_view_controller.rb"
      template('templates/table_view_controller.rb', output_path)
      class_name = name.capitalize + "TableViewController"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_view_controller(name)
      output_path = "app/controllers/#{name}_view_controller.rb"
      template('templates/view_controller.rb', output_path)
      class_name = name.capitalize + "ViewController"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_table_view_cell(name)
      output_path = "app/views/cells/#{name}_table_view_cell.rb"
      template('templates/table_view_cell.rb', output_path)
      class_name = name.capitalize + "TableViewCell"
      insert_into_file(output_path, class_name, :after => 'class ')
    end

    def generate_tab_bar_app_delegate(name)
      output_path = "app/app_delegate.rb"
      template('templates/tab_bar_app_delegate.rb', output_path)
    end

    def self.source_root
      File.dirname(__FILE__)
    end
  end
end
