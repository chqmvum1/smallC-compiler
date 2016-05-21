#
# 字句解析メソッドlexscan
#


def lexscan(filename)
  
  tokens = []
  file = File.open(filename)
  file.each_line do |line| #ファイルの内容を一行ずつ読み込む
    regexp = /([\w]+|\+|-|\*|\/|>=|<=|>|<|\(|\)|\[|\]|\{|\}|==|=|!=|,|;|&&|&|\|\|)/
    ary = line.split(regexp).select {|s| !s.empty? }
    i = 0
    
    ary.each do |obj|
      idx = line.index(ary[i])
      pos = "(l#{file.lineno}, #{idx})"
      case obj
      when  "int", "void", "if", "else", "do", "while", "for", "return"
        token = [obj.upcase.to_sym , ["#{obj}", "#{pos}"]]
      when  "\+", "-", "\*", "\/", ">", "<", ">=", "<=", "==", "=", "!=", "&&", "&", "\|\|"
        token = [ obj , ["#{obj}", "#{pos}"]]
      when "\["
        token = [:LBBRA, ["#{obj}", "#{pos}"]]
      when "\]"
        token = [:RBBRA, ["#{obj}", "#{pos}"]]
      when "\("
        token = [:LPAR, ["#{obj}", "#{pos}"]]
      when "\)"
        token = [:RPAR, ["#{obj}", "#{pos}"]]
      when "\{"
        token = [:LBRA, ["#{obj}", "#{pos}"]]
      when "\}"
        token = [:RBRA, ["#{obj}", "#{pos}"]]
      when ","
        token = [:COMMA, ["#{obj}", "#{pos}"]]
      when ";"
        token = [:SEMI, ["#{obj}", "#{pos}"]]
      else
        if /^[A-Za-z_]/ =~ obj
          token = [:IDENTIFIER, ["#{obj}", "#{pos}"]]
        elsif /^[0-9]+$/ =~ obj
          num = obj.to_i
          token = [:DIGIT, ["#{num}", "#{pos}"]]
        else
          token = "BLANK"
        end
      end
      
      if token != "BLANK"
        tokens << token
      end
      i += 1
    end
  end
  file.close
  return tokens
end
