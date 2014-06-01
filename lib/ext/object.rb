class Object
  def is_ms?
    self.is_a? String and self[0..1] == '#<' and self[-1] == '>'
  end
end
