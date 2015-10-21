def attribute arg, &block

  if arg.is_a?(Hash)
    name = arg.first[0]
    value = arg.first[1]
  else
    name = arg
  end
  expanded_name = "@#{name}"
  define_method :initialize do
    instance_variable_set(expanded_name,value) if value
  end

  define_method "#{name}" do
    instance_variable_defined?(expanded_name) ? instance_variable_get(expanded_name) : instance_variable_set(expanded_name, (block_given? ? instance_eval(&block) : value))
  end
  define_method "#{name}=" do |v|
    instance_variable_set(expanded_name,v)
  end
  define_method "#{name}?" do
    instance_variable_get(expanded_name)
  end
end
