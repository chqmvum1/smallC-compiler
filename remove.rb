# coding: utf-8

$flags = []



def remove(tree)


  tree.each do |t|

    if t.class == FunDef && t.body.class == CmpdStmt

      stmts = t.body.stmts
      scope = stmts.size - 1
      
      0.upto(scope) do |i|

        
        if stmts[i].class == CmpdStmt
          
          cmpd_stmts = stmts[i].stmts
          flags = []
          0.upto(cmpd_stmts.size - 1) do |j|

            flag = :not

            if cmpd_stmts[j].class == AssignStmt
              if $vars[i][j + 1] == nil
                $vars[i + 1].each do |v|
                  if v == cmpd_stmts[j].var.name ||
                     v.class == Array && v[0] == cmpd_stmts[j].var.name && v[1] == cmpd_stmts[j].var.lev
                    flag = :use
                    break
                  end
                end
                            
              else
                flag = :not if $vars[i][j + 1] == nil || $vars[i][j + 1].empty?
                if $vars[i][j + 1].class == Array
                  $vars[i][j + 1].each do |v|
                    if v == cmpd_stmts[j].var.name ||
                       v.class == Array && v[0] == cmpd_stmts[j].var.name && v[1] == cmpd_stmts[j].var.lev
                      flag = :use
                      break
                    end
                  end
                end
              end
              
            else
              flag = :use
              
            end
            
            flags << flag
          end
          $flags[i] = flags
          
          
        else
          
          flag = :not
          if stmts[i].class == AssignStmt
            flag = :not if $vars[i + 1].empty?

            if stmts[i + 1].class == CmpdStmt
              $vars[i + 1].each do |ary|
                if ary.class == Array
                  ary.each do |v|
                    if v == stmts[i].var.name ||
                       v.class == Array && v[0] == stmts[i].var.name && v[1] == stmts[i].var.lev
                      flag = :use
                      break
                    end
                  end
                end
              end

              
            else
              
              
              $vars[i + 1].each do |v|
                if v == stmts[i].var.name ||
                   v.class == Array && v[0] == stmts[i].var.name && v[1] == stmts[i].var.lev
                  flag = :use
                  break
                end
              end
              
            end
            
          else
            flag = :use
            
          end

          $flags[i] = flag
          
        end
        
      end


      stmts = t.body.stmts
      
      stmts.each_with_index do |block, i|

        if stmts[i].class == CmpdStmt
          stmts[i].stmts.each_with_index do |s, j|
            if $flags[i][j] == :not
               stmts[i].stmts[j] = nil
            end
          end
          
          
        else
          if $flags[i] == :not
             stmts[i] = nil
          end
        end
      end
    end
    
  end
  
end
