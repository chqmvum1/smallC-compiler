# coding: utf-8



$labels = {}# ラベル名 => 場所
$break = :false


def sva(tree)

  pp $sem

  tree.each do |t|
    
    if t.class == FunDef && t.body.class == CmpdStmt
      check_list = []# $semの代わり 一時変数も含めるため
      0.upto(2) do |lev|
        $sem[lev].each do |e|
          check_list << e[1]
        end
      end
      
      t.body.decls.each do |d|
        check_list << d.var
      end
      check_list.uniq!
      pp check_list
      
      scope = t.body.stmts.size# - 1
      
      0.upto(scope) do |i|
        if t.body.stmts[i].class == LabelStmt
          key = t.body.stmts[i].name.name.to_sym# ラベルの名前
          $labels[key] =  i# ラベルの位置を格納
        end
      end
      pp $labels

      0.upto(scope) do |i|
        block_sva(i, check_list, t.body.stmts)# 現在の本文の位置、環境に登録されている変数リスト、及び複文全体が引数
      end
      
    else
      # none
    end
    pp $vars
  end
end




# 以降で代入前に使用されているかチェック
# 使用される場合$varsに格納

def block_sva(idx, check_list, stmts)

  $vars[idx] = []
  
  if stmts[idx].class == CmpdStmt


    cmpd_check_list = check_list.clone
    stmts[idx].decls.each do |d|
      cmpd_check_list.each_with_index do |c, i|
        if d.var.name == c.name
          cmpd_check_list[i] = d.var
          break
        end
      end
      cmpd_check_list << d.var
    end
    cmpd_check_list.uniq!
    pp cmpd_check_list
    cmpd_stmts = stmts[idx].stmts
    
    0.upto(cmpd_stmts.size) do |i|
      $vars[idx][i] = []
      cmpd_check_list.each do |env|
        $break = :false if $break == :true
        in_flag = used?(env, i, cmpd_stmts.size, cmpd_stmts) #CmpdStmt内部
        if in_flag == :true
          if env.lev == 99
            $vars[idx][i] << env.name
          else
            $vars[idx][i] << [env.name, env.lev]
          end
        end

        if in_flag == :unknown
          check_list.each do |c|
            if env.name == c.name && env.lev == c.lev + 1
              env = c
            end
          end
          out_flag = used?(env, idx + 1, stmts.size, stmts) #CmpdStmt外部
          if out_flag == :true
            if env.lev == 99
              $vars[idx][i] << env.name
            else
              $vars[idx][i] << [env.name, env.lev]
            end
          end
        end
        
      end
      $vars[idx][i].uniq!
    end

    

  else
    check_list.each do |env|
      $break = :false if $break == :true
      flag = used?(env, idx, stmts.size, stmts)
      if flag == :true
        if env.lev == 99
          $vars[idx] << env.name
          $vars[idx].uniq!
        else
          $vars[idx] << [env.name, env.lev]
          $vars[idx].uniq!
        end
      end
    end
  end
  
end





def used?(env, from, to, stmts)

  flag = :unknown
  
  from.upto(to) do |i|# 今見ている以降の文からスタート
    
    case stmts[i]    

        
    when VarDecl
      # none



      
    when CmpdStmt
      now_env = env
      stmts[i].decls.each do |d|
        now_env = d.var if d.var.name == env.name
      end
      flag = used?(now_env, 0, stmts[i].stmts.size, stmts[i].stmts)
      break if flag == :true
      next if flag == :unknown



      
    when IfStmt
      if stmts[i].var.name == env.name ||
         stmts[i].tlabel.label.name == env.name ||
         stmts[i].elabel.label.name == env.name
        flag = :true
        break
      else
        tlabel = stmts[i].tlabel.label.name.to_sym
        elabel = stmts[i].elabel.label.name.to_sym
        tflag = used?(env, $labels[tlabel], stmts.size, stmts)
        eflag = used?(env, $labels[elabel], stmts.size, stmts)
        flag = :true if tflag == :true || eflag == :true
        break
      end


      
      
    when LabelStmt
      if stmts[i].name.name == env.name
        flag = :true
        break
      end

      

      
    when GotoStmt
      if stmts[i].label.name == env.name
        flag = :true
        break
      else
        label = stmts[i].label.name.to_sym
        if $labels[label] > i
          flag = used?(env, $labels[label], stmts.size, stmts)
          break
        else
          if $break == :false
            $break = :true
            flag = used?(env, $labels[label], i, stmts)
            break
          else# $break == :true のとき
            break
          end
        end
      end

      
      


    when CallStmt
      if stmts[i].dest.name == env.name ||
         stmts[i].tgt.name == env.name
        flag = :true
      elsif stmts[i].vars.class == Array
        stmts[i].vars.each do |a|
          if a.name == env.name
            flag = :true
            break
          end
        end
      end
      break if flag == :true
      
        


    when Func_call
      if stmts[i].name.name == env.name
        flag = :true
      elsif stmts[i].arg.class == Array
        stmts[i].arg.each do |a|
          if a.name == env.name
            flag = :true
            break
          end
        end
      end
      break if flag == :true
      

      
      
    when PrintStmt
      if stmts[i].var.name == env.name
        flag = :true
        break
      end
      
      

      

    when RoadStmt
      if stmts[i].dest.name == env.name || stmts[i].src.name == env.name
        flag = :true
        break
      end




      
    when WriteStmt
      if stmts[i].dest.name == env.name || stmts[i].src.name == env.name
        flag = :true
        break
      end
      
      

      
      
    when AssignStmt
      if stmts[i].var.name == env.name # 使われる前に更新(代入)されている
        flag = :false
        break
      else        
        case stmts[i].exp
        when Env
          expr = stmts[i].exp
          if expr.name == env.name
            flag = :true
            break
          end
        when AopExp, RopExp
          expr = stmts[i].exp
          if expr.left.name == env.name || expr.right.name == env.name
            flag = :true
            break
          end
        when AddrExp
          flag = :true
          break
        end
      end


      
      
    when RetStmt
      if stmts[i].var.name == env.name
        flag = :true
        break
      end
    end

    
  end
  
  return flag
  
end
