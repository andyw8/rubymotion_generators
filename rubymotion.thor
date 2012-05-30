class Motion < Thor
  include Thor::Actions

  desc "generate_view", "Generate a new class which inherits from UIView"

  def generate_view(name)
    output_path = "app/#{name}_view.rb"
    template('templates/view.rb', output_path)
    class_name = name.capitalize + "View"
    insert_into_file(output_path, class_name, :before => ' < UIView')
  end

   def self.source_root
    File.dirname(__FILE__)
  end

end
