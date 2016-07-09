# coding: utf-8
#
# 意味解析メソッドanalize(block, lev)
#

require_relative './env.rb'
require_relative './lookup.rb'
require_relative './type_def.rb'


def analize(block, lev)

  
  p = (block.class == Array) ? block[0] : block

  case p

      
  when Declaration
    
    if p.type != "int"
      puts "#{p.pos} error : declare type '#{p.type}' is not allowed."
      exit 1
    end
    
    $sem[lev] = {} if $sem[lev] == nil
    $sem[1] = {} if $sem[1] == nil

    p.decl.each do |elem|
      d_name = elem[1].name.to_sym
      type = [p.type, elem[0]]
      if $sem[lev][d_name] == nil
        if $sem[1][d_name]
          puts "#{elem[1].pos} warning : '#{elem[1].name}' is already declared."
        end
        case elem[1]
        when ID
          $sem[lev][d_name] = Env.new(d_name, lev, :var, type)
          elem[1] = $sem[lev][d_name]#名前変換
        when Ary
          $sem[lev][d_name] = Env.new(d_name, lev, :var, [:array, type, elem[1].size])
          elem[1] = $sem[lev][d_name]#名前変換
        end
      else
        puts "#{elem[1].pos} error : '#{elem[1].name}' is already declared."
        exit 1
      end
    end

    
    
  when Func_proto

    p_name = p.name.name[1].to_sym
    args = []
    type = [[p.type, p.name.name[0]], args]

    p.arg.each do |a|
      if a[0] != "int"
        puts "#{a[1].pos} error : type '#{a[0]}' is not allowed as a parameter."
        exit 1
      end
      args << [a[0], a[1].name[0]]
    end

    if  $sem[lev][p_name] == nil
      $sem[0][p_name] = Env.new(p_name, lev, :proto, type)
      p.name = $sem[0][p_name]#名前変換
    elsif $sem[lev][p_name].kind == :proto && $sem[lev][p_name].type == type ||
          $sem[lev][p_name].kind == :fun && $sem[lev][p_name].type == type
    else
      puts "#{p.name.pos} error : function '#{p.name.name[1]}' type or parameter is defferent."
      exit 1
    end


    
  when Func_def

    f_name = p.name.name[1].to_sym
    args = []
    type = [[p.type, p.name.name[0]], args]

    p.arg.each do |a|
      args << [a[0], a[1].name[0]]
    end

    if $sem[0][f_name] ==  nil || ($sem[0][f_name].kind == :proto && $sem[0][f_name].type == type)
      $sem[0][f_name] = Env.new(f_name, lev, :fun, type)
      p.name = $sem[0][f_name]#名前変換
         $ftype = type[0]
    else
      puts "#{p.name.pos} error : function '#{p.name.name[1]}' is redefined or defferent parameter."
      exit 1
    end

    $sem[1] = {} if $sem[1] == nil

    p.arg.each do |a|
      a_name = a[1].name[1].to_sym
      type = [a[0], a[1].name[0]]
      if type[0] != "int"
        puts "#{a[1].pos} error : type '#{a[0]}' is not allowed as a parameter."
        exit 1
      end
      if $sem[1][a_name] == nil
        $sem[1][a_name] = Env.new(a_name, 1, :parm, type)
        a[1] = $sem[1][a_name]#名前変換
         else
          puts "#{a[1].pos} error : parameter '#{a[1].name[1]}' is redeclared."
          exit 1
      end
    end
    analize(p.statement, 1)


    
  when Compound

    lev += 1
    $sem[lev] = {}

    if p.decl_list
      p.decl_list.each do |decl|
        analize(decl, lev)
      end
    end

    p.statement_list.each do |stmt|
      analize(stmt, lev) if p.statement_list
    end


    
  when IF

    if analize(p.cond, lev) != "int"
      puts "#{p.pos} error : cond type is not allowed."
      exit 1
    end
    analize(p.statement, lev)
    analize(p.elsstatement, lev) if p.elsstatement != ';'


    
  when While

    if p.cond == nil || analize(p.cond, lev) != "int"
      puts "#{p.pos} error : cond type is not allowed( or empty )."
      exit 1
    end
    analize(p.statement, lev)

    
    
  when Return

    type_error = "#{p.pos} error : 'function' and 'return' have defferent types."
    type = (p.expression == nil) ? "void" : analize(p.expression, lev)

    if $ftype[0] == "void" && p.expression
      puts type_error; exit 1
    end
    ftype = type_def([$ftype], p.pos)
    if ftype != type
      puts type_error; exit 1
    end
    

    
  when DIGIT
    type = "int"
    return type

    
    
  when Binary, Assign

    type_error = "#{p.pos} error : lval and rval types are not allowed."
    type__error =  "#{p.pos} error : pointer type is not allowed as lval."
    ltype = analize(p.lval, lev)
    rtype = analize(p.rval, lev)

    case p.op
        
    when '+'
      if ltype == "int" && rtype == "int"
        type = "int"
      elsif (ltype == "int*" && rtype == "int") || (ltype == "int" && rtype == "int*")
        type ="int*"
      elsif (ltype == "int**" && rtype == "int") || (ltype == "int" && rtype == "int**")
        type = "int**"
      else
        puts type_error; exit 1
      end
    when '-'
      if ltype == "int" && rtype == "int"
        type = "int"
      elsif ltype == "int*" && rtype == "int"
        type ="int*"
      elsif ltype == "int**" && rtype == "int*"
        type = "int**"
      else
        puts type_error; exit 1
      end
    when '*', '/', '==', '!=', '<', '>', '<=', '>='
      if ltype == rtype
        type = "int"
      else
        puts type_error; exit 1
      end
    when '='
      if rtype == ltype
        type = ltype
      else
        puts "#{p.lval.pos} error : left type '#{ltype}', right type '#{rtype}' is not allowed."
        exit 1
      end
      case p.lval
      when Unary
        if  p.lval.op != '*'
          puts type__error; exit 1
        end
      when Refer
        l_name = p.lval.name.name
        env = lookup(l_name, lev)
        if env.class != Env
          puts "#{p.pos} error : '#{p.name}' undeclared variable or function."
          exit 1
        end
        if ( env.kind != :var && env.kind != :parm ) || env.type[0] != "int"
          puts "#{p.lval.pos} error : '#{env.name}' is not val(parameter) or integer."
          exit 1
        end
      else
        puts "#{p.lval.pos} error : lval is not variable."
        exit 1
      end
    when '&&', '||'
      if ltype == 'int' && rtype == 'int'
        type = "int"
      else
        puts type_error; exit 1
      end
    end
    return type


    
  when Unary

    valtype = analize(p.val, lev)

    case p.op
    when '&'
      if  p.val.class == Refer && p.val.arg == :val && valtype == "int"
        type = "int*"
      else
        puts "#{p.pos} error : address type is not allowed."
        exit 1
      end
    when '*'
      case valtype
      when "int*"
        type = "int"
      when "int**"
        type = "int*"
      else
        puts "#{p.pos} error : pointer type is not allowed."
        exit 1
      end
    end
    
    return type

    
    
  when Refer, Func_call

    r_name = p.name.to_sym
    refer_error = "#{p.pos} error : '#{p.name}' refer is not variable."
    parm_error = "#{p.pos} error : function parameter is defferent."
    env = lookup(r_name, lev)

    if env.class != Env
      puts "#{p.pos} error : '#{p.name}' undeclared variable or function."
      exit 1
    else
      if p.arg == :val
        if env.kind == :var || env.kind == :parm
          if env.type[0] == :array
            type = type_def(env.type, p.pos)
          else
            type = type_def([env.type], p.pos)
          end
        else
          puts refer_error; exit 1
        end
      elsif env.kind == :proto || env.kind == :fun
        if p.arg == :void
          if env.type[1][0] != nil
            puts  "#{p.pos} error : function '#{p.name}' type is void."
            exit 1
          end
          type = type_def(env.type, p.pos)
        elsif p.arg.class == Array
          if env.type[1].size != p.arg.size
            puts parm_error; exit 1
          else
            p.arg.each_with_index do |arg, i|
              argType = analize(arg, lev)
              defType = type_def([env.type[1][i]], p.pos)
              if argType != defType
                puts parm_error; exit 1
              end
            end
            type = type_def(env.type, p.pos)
          end
        end
      else
        puts "#{p.pos} error : '#{p.name}' refer to defferent kind name."
        exit 1
        analize(p.arg, lev)
      end
      p.name = env#名前変換
      return type
    end
  end
end
