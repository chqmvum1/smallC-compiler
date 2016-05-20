def type_def(env_type, pos)
  if env_type[0] == :array
    if env_type[1][0] == "void"
      puts "#{pos} error : 'void' is not allowed as array type."
      exit 1
    end
    case env_type[1][1]
    when :none
      type = "int*"
    when '*'
      type = "int**"
    end
  else
    case env_type[0][1]
    when :none
      type = env_type[0][0]
    when '*'
      if env_type[0][0] == "void"
        puts "#{pos} error : 'void*' type is not allowed."
        exit 1
      end
      type = env_type[0][0] + '*'
    end
  end
  return type
end
