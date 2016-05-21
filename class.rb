# 
# クラス定義
#

class Declaration
  attr_accessor :type, :decl, :pos
  def initialize(type, decl, pos)
    @type = type
    @decl = decl
    @pos = pos
  end
end

class Ary
  attr_accessor :name, :size, :pos
  def initialize(name, size, pos)
    @name = name
    @size = size
    @pos  = pos
  end
end

class Func_proto
  attr_accessor :type, :name, :arg, :pos
  def initialize(type, name, arg, pos)
    @type = type
    @name = name
    @arg = arg
    @pos = pos
  end
end

class Func_def
  attr_accessor :type, :name, :arg, :statement, :pos
  def initialize(type, name, arg, statement, pos)
    @type = type
    @name = name
    @arg = arg
    @statement = statement
    @pos = pos
  end
end

class Compound
  attr_accessor :decl_list, :statement_list, :pos
  def initialize(decl_list, statement_list, pos)
    @decl_list  = decl_list
    @statement_list = if statement_list == nil
                        []
                      elsif statement_list.class == Array
                        statement_list
                      else
                        [statement_list]
                      end
    @pos = pos
  end
end

class IF
  attr_accessor :cond, :statement, :elsstatement, :pos
  def initialize(cond, statement, elsstatement, pos)
    @cond = cond || true
    @statement = statement
    @elsstatement = elsstatement
    @pos = pos
  end
end

class While
  attr_accessor :cond, :statement, :pos
  def initialize(cond, statement, pos)
    @cond = cond
    @statement = statement
    @pos = pos
  end
end

class Return
  attr_accessor :expression, :pos
  def initialize(expression, pos)
    @expression =  expression
    @pos    = pos
  end
end

class Binary
  attr_accessor :op, :lval, :rval, :pos
  def initialize(op, lval, rval, pos)
    @op = op
    @lval = lval
    @rval = rval
    @pos = pos
  end
end

class Unary
  attr_accessor :op, :val, :pos
  def initialize(op, val, pos)
    @op = op
    @val = val
    @pos  = pos
  end
end

class Refer
  attr_accessor :name, :arg, :pos
  def initialize(name, arg, pos)
    @name = name
    @arg = (arg != nil) ? arg : :val
    @pos = pos
  end
end

class ID
  attr_accessor :name, :pos
  def initialize(name, pos)
    @name = name
    @pos = pos
  end
end  

class DIGIT
  attr_accessor :name, :pos
  def initialize(name, pos)
    @name = name
    @pos = pos
  end
end
