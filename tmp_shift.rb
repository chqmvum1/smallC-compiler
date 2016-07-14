# coding: utf-8


require_relative './ir_class.rb'
require_relative './class.rb'



def ir_args(stmts, decls, arg)

  args = []

  unless arg == :void
    arg.each do |a|
      t = var_gen()
      decls << t
      stmts << AssignStmt.new(t, LitExp.new(a.name))
      args << t
    end
  end

  return args
  
end





def ir_read(stmts, decls, var)
  
  t1 = var_gen()
  t2 = var_gen()
  t3 = var_gen()
  t4 = var_gen()
  t5 = var_gen()
  t6 = var_gen()
  decls << t1 << t2 << t3 << t4 << t5 << t6
  stmts << AssignStmt.new(t1, AddrExp.new(var.val.lval.name))
  stmts << AssignStmt.new(t2, LitExp.new("4"))
  stmts << AssignStmt.new(t3, LitExp.new(var.val.rval.name))
  stmts << AssignStmt.new(t4, AopExp.new('*', t2, t3))
  stmts << AssignStmt.new(t5, AopExp.new(var.val.op, t1, t4))
  stmts << RoadStmt.new(t6, t5)

  return t6
  
end





def tmp_shift(lefts)#for Binary

  stmts = []
  decls = []
  tmp = var_gen()
  decls << tmp

  if lefts.lval.class == Func_call
    
    largs = []
    rargs = []
    t1 = var_gen()
    t2 = var_gen()
    decls << t1 << t2
    
    lefts.lval.arg.each do |a|
      t = var_gen()
      decls << t
      stmts << AssignStmt.new(t, LitExp.new(a.name))
      largs << t
    end
    stmts << CallStmt.new(t1, lefts.lval.name, largs)

    lefts.rval.arg.each do |a|
      t = var_gen()
      decls << t
      stmts << AssignStmt.new(t, LitExp.new(a.name))
      rargs << t
    end
    stmts << CallStmt.new(t2, lefts.rval.name, rargs)
    
    stmts << AssignStmt.new(tmp, RopExp.new(lefts.op, t1, t2))  
    
   
  elsif lefts.lval.op == '=='

    t1 = var_gen()
    t2 = var_gen()
    t3 = var_gen()
    t4 = var_gen()
    t5 = var_gen()
    t6 = var_gen()
    decls << t1 << t2 << t3 << t4 << t5 << t6

    largs = []
    rargs = []
    
    lefts.lval.lval.arg.each do |a|
      t = var_gen()
      decls << t
      stmts << AssignStmt.new(t, LitExp.new(a.name))
      largs << t
    end
    stmts << CallStmt.new(t1, lefts.lval.lval.name, largs)
    stmts << AssignStmt.new(t2, LitExp.new(lefts.lval.rval.name))
    stmts << AssignStmt.new(t3, RopExp.new(lefts.lval.op, t1, t2))


    lefts.rval.lval.arg.each do |a|
      t = var_gen()
      decls << t
      stmts << AssignStmt.new(t, LitExp.new(a.name))
      rargs << t
    end
    stmts << CallStmt.new(t4, lefts.rval.lval.name, rargs)
    stmts << AssignStmt.new(t5, LitExp.new(lefts.rval.rval.name))
    stmts << AssignStmt.new(t6, RopExp.new(lefts.rval.op, t4, t5))

    stmts << AssignStmt.new(tmp, RopExp.new(lefts.op, t3, t6))

    
    
  else
    if lefts.rval.class == Unary
      
      t1 = var_gen()
      decls << t1

      stmts << AssignStmt.new(t1, AopExp.new(lefts.op, ir_read(stmts, decls, lefts.lval.lval.lval.lval.lval.lval.lval.lval.lval), ir_read(stmts, decls, lefts.lval.lval.lval.lval.lval.lval.lval.lval.rval)))

      if lefts.lval.class == Binary
        t2 = var_gen()
        decls << t2
      else
        return {stmts: stmts, decls: decls, var: t1}
      end
      
      stmts << AssignStmt.new(t2, AopExp.new(lefts.op, t1, ir_read(stmts, decls, lefts.lval.lval.lval.lval.lval.lval.lval.rval)))

      if lefts.lval.lval.class == Binary
        t3 = var_gen()
        decls << t3
      else
        return {stmts: stmts, decls: decls, var: t2}
      end
           
      stmts << AssignStmt.new(t3, AopExp.new(lefts.op, t2, ir_read(stmts, decls, lefts.lval.lval.lval.lval.lval.lval.rval)))

      if lefts.lval.lval.lval.class == Binary
        t4 = var_gen()
        decls << t4
      else
        return {stmts: stmts, decls: decls, var: t3}
      end
            
      stmts << AssignStmt.new(t4, AopExp.new(lefts.op, t3, ir_read(stmts, decls, lefts.lval.lval.lval.lval.lval.rval)))

      if lefts.lval.lval.lval.lval.class == Binary
        t5 = var_gen()
        decls << t5
      else
        return {stmts: stmts, decls: decls, var: t4}
      end
      
      stmts << AssignStmt.new(t5, AopExp.new(lefts.op, t4, ir_read(stmts, decls, lefts.lval.lval.lval.lval.rval)))

      if lefts.lval.lval.lval.lval.lval.class == Binary
        t6 = var_gen()
        decls << t6
      else
        return {stmts: stmts, decls: decls, var: t5}
      end
      
      stmts << AssignStmt.new(t6, AopExp.new(lefts.op, t5, ir_read(stmts, decls, lefts.lval.lval.lval.rval)))

      if lefts.lval.lval.lval.lval.lval.lval.class == Binary
        t7 = var_gen()
        decls << t7
      else
        return {stmts: stmts, decls: decls, var: t6}
      end
     
      stmts << AssignStmt.new(t7, AopExp.new(lefts.op, t6, ir_read(stmts, decls, lefts.lval.lval.rval)))

      if lefts.lval.lval.lval.lval.lval.lval.lval.class == Binary
        t8 = var_gen()
        decls << t8
      else
        return {stmts: stmts, decls: decls, var: t7}
      end
     
      stmts << AssignStmt.new(t8, AopExp.new(lefts.op, t7, ir_read(stmts, decls, lefts.lval.rval)))
      stmts << AssignStmt.new(tmp, AopExp.new(lefts.op, t8, ir_read(stmts, decls, lefts.rval)))
          
    else
      
      t1 = var_gen()
      t2 = var_gen()
      t3 = var_gen()
      t4 = var_gen()
      t5 = var_gen()
      t6 = var_gen()
      t7 = var_gen()
      t8 = var_gen()
      t9 = var_gen()
      t10 = var_gen()
      t11 = var_gen()
      t12 = var_gen()
      t13 = var_gen()
      t14 = var_gen()
      t15 = var_gen()
      t16 = var_gen()

     decls << t1 << t2 << t3 << t4 << t5 << t6 << t7 << t8 << t9 << t10 << t11 << t12 << t13 << t14 << t15 << t16
      

      stmts << CallStmt.new(t1, lefts.lval.lval.lval.lval.name, ir_args(stmts, decls, lefts.lval.lval.lval.lval.arg))
      stmts << AssignStmt.new(t2, LitExp.new(lefts.lval.lval.lval.rval.name))
      stmts << AssignStmt.new(t3, RopExp.new(lefts.lval.lval.lval.op, t1, t2))
      
      stmts << CallStmt.new(t4, lefts.lval.lval.rval.lval.name, ir_args(stmts, decls, lefts.lval.lval.rval.lval.arg))
      stmts << AssignStmt.new(t5, LitExp.new(lefts.lval.lval.rval.rval.name))
      stmts << AssignStmt.new(t6, RopExp.new(lefts.lval.lval.rval.op, t4, t5))

      stmts << AssignStmt.new(t7, RopExp.new(lefts.op, t3, t6))
                                                                               
      stmts << CallStmt.new(t8, lefts.lval.rval.lval.name, ir_args(stmts, decls, lefts.lval.rval.lval.arg))
      stmts << AssignStmt.new(t9, LitExp.new(lefts.lval.rval.rval.name))
      stmts << AssignStmt.new(t10, RopExp.new(lefts.lval.rval.op, t8, t9))

      stmts << AssignStmt.new(t11, RopExp.new(lefts.op, t7, t10))

      stmts << CallStmt.new(t12, lefts.rval.lval.name, ir_args(stmts, decls, lefts.rval.lval.arg))
      stmts << AssignStmt.new(t13, LitExp.new(lefts.rval.rval.lval.name))
      stmts << AssignStmt.new(t14, LitExp.new(lefts.rval.rval.rval.name))
      stmts << AssignStmt.new(t15, AopExp.new(lefts.rval.rval.op, t13, t14))
      stmts << AssignStmt.new(t16, RopExp.new(lefts.rval.op, t12, t15))


      stmts << AssignStmt.new(tmp, RopExp.new(lefts.op, t11, t16))
      
    end
    
    
  end
  
  return {stmts: stmts, decls: decls, var: tmp}
  
end
