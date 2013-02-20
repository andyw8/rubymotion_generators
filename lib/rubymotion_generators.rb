require "rubymotion_generators/version"
require 'thor'

module RubymotionGenerators
  class Core < Thor
    include Thor::Actions

    desc "generate", "Generate a new file of the specified type"

    def generate(args)
      template_name, name = args

      case template_name
      when 'view'
        generate_view name
      when 'vc'
        generate_view_controller name
      when 'tvc'
        generate_table_view_controller name
      when 'cell'
        generate_table_view_cell name
      when 'app'
        generate_basic_app
      when 'tbapp'
        generate_tab_bar_app_delegate
        generate_view_controller 'first'
        generate_view_controller 'second'
      when 'tvapp'
        generate_table_view_app_delegate
        generate_table_view_controller 'example'
      when 'svapp'
        generate_single_view_app_delegate
        generate_view_controller 'example'
      else
        puts "Invalid template name '#{template_name}'"
        exit 1
      end
    end

    private

    def generate_view(name)
      output_path = "app/views/#{name.downcase}_view.rb"
      template 'templates/view.rb', output_path
      class_name = name.capitalize + "View"
      insert_into_file output_path, class_name, :after => 'class '
    end

    def generate_view_controller(name)
      output_path = "app/controllers/#{name.downcase}_view_controller.rb"
      template 'templates/view_controller.rb', output_path
      class_name = name.capitalize + "ViewController"
      insert_into_file output_path, class_name, :after => 'class '
    end

    def generate_table_view_controller(name)
      output_path = "app/controllers/#{name.downcase}_table_view_controller.rb"
      template 'templates/table_view_controller.rb', output_path
      class_name = name.capitalize + "TableViewController"
      insert_into_file output_path, class_name, :after => 'class '
    end

    def generate_table_view_cell(name)
      output_path = "app/views/#{name.downcase}_cell.rb"
      template 'templates/table_view_cell.rb', output_path
      class_name = name.capitalize + "Cell"
      insert_into_file output_path, class_name, :after => 'class '
    end

    def generate_tab_bar_app_delegate
      template 'templates/tab_bar_app_delegate.rb', "app/app_delegate.rb"
    end

    def generate_table_view_app_delegate
      template 'templates/table_view_app_delegate.rb', "app/app_delegate.rb"
    end

    def generate_single_view_app_delegate
      template 'templates/single_view_app_delegate.rb', "app/app_delegate.rb"
    end

    def self.source_root
      File.dirname(__FILE__)
    end
  end
end
