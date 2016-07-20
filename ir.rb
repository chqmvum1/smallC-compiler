# coding: utf-8


require_relative './env.rb'
require_relative './ir_class.rb'
require_relative './tmp_shift.rb'


$tmp_num = 0



def var_gen()
  tmp = "_t" << $tmp_num.to_s
  $tmp_num += 1
  return Env.new(tmp.to_sym, 99, :tmp, "int")
end




def ir(block)

  decls = []
  stmts = []
  
  p = (block.class == Array) ? block[0] : block

  
  case p

      
  when Declaration
    p.decl.each do |d|
      decls << VarDecl.new(d[1])
      $mid << VarDecl.new(d[1]) if d[1].lev == 0
    end
    
    return {decls: decls, stmts: []}

    

    
  when Func_def
    args = []
    p.arg.each{|a| args << a[1]}
    $mid << FunDef.new(p.name, args, ir(p.statement)[:stmts])


    
    
  when Compound
    decls += ir(p.decl_list)[:decls] if p.decl_list
    p.statement_list.each do |s|
      stmt = ir(s)
      stmt[:decls].flatten!
      stmt[:decls].each { |d| decls << VarDecl.new(d) }
      stmts << stmt[:stmts]
    end

    return {decls: [], stmts: CmpdStmt.new(decls, stmts.flatten!)}

    
    
    
  when IF
    t0 = var_gen()#cond
    l1 = var_gen()#L1
    l2 = var_gen()#L2
    l3 = var_gen()#L3
    decls << t0 << l1 << l2 << l3
    case p.cond.lval
    when Refer
      t1 = var_gen()
      t2 = var_gen()
      decls << t1 << t2
      stmts << AssignStmt.new(t1, ir(p.cond.lval)[:stmts])
      stmts << AssignStmt.new(t2, ir(p.cond.rval)[:stmts])
      stmts << AssignStmt.new(t0, RopExp.new(p.cond.op, t1, t2))
    when Binary
      t1 = var_gen()
      t2 = var_gen()
      t3 = var_gen()
      t4 = var_gen()
      t5 = var_gen()
      t6 = var_gen()
      decls  << t1 << t2 << t3 << t4 << t5 << t6
      if p.cond.lval.lval.class == Refer
        case p.cond.op
        when '&&'
          stmts << AssignStmt.new(t1, p.cond.lval.lval.name)
          stmts << AssignStmt.new(t2, LitExp.new(p.cond.lval.rval.name))
          stmts << AssignStmt.new(t3, RopExp.new(p.cond.lval.op, t1, t2))
          stmts << AssignStmt.new(t4, p.cond.rval.lval.name)
          stmts << AssignStmt.new(t5, p.cond.rval.rval.name)
          stmts << AssignStmt.new(t6, AopExp.new(p.cond.rval.op, t4, t5))
          stmts << AssignStmt.new(t0, RopExp.new(p.cond.op, t3, t6))
        when '||'
          t7 = var_gen()
          t8 = var_gen()
          t9 = var_gen()
          t10 = var_gen()
          decls << t7 << t8 << t9 << t10
          stmts << AssignStmt.new(t1, p.cond.lval.lval.name)
          stmts << AssignStmt.new(t2, LitExp.new(p.cond.lval.rval.name))
          stmts << AssignStmt.new(t3, RopExp.new(p.cond.lval.op, t1, t2))
          stmts << AssignStmt.new(t4, p.cond.rval.lval.lval.name)
          stmts << AssignStmt.new(t5, p.cond.rval.lval.rval.name)
          stmts << AssignStmt.new(t6, AopExp.new(p.cond.rval.lval.op, t4, t5))
          stmts << AssignStmt.new(t7, p.cond.rval.rval.lval.name)
          stmts << AssignStmt.new(t8, p.cond.rval.rval.rval.name)
          stmts << AssignStmt.new(t9, AopExp.new(p.cond.rval.rval.op, t7, t8))
          stmts << AssignStmt.new(t10, RopExp.new(p.cond.rval.op, t6, t9))
          stmts << AssignStmt.new(t0, RopExp.new(p.cond.op, t3, t10))
        end
      else
        if p.cond.rval.class == Binary
          t7 = var_gen()
          t8 = var_gen()
          t9 = var_gen()
          t10 = var_gen()
          t11 = var_gen()
          decls << t7 << t8 << t9 << t10 << t11
          stmts << AssignStmt.new(t1, p.cond.lval.lval.lval.name)
          stmts << AssignStmt.new(t2, p.cond.lval.lval.rval.lval.name)
          stmts << AssignStmt.new(t3, LitExp.new(p.cond.lval.lval.rval.rval.name))
          stmts << AssignStmt.new(t4, AopExp.new(p.cond.lval.lval.rval.op, t2, t3))
          stmts << AssignStmt.new(t5, RopExp.new(p.cond.lval.lval.op, t1, t4))
          stmts << AssignStmt.new(t6, p.cond.lval.rval.rval.name)
          stmts << AssignStmt.new(t7, RopExp.new(p.cond.lval.rval.op, t4, t6))
          stmts << AssignStmt.new(t8, RopExp.new(p.cond.lval.op, t5, t7))
          stmts << AssignStmt.new(t9, p.cond.rval.lval.name)
          stmts << AssignStmt.new(t10, LitExp.new(p.cond.rval.rval.name))
          stmts << AssignStmt.new(t11, RopExp.new(p.cond.rval.op, t9, t10))
          stmts << AssignStmt.new(t0, RopExp.new(p.cond.op, t8, t11))
        else
          t7 = var_gen()
          t8 = var_gen()
          decls << t7 << t8
          stmts << AssignStmt.new(t1, p.cond.lval.lval.lval.name)
          stmts << AssignStmt.new(t2, p.cond.lval.lval.rval.name)
          stmts << AssignStmt.new(t3, RopExp.new(p.cond.lval.lval.op, t1, t2))
          stmts << AssignStmt.new(t4, p.cond.lval.rval.lval.name)
          stmts << AssignStmt.new(t5, p.cond.lval.rval.rval.name)
          stmts << AssignStmt.new(t6, RopExp.new(p.cond.lval.rval.op, t4, t5))
          stmts << AssignStmt.new(t7, RopExp.new(p.cond.lval.op, t3, t6))
          stmts << AssignStmt.new(t8, p.cond.rval.name)
          stmts << AssignStmt.new(t0, RopExp.new(p.cond.op, t7, t8))
        end
      end
    end
    stmts << IfStmt.new(t0, GotoStmt.new(l1), GotoStmt.new(l2))
    tstmt = ir(p.statement)
    fstmt = ir(p.elsstatement)
    decls << tstmt[:decls] << fstmt[:decls]
    stmts << LabelStmt.new(l1) << tstmt[:stmts] << GotoStmt.new(l3)
    stmts << LabelStmt.new(l2) << fstmt[:stmts] << GotoStmt.new(l3) << LabelStmt.new(l3)

    return {decls: decls, stmts: stmts}

    
    
    
  when While
    t0 = var_gen()#cond
    t1 = var_gen()
    t2 = var_gen()
    l1 = var_gen()#L1
    l2 = var_gen()#L2
    l3 = var_gen()#L3
    decls << t0 << t1 << t2 << l1 << l2 << l3
    stmts << GotoStmt.new(l1) << LabelStmt.new(l1)
    stmts << AssignStmt.new(t1, ir(p.cond.lval)[:stmts])
    stmts << AssignStmt.new(t2, ir(p.cond.rval)[:stmts])
    stmts << AssignStmt.new(t0, RopExp.new(p.cond.op, t1, t2))
    stmts << IfStmt.new(t0, GotoStmt.new(l2), GotoStmt.new(l3))
    stmts << LabelStmt.new(l2) << ir(p.statement)[:stmts] << GotoStmt.new(l1)
    stmts << LabelStmt.new(l3)
    
    return {decls: decls, stmts: stmts}


    
    
  when Return
    case p.expression
    when DIGIT, Refer
      t1 = var_gen()
      decls << t1
      stmts << AssignStmt.new(t1, ir(p.expression)[:stmts])
      stmts << RetStmt.new(t1)
    when Binary
      left = var_gen()
      right = var_gen()
      decls << left << right
      case p.expression.lval#左辺
      when Refer
        stmts << AssignStmt.new(left, ir(p.expression.lval)[:stmts])        
      when Func_call
        args = []
        p.expression.lval.arg.each do |a|
          case a
          when DIGIT
            t = var_gen()
            decls << t
            stmts << AssignStmt.new(t, ir(a)[:stmts])
            args << t
          when Binary
            t1 = var_gen()
            t2 = var_gen()
            t3 = var_gen()
            decls << t1 << t2 << t3
            stmts << AssignStmt.new(t1, ir(a.lval)[:stmts])
            stmts << AssignStmt.new(t2, ir(a.rval)[:stmts])
            stmts << AssignStmt.new(t3, AopExp.new(a.op, t1, t2))
            args << t3
          end
        end
        stmts << CallStmt.new(left, p.expression.lval.name, args)
      when Binary
        t1 = var_gen()
        t2 = var_gen()
        decls << t1 << t2
        stmts << AssignStmt.new(t1, p.expression.lval.lval.name)#左辺の左
        case p.expression.lval.rval#左辺の右
        when DIGIT, Refer
          stmts << AssignStmt.new(t2, ir(p.expression.lval.rval)[:stmts])
        when Unary
          t3 = var_gen()
          t4 = var_gen()
          t5 = var_gen()
          t6 = var_gen()
          t7 = var_gen()
          decls << t3 << t4 << t5 << t6 << t7
          if p.expression.lval.rval.val.lval.name.type[0] == :array
            stmts << AssignStmt.new(t3, AddrExp.new(p.expression.lval.rval.val.lval.name))
          else
            stmts << AssignStmt.new(t3, p.expression.lval.rval.val.lval.name)
          end
          stmts << AssignStmt.new(t4, ir(p.expression.lval.rval.val.rval)[:stmts])
          stmts << AssignStmt.new(t5, LitExp.new("4"))
          stmts << AssignStmt.new(t6, AopExp.new('*', t3, t4))
          stmts << AssignStmt.new(t7, AopExp.new(p.expression.lval.rval.val.op, t3, t6))
          stmts << RoadStmt.new(t2, t7)
        end
        stmts << AssignStmt.new(left, AopExp.new(p.expression.lval.op, t1, t2))
      end
      case p.expression.rval#右辺
      when Refer
        stmts << AssignStmt.new(right, ir(p.expression.rval)[:stmts])
      when Func_call
        args = []
        p.expression.rval.arg.each do |a|
          case a
          when DIGIT
            t = var_gen()
            decls << t
            stmts << AssignStmt.new(t, ir(a)[:stmts])
            args << t
          when Binary
            t1 = var_gen()
            t2 = var_gen()
            t3 = var_gen()
            decls << t1 << t2 << t3
            stmts << AssignStmt.new(t1, ir(a.lval)[:stmts])
            stmts << AssignStmt.new(t2, ir(a.rval)[:stmts])
            stmts << AssignStmt.new(t3, AopExp.new(a.op, t1, t2))
            args << t3
          end
        end
        stmts << CallStmt.new(right, p.expression.rval.name, args)
      when Binary
        t1 = var_gen()
        t2 = var_gen()
        decls << t1 << t2
        stmts << AssignStmt.new(t1, ir(p.expression.rval.lval)[:stmts])#右辺の左
        stmts << AssignStmt.new(t2, ir(p.expression.rval.rval)[:stmts])#右辺の右
        stmts << AssignStmt.new(right, AopExp.new(p.expression.rval.op, t1, t2))
      when Unary
        t1 = var_gen()
        t2 = var_gen()
        t3 = var_gen()
        decls << t1 << t2 << t3
        if p.expression.rval.val.lval.name.type[0] == :array
          stmts << AssignStmt.new(t1, AddrExp.new(p.expression.rval.val.lval.name))
        else
          stmts << AssignStmt.new(t1, p.expression.rval.val.lval.name)
        end
        stmts << AssignStmt.new(t2, LitExp.new("4"))
        stmts << AssignStmt.new(t3, AopExp.new('+', t1, t2))
        stmts << RoadStmt.new(right, t3)
      end
      t0 = var_gen()
      decls << t0
      case p.expression.op
      when '+', '-', '*', '/'
        stmts << AssignStmt.new(t0, AopExp.new(p.expression.op, left, right))
      when '==', '!=', '<', '>', '<=', '>='
        stmts << AssignStmt.new(t0, RopExp.new(p.expression.op, left, right))
      end
      stmts << RetStmt.new(t0)
    when Func_call
      args = []
      p.expression.arg.each do |a|
        case a
        when DIGIT, Refer
          t = var_gen()
          decls << t            
          stmts << AssignStmt.new(t, ir(a)[:stmts])
          args << t
        when Binary
          t1 = var_gen()
          t2 = var_gen()
          t3 = var_gen()
          decls << t1 << t2 << t3
          stmts << AssignStmt.new(t1, ir(a.lval)[:stmts])
          stmts << AssignStmt.new(t2, ir(a.rval)[:stmts])
          stmts << AssignStmt.new(t3, AopExp.new(a.op, t1, t2))
          args << t3
        end
      end
      t0 = var_gen()
      decls << t0
      stmts << CallStmt.new(t0, p.expression.name, args)
      stmts << RetStmt.new(t0)
    end
    return {decls: decls, stmts: stmts}



    
    
  when DIGIT
    return {decls: [], stmts: LitExp.new(p.name)}



    
    
  when Refer
    return {decls: [], stmts: p.name}



    
    
  when Assign
    if p.lval.class == Refer && p.rval.class == Unary#<dest> = *<src>

      if p.rval.val.class == Binary
        t1 = var_gen()
        t2 = var_gen()
        t3 = var_gen()
        t4 = var_gen()
        t5 = var_gen()
        t6 = var_gen()
        decls << t1 << t2 << t3 << t4 << t5 << t6
        
        stmts << AssignStmt.new(t1, AddrExp.new(p.rval.val.lval.name))
        stmts << AssignStmt.new(t2, LitExp.new("4"))
        stmts << AssignStmt.new(t3, LitExp.new(p.rval.val.rval.name))
        stmts << AssignStmt.new(t4, AopExp.new('*', t2, t3))
        stmts << AssignStmt.new(t5, AopExp.new('+', t1, t4))
        stmts << RoadStmt.new(t6, t5)
        stmts << AssignStmt.new(p.lval.name, t6)
      else
        t1 = var_gen()
        decls << t1
        stmts << RoadStmt.new(t1, ir(p.rval.val)[:stmts])
        stmts << AssignStmt.new(p.lval.name, t1)
      end
      
    elsif p.lval.class == Unary && p.rval.class == Refer#*<dest> = <src>
      t1 = var_gen()
      decls << t1
      stmts << AssignStmt.new(t1, ir(p.rval)[:stmts])
      stmts << WriteStmt.new(ir(p.lval.val)[:stmts], t1)
    elsif p.lval.class == Unary && p.rval.class == DIGIT#*<dest> = <src>(Array)
      t1 = var_gen()
      t2 = var_gen()
      t3 = var_gen()
      t4 = var_gen()
      left = var_gen()
      right = var_gen()
      decls << t1 << t2 << t3 << t4 << left << right
      stmts << AssignStmt.new(t1, LitExp.new("4"))
      stmts << AssignStmt.new(t2, ir(p.lval.val.rval)[:stmts])
      stmts << AssignStmt.new(t3, AopExp.new('*', t1, t2))
      stmts << AssignStmt.new(t4, AddrExp.new(p.lval.val.lval.name))
      stmts << AssignStmt.new(left, AopExp.new('+', t4, t3))
      stmts << AssignStmt.new(right, ir(p.rval)[:stmts])
      stmts << WriteStmt.new(left, right)
    else#other
      if p.lval.class == Unary && p.rval.class == Unary#*<var> = *<exp> 
        t1 = var_gen()
        decls << t1
        stmts << RoadStmt.new(t1, ir(p.rval.val)[:stmts])
        stmts << WriteStmt.new(ir(p.lval.val)[:stmts], t1)
      else
        right = var_gen()
        decls << right
        case p.rval#右辺
        when DIGIT
          stmts << AssignStmt.new(right, ir(p.rval)[:stmts])
        when Binary
          if p.rval.lval.class == Refer
            t1 = var_gen()
            t2 = var_gen()
            decls << t1 << t2
            stmts << AssignStmt.new(t1, ir(p.rval.lval)[:stmts])
            stmts << AssignStmt.new(t2, ir(p.rval.rval)[:stmts])
            stmts << AssignStmt.new(right, AopExp.new(p.rval.op, t1, t2))
          else
            t1 = var_gen()
            t2 = var_gen()
            t3 = var_gen()
            t4 = var_gen()
            decls << t1 << t2 << t3 << t4
            stmts << AssignStmt.new(t1, ir(p.rval.lval.lval)[:stmts])
            stmts << AssignStmt.new(t2, ir(p.rval.lval.rval)[:stmts])
            stmts << AssignStmt.new(t3, AopExp.new(p.rval.lval.op, t1, t2))
            stmts << AssignStmt.new(t4, ir(p.rval.rval)[:stmts])
            stmts << AssignStmt.new(right, AopExp.new(p.rval.op, t3, t4))
          end
        end
        stmts << AssignStmt.new(p.lval.name, right)
      end
    end
    return {decls: decls, stmts: stmts}

    
  when Func_call
    if p.name.name == :print
      case p.arg[0]
      when Refer, DIGIT
        t1 = var_gen()
        decls << t1
        stmts << AssignStmt.new(t1, ir(p.arg[0])[:stmts])
        stmts << PrintStmt.new(t1)
      when Func_call
        t1 = var_gen()
        t2 = var_gen()
        decls << t1 << t2
        if p.arg[0].arg[0].name.class == Env && p.arg[0].arg[0].name.type[0] == :array
          stmts << AssignStmt.new(t1, AddrExp.new(p.arg[0].arg[0].name))
        else
          stmts << AssignStmt.new(t1, ir(p.arg[0].arg[0])[:stmts])
        end
        stmts << CallStmt.new(t2, p.arg[0].name, [t1])
        stmts << PrintStmt.new(t2)
      when Binary
        case p.arg[0].lval
        when Func_call
          t1 = var_gen()
          t2 = var_gen()
          t3 = var_gen()
          decls << t1 << t2 << t3
          if p.arg[0].lval.arg == :void
            stmts << CallStmt.new(t1, p.arg[0].lval.name, :void)
            stmts << AssignStmt.new(t2, ir(p.arg[0].rval)[:stmts])
            stmts << AssignStmt.new(t3, RopExp.new(p.arg[0].op, t1, t2))
          elsif p.arg[0].lval.arg.class == Array
            args = []
            p.arg[0].lval.arg.each do |a|
              t = var_gen()
              decls << t
              args << t
              stmts << AssignStmt.new(t, ir(a)[:stmts])
            end
            stmts << CallStmt.new(t1, p.arg[0].lval.name, args)
            stmts << AssignStmt.new(t2, ir(p.arg[0].rval)[:stmts])
            stmts << AssignStmt.new(t3, RopExp.new(p.arg[0].op, t1, t2))
          end
          stmts << PrintStmt.new(t3)
        when Binary
          if p.arg[0].lval.lval.class == Func_call && p.arg[0].lval.op == '=='
            t0 = var_gen()
            t1 = var_gen()
            t2 = var_gen()
            t3 = var_gen()
            t4 = var_gen()
            t5 = var_gen()
            t6 = var_gen()
            t7 = var_gen()
            t8 = var_gen()
            decls << t0 << t1 << t2 << t3 << t4 << t5 << t6 << t7 << t8
            stmts << AssignStmt.new(t1, ir(p.arg[0].lval.lval.arg[0])[:stmts])
            stmts << CallStmt.new(t2, p.arg[0].lval.lval.name, t1)
            stmts << AssignStmt.new(t3, ir(p.arg[0].lval.rval)[:stmts])
            stmts << AssignStmt.new(t4, RopExp.new(p.arg[0].lval.op, t2, t3))
            stmts << AssignStmt.new(t5, AddrExp.new(p.arg[0].rval.lval.arg[0].name))
            stmts << CallStmt.new(t6, p.arg[0].rval.lval.name, t5)
            stmts << AssignStmt.new(t7, ir(p.arg[0].rval.rval)[:stmts])
            stmts << AssignStmt.new(t8, RopExp.new(p.arg[0].rval.op, t6, t7))
            stmts << AssignStmt.new(t0, RopExp.new(p.arg[0].op, t4, t8))
            stmts << PrintStmt.new(t0)
          elsif p.arg[0].lval.lval.class == Refer
            t0 = var_gen()
            t1 = var_gen()
            t2 = var_gen()
            t3 = var_gen()
            t4 = var_gen()
            t5 = var_gen()
            t6 = var_gen()
            decls << t0 << t1 << t2 << t3 << t4 << t5 << t6
            stmts << AssignStmt.new(t1, ir(p.arg[0].lval.lval)[:stmts])
            stmts << AssignStmt.new(t2, ir(p.arg[0].lval.rval)[:stmts])
            stmts << AssignStmt.new(t3, RopExp.new(p.arg[0].lval.op, t1, t2))
            stmts << AssignStmt.new(t4, ir(p.arg[0].rval.lval)[:stmts])
            stmts << AssignStmt.new(t5, ir(p.arg[0].rval.rval)[:stmts])
            stmts << AssignStmt.new(t6, RopExp.new(p.arg[0].rval.op, t4, t5))
            stmts << AssignStmt.new(t0, RopExp.new(p.arg[0].op, t3, t6))
            stmts << PrintStmt.new(t0)
          elsif p.arg[0].lval.rval.class == Unary
            t0 = var_gen()
            left = var_gen()
            right = var_gen()
            decls << t0 << left << right
            left_stmt = tmp_shift(p.arg[0].lval)#返り値はHash
            decls << left_stmt[:decls]
            stmts << left_stmt[:stmts]
            stmts << AssignStmt.new(left, left_stmt[:var])
            stmts << AssignStmt.new(right, LitExp.new(p.arg[0].rval.name))
            stmts << AssignStmt.new(t0, RopExp.new(p.arg[0].op, left, right))
            stmts << PrintStmt.new(t0)
          elsif p.arg[0].lval.class == Binary && p.arg[0].lval.lval.class == DIGIT
            t0 = var_gen()
            t1 = var_gen()
            t2 = var_gen()
            left = var_gen()
            right = var_gen()
            decls << t0 << t1 << t2 << left << right
            stmts << AssignStmt.new(t1, LitExp.new(p.arg[0].lval.lval.name))
            stmts << AssignStmt.new(t2, LitExp.new(p.arg[0].lval.rval.name))
            stmts << AssignStmt.new(left, AopExp.new(p.arg[0].lval.op, t1, t2))
            stmts << AssignStmt.new(right, LitExp.new(p.arg[0].rval.name))
            stmts << AssignStmt.new(t0, RopExp.new(p.arg[0].op, left, right))
            stmts << PrintStmt.new(t0)
          elsif p.arg[0].lval.class == Binary && p.arg[0].rval.class == Binary &&
                p.arg[0].lval.lval.class == Binary && p.arg[0].lval.lval.lval.class == Refer
            t0 = var_gen()
            t1 = var_gen()
            t2 = var_gen()
            t3 = var_gen()
            t4 = var_gen()
            t5 = var_gen()
            t6 = var_gen()
            t7 = var_gen()
            t8 = var_gen()
            left = var_gen()
            right = var_gen()
            decls << t0 << t1 << t2 << t3 << t4 << t5 << t6 << t7 << t8 << left << right
            stmts << AssignStmt.new(t1, p.arg[0].lval.lval.lval.name)
            stmts << AssignStmt.new(t2, p.arg[0].lval.lval.rval.name)
            stmts << AssignStmt.new(t3, AopExp.new(p.arg[0].lval.lval.op, t1, t2))
            stmts << AssignStmt.new(t4, LitExp.new(p.arg[0].lval.rval.name))
            stmts << AssignStmt.new(left, RopExp.new(p.arg[0].lval.op, t3, t4))
            stmts << AssignStmt.new(t5, p.arg[0].rval.lval.lval.name)
            stmts << AssignStmt.new(t6, p.arg[0].rval.lval.rval.name)
            stmts << AssignStmt.new(t7, AopExp.new(p.arg[0].rval.lval.op, t5, t6))
            stmts << AssignStmt.new(t8, LitExp.new(p.arg[0].rval.rval.name))
            stmts << AssignStmt.new(right, RopExp.new(p.arg[0].rval.op, t7, t8))
            stmts << AssignStmt.new(t0, RopExp.new(p.arg[0].op, left, right))
            stmts << PrintStmt.new(t0)
          else
            t0 = var_gen()
            left = var_gen()
            right = var_gen()
            decls << t0 << left << right
            left_stmt = tmp_shift(p.arg[0].lval)#返り値はHash
            decls << left_stmt[:decls]
            stmts << left_stmt[:stmts]
            stmts << AssignStmt.new(left, left_stmt[:var])
            case p.arg[0].rval#右辺
            when DIGIT
              stmts << AssignStmt.new(right, LitExp.new(p.arg[0].rval.name))
            when Func_call
              args = []
              p.arg[0].rval.arg.each do |a|
                t = var_gen()
                decls << t            
                stmts << AssignStmt.new(t, LitExp.new(a.name))
                args << t
              end
              stmts << CallStmt.new(right, p.arg[0].rval.name, args)
            when Binary
              stmt = p.arg[0].rval
              t1 = var_gen()
              t2 = var_gen()
              decls << t1 << t2
              args = []
              stmt.lval.arg.each do |a|
                t = var_gen()
                decls << t
                stmts << AssignStmt.new(t, LitExp.new(a.name))
                args << t
              end
              stmts << CallStmt.new(t1, stmt.lval.name, args)
              stmts << AssignStmt.new(t2, LitExp.new(stmt.rval.name))
              stmts << AssignStmt.new(right, RopExp.new(stmt.op, t1, t2))
            end
            stmts << AssignStmt.new(t0, RopExp.new(p.arg[0].op, left, right))
            stmts << PrintStmt.new(t0)
          end
        end
      end
    else
      args = []
      p.arg.each do |a|
        t1 = var_gen()
        decls << t1
        stmts << AssignStmt.new(t1, AddrExp.new(a.val.name))
        args << t1
      end
      stmts << Func_call.new(p.name, args, p.pos)
    end
    return {decls: decls, stmts: stmts}


    
  else
    return {decls: [], stmts: []}


  end
  
end
