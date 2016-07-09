# coding: utf-8

def lev_check(com, reg, env)
  
  if env.class == LitExp
    $code << "     li   $#{reg}, #{env.val}"
  else
    code = (env.lev == 0) ?  "     #{com}   $#{reg}, #{env.name}" :  "     #{com}   $#{reg}, #{env.offset}($fp)"
  end
  
  return code

end





def gen(block)

  p = (block.class == Array) ? block[0] : block

  case p

  when VarDecl    
    if p.var.type[0] == :array
      $code << "#{p.var.name}:  .word 0 : #{p.var.type[2].to_i}"
    else
      $code << "#{p.var.name}:  .word 0"
    end

    

    
  when FunDef
    $down_sp = -($max_offset - $min_offset + 8) #8 : ra + fp
    $code << "#{p.var.name}:"
    $code << "     addi $sp, $sp, #{$down_sp}  #  #{p.var.name}"
    $code << "     sw   $fp, 0($sp)"
    $code << "     sw   $ra, 4($sp)"
    $code << "     addi $fp, $sp, #{-$min_offset + 8}"

    unless p.parms.empty?
      p.parms.each_with_index do |p, i|
        $code << "     sw   $a#{i}, #{p.offset}($fp)"
      end

    end

    gen(p.body)

    if p.var.name == :main || p.var.type[0][0] == "void"
      $code << "     lw   $ra, 4($sp)"
      $code << "     lw   $fp, 0($sp)"
      $code << "     addi $sp, $sp, #{- $down_sp}"
      $code << "     jr   $ra"
    end


    

  when AssignStmt
    case p.exp#右辺
    when Env
      $code << lev_check('lw', 't0', p.exp)
    when LitExp
      $code << "     li   $t0, #{p.exp.val}"     
    when AopExp
      $code << lev_check('lw', 't0', p.exp.left)
      $code << lev_check('lw', 't1', p.exp.right)
      to_code = { :+ => :add, :- => :sub, :* => :mul, :/ => :div }
      op = to_code[p.exp.op.to_sym]
      $code << "     #{op}  $t0, $t0, $t1"
    when RopExp
      $code << lev_check('lw', 't0', p.exp.left)
      $code << lev_check('lw', 't1', p.exp.right)
      to_code = { :< => :slt, :== => :seq, :>= => :sge, :> => :sgt,
                  :<= => :sle, :!= => :sne, '&&'.to_sym => :and, '||'.to_sym => :or }
      op = to_code[p.exp.op.to_sym]
      $code << "     #{op}  $t0, $t0, $t1"
    when AddrExp
      $code <<  lev_check('la', 't0', p.exp.var)     
    end
    
    $code << lev_check('sw', 't0', p.var)#左辺   


    
    
  when WriteStmt#*<dest> = <src>
    $code << lev_check('lw', 't1', p.dest)
    $code << lev_check('lw', 't0', p.src)
    $code << "     sw   $t0, 0($t1)"



    
  when RoadStmt#<dest> = *<src>
    $code << lev_check('lw', 't0', p.src)
    $code << "     lw   $t1, 0($t0)"
    $code << lev_check('sw', 't1', p.dest)    


    

  when LabelStmt
    $code << "#{p.name.name}:"



    
  when GotoStmt
    $code << "     j    #{p.label.name}"


    
    
  when IfStmt
    $code <<  lev_check('lw', 't0', p.var)
    $code << "     beqz $t0, #{p.elabel.label.name}"
    $code << "     j    #{p.tlabel.label.name}"

    
      
    
  when CallStmt
    if p.vars == :void
      # none
    elsif p.vars.class == Env
      $code <<  lev_check("lw", "a0", p.vars)
    else
      p.vars.each_with_index do |v, i|
        $code <<  lev_check("lw", "a#{i}", v)
      end
    end
    $code << "     jal  #{p.tgt.name}"
    $code << lev_check('sw', 'v0', p.dest)    


    

  when Func_call   
    if p.arg == :void
      # none
    elsif p.arg.class == Env
      $code <<  lev_check("lw", "a0", p.arg)
    else
      p.arg.each_with_index do |v, i|
        $code <<  lev_check("lw", "a#{i}", v)
      end
    end
    $code << "     jal  #{p.name.name}"


    

  when RetStmt
    $code << lev_check('lw', 'v0', p.var)
    $code << "     lw   $ra, 4($sp)"
    $code << "     lw   $fp, 0($sp)"
    $code << "     addi $sp, $sp, #{- $down_sp}"
    $code << '     jr   $ra'
    


    
  when CmpdStmt
    p.stmts.each {|s| gen(s) }


    

  when PrintStmt
    $code << "     li   $v0, 1"
    $code << lev_check('lw', 'a0', p.var)
    $code << "     syscall"
    $code << "     li   $v0, 4"
    $code << '     la   $a0, line_break'
    $code << "     syscall"    

    
  else
    #none
    
  end
end
