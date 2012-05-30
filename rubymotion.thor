class Motion < Thor
  include Thor::Actions

  desc "generate", "Generate a new file of the specified type"
  #desc "generate_table_view_controller", "Generate a new class which inherits from UITableViewController"

  def generate(*args)
    template_name = args[0]
    name = args[1]
    case template_name
    when 'view'
      generate_view name
    when 'table_view_controller'
      generate_table_view_controller name
    else
      puts "Invalid template name '#{template_name}'"
      exit
    end
  end

  private

  def generate_view(name)
    output_path = "#{name}_view.rb"
    template('templates/view.rb', output_path)
    class_name = name.capitalize + "View"
    insert_into_file(output_path, class_name, :before => ' < UIView')
  end

  def generate_table_view_controller(name)
    output_path = "#{name}_table_view_controller.rb"
    template('templates/table_view_controller.rb', output_path)
    class_name = name.capitalize + "TableViewController"
    insert_into_file(output_path, class_name, :before => ' < UITableViewController')
  end

  def self.source_root
    File.dirname(__FILE__)
  end
end
