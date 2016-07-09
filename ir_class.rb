# coding: utf-8
#
# 中間表現におけるクラス定義(仕様書そのまま)
#


class VarDecl
  attr_accessor :var
  def initialize(var)
    @var = var
  end
end



class FunDef
  attr_accessor :var, :parms, :body
  def initialize(var, parms, body)
    @var = var
    @parms = parms
    @body = body
  end
end



class AssignStmt
  attr_accessor :var, :exp
  def initialize(var, exp)
    @var = var
    @exp = exp
  end
end



class WriteStmt
  attr_accessor :dest, :src
  def initialize(dest, src)
    @dest = dest
    @src  = src
  end
end



class RoadStmt
  attr_accessor :dest, :src
  def initialize(dest, src)
    @dest = dest
    @src  = src
  end
end



class LabelStmt
  attr_accessor :name
  def initialize(name)
    @name  = name
  end
end



class IfStmt
  attr_accessor :var, :tlabel, :elabel
  def initialize(var, tlabel, elabel)
    @var = var
    @tlabel = tlabel
    @elabel = elabel
  end
end



class GotoStmt
  attr_accessor :label
  def initialize(label)
    @label = label
  end
end



class CallStmt
  attr_accessor :dest, :tgt, :vars
  def initialize(dest, tgt, vars)
    @dest = dest
    @tgt  = tgt
    @vars = vars
  end
end



class RetStmt
  attr_accessor :var
  def initialize(var)
    @var = var
  end
end



class PrintStmt
  attr_accessor :var
  def initialize(var)
    @var = var
  end
end



class CmpdStmt
  attr_accessor :decls, :stmts
  def initialize(decls, stmts)
    @decls = decls
    @stmts = stmts
  end
end



#class VarExp
#  attr_accessor :var
#  def initialize(var)
#    @var = var
#  end
#end



class LitExp
  attr_accessor :val
  def initialize(val)
    @val = val
  end
end



class AopExp
  attr_accessor :op, :left, :right
  def initialize(op, left, right)
    @op = op
    @left = left
    @right  = right
  end
end



class RopExp
  attr_accessor :op, :left, :right
  def initialize(op, left, right)
    @op = op
    @left = left
    @right  = right
  end
end



class AddrExp
  attr_accessor :var
  def initialize(var)
    @var = var
  end
end
