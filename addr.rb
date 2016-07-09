# coding: utf-8

def addr(block)

  p = (block.class == Array) ? block[0] : block
  case p

  when FunDef
    p.parms.each do |parm|
      parm.offset = $p_offset
      if parm.type[0] == :array
        $p_offset += 4 * parm.type[2].to_i
      else
        $p_offset += 4
      end
    end
    $max_offset = $p_offset
    addr(p.body)
  
  
  when CmpdStmt
    if p.decls
      p.decls.each do |decl|
        if decl.var.type[0] == :array
          $v_offset -= 4 * decl.var.type[2].to_i
        else
          $v_offset -= 4
        end
        decl.var.offset = $v_offset
      end
    end
    $min_offset = ($v_offset < 0) ? $v_offset : 0
    p.stmts.each do |stmt|
      addr(stmt)
    end
    
  else
    #none
  end
end
