def template(from, to)
  template_path = File.expand_path("../templates/#{from}", __FILE__)
  template = ERB.new(File.new(template_path).read).result(binding)
  output = File.open to, 'w'
  output << StringIO.new(template).read
  output.close
end

def set_env(name, value)
end
