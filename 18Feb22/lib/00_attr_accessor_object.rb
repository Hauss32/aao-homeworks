class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      var_str = '@' + name.to_s
      define_method(name.to_s) { self.instance_variable_get(var_str) }
      define_method(name.to_s + '=') { |value| self.instance_variable_set(var_str, value) }
    end
  end
end
