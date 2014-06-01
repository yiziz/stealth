class String
  def to_mi
    return unless self[0..1] == '#<' and self[-1] == '>'
    obj_s, options_s = self[2..-2].split ','
    model_s, id_s = obj_s.split(':')
    model = model_s.constantize
    obj_id = eval id_s if id_s
    options = eval options_s if options_s
    obj = obj_id ? model.find(obj_id) : model.new
    obj.assign_attributes options if options
    obj
  end
end
