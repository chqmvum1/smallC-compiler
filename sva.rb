# coding: utf-8

$check_list = []# $semの代わり 一時変数も含めるため
$labels = {}# ラベル名 => 場所


def sva(tree)
  pp $sem
  tree.each do |t|
    if t.class == FunDef && t.body.class == CmpdStmt

      0.upto(2) do |lev|
        $sem[lev].each do |e|
          $check_list << e[1]
        end
      end
      
      t.body.decls.each do |d|
        $check_list << d.var
      end
      $check_list.uniq!
      pp $check_list      
      scope = t.body.stmts.size# - 1
      
      0.upto(scope) do |i|
        if t.body.stmts[i].class == LabelStmt
          key = t.body.stmts[i].name.name.to_sym# ラベルの名前
          $labels[key] =  i# ラベルの位置を格納
        end
      end

      0.upto(scope) do |i|
        block_sva(i, $check_list, t.body.stmts, :none)# 現在の本文の位置、環境に登録されている変数リスト、及び複文全体が引数
      end
      
    else
      # none
    end
    pp $vars
  end
pp $labels
end

# 以降で代入前に使用されているかチェック
# 使用される場合$varsに格納
def block_sva(idx, check_list, stmts, cmpd_or_not)
  $vars[idx] = []
  
  if cmpd_or_not == :cmpd
    pp check_list
    0.upto(stmts.size) do |i|
      $vars[idx][i] = []
      check_list.each do |env|
        ans = used?(env, i, stmts)
        $vars[idx][i] << env.name if ans == :true
      end
    end
    
  else
    check_list.each do |env|
      ans = used?(env, idx, stmts)
      $vars[idx] << env.name if ans == :true
    end
  end
end


def used?(env, idx, stmts)
  idx.upto(stmts.size) do |i|# チェックするのは今見ている以降の文
    
    if env.kind == :proto || env.kind == :fun
      return :false
      break
    end

    
    case stmts[i]
    when CmpdStmt      
      cmpd_check_list = $check_list.clone
      stmts[i].decls.each do |d|
        cmpd_check_list.each_with_index do |c, i|
          if d.var.name == c.name
            cmpd_check_list[i] = d.var
            break
          end
        end
        cmpd_check_list << d.var
      end
      cmpd_check_list.uniq!
      block_sva(i, cmpd_check_list, stmts[i].stmts, :cmpd)


    when IfStmt
      if stmts[i].var.name == env.name ||
         stmts[i].tlabel.label.name == env.name ||
         stmts[i].elabel.label.name == env.name
        return :true
        break
      end


    when LabelStmt
      if stmts[i].name.name == env.name
        return :true
        break
      end


    when GotoStmt
      if stmts[i].label.name == env.name
        key = stmts[i].label.name
        if $labels[key]  > i # labelが現在位置よりも下にあれば
          return :true　　　　# 上へ戻る必要はない
          break
        end
      end
        
    
    when AssignStmt
      if stmts[i].var.name == env.name
        return :false
        break
      else        
        case stmts[i].exp
        when Env
          expr = stmts[i].exp
          if expr.name == env.name
            return :true
            break
          end
        when AopExp, RopExp
          expr = stmts[i].exp
          if expr.left.name == env.name || expr.right.name == env.name
            return :true
            break
          end
        end
      end

      
    when RetStmt
      if stmts[i].var.name == env.name
        return :true
        break
      end
    end


  end
end
