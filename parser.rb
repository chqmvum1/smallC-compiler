# 
# 構文解析メソッド MyParser#parse
#

class MyParser

/* token: 終端記号 */
token
'+' '-' '*' '/' '<=' '<' '>=' '>' '==' '=' '&' '!=' '&&' '||'
SEMI LPAR RPAR COMMA RETURN LBRA RBRA LBBRA RBBRA
INT VOID IF ELSE WHILE DO FOR RETURN EOF DIGIT IDENTIFIER

/* 文法定義 */
rule

target
: program
| /* none */

program
: external_declaration   {result = [val]}
| program external_declaration   { result << [val[1]] }

external_declaration
: declaration
| function_prototype
| function_definition

declaration
: type_specifier declarator_list SEMI   { result = Declaration.new(val[0], val[1], @pos)}

declarator_list
: declarator   { result = val }
| declarator_list COMMA declarator   { result = val[0] << val[2] }

declarator
: direct_declarator   { result = [:none, val].flatten }
| '*' direct_declarator   { result = '*', val[1] }

direct_declarator
: IDENTIFIER   { result = ID.new(val[0], @pos) }
| IDENTIFIER LBBRA DIGIT RBBRA   { result = Ary.new(val[0], val[2], @pos) }

function_prototype
: type_specifier function_declarator SEMI   { result = Func_proto.new(val[0], val[1][0], val[1][1], @pos ) }

function_declarator  #{name, * or :none, param-list,pos}
: IDENTIFIER LPAR parameter_type_list RPAR    { result = ID.new([:none, val[0]], @pos),  val[2], @pos }
| IDENTIFIER LPAR RPAR    { result = ID.new([:none, val[0]], @pos), [], @pos }
| '*' IDENTIFIER LPAR parameter_type_list RPAR   { result = ID.new(['*', val[1]], @pos), val[3], @pos  }
| '*' IDENTIFIER LPAR RPAR   { result = ID.new(['*', val[1]], @pos), [], @pos }

function_definition  #(type, name, arg, contents, pos)
: type_specifier function_declarator compound_statement
{ result =  Func_def.new(val[0], val[1][0], val[1][1], val[2], @pos) }

parameter_type_list
: parameter_declaration   { result = val }
| parameter_type_list COMMA parameter_declaration   { result = val[0] << val[2] }

parameter_declaration
: type_specifier parameter_declarator   { result = val.flatten  }

parameter_declarator
: IDENTIFIER   { result = [ ID.new( [:none, val[0]], @pos) ] }
| '*' IDENTIFIER   { result = ID.new( ['*', val[1]],  @pos) }

type_specifier
: INT
| VOID

statement
: SEMI
| expression SEMI
| compound_statement   { result = val }
/* syntax sugar */
| IF LPAR expression RPAR statement   { result = IF.new(val[2], val[4], ';', @pos) }
| IF LPAR expression RPAR statement ELSE statement   { result = IF.new( val[2],  val[4], val[6], @pos) }
| DO statement WHILE LPAR expression RPAR   { result = val[1], While.new(val[4], val[2], @pos) }
| WHILE LPAR expression RPAR statement   { result = While.new(val[2], val[4], @pos) }
/* syntax sugar */
| FOR LPAR expression_opt SEMI expression_opt SEMI expression_opt RPAR  statement
{ result = val[2], While.new(val[4], [val[8], val[6]], @pos) }
| RETURN expression_opt SEMI   { result = Return.new(val[1], @pos ) }

expression_opt
: expression
| /* none */

compound_statement
: LBRA declaration_list statement_list RBRA   { result = Compound.new(val[1], val[2], @pos) }
| LBRA declaration_list RBRA   { result =  Compound.new(val[1], nil, @pos ) }
| LBRA statement_list RBRA   { result = Compound.new(nil, val[1], @pos ) }
| LBRA RBRA

declaration_list
: declaration   { result = val }
| declaration_list declaration   { result = [val[0], val[1]].flatten(1) }

statement_list
: statement
| statement_list statement    { result = [val[0], val[1]].flatten(1) }

expression
: assign_expr
| expression COMMA assign_expr   { result = val[0], val[2] }

assign_expr
: logical_OR_expr
| logical_OR_expr '=' assign_expr   { result = Binary.new('=', val[0], val[2], @pos) }

logical_OR_expr
: logical_AND_expr
| logical_OR_expr '||' logical_AND_expr   { result = Binary.new('||', val[0], val[2], @pos) }

logical_AND_expr
: equality_expr
| logical_AND_expr '&&' equality_expr   { result = Binary.new('&&', val[0], val[2], @pos) }

equality_expr
: relational_expr
| equality_expr '==' relational_expr   { result = Binary.new('==', val[0], val[2], @pos) }
| equality_expr '!=' relational_expr   { result = Binary.new('!=', val[0], val[2], @pos) }

relational_expr
: add_expr
| relational_expr '<' add_expr    { result = Binary.new('<', val[0], val[2], @pos) }
| relational_expr '>' add_expr    { result = Binary.new('>', val[0], val[2], @pos) }
| relational_expr '<=' add_expr   { result = Binary.new('<=', val[0], val[2], @pos) }
| relational_expr '>=' add_expr   { result = Binary.new('>=', val[0], val[2], @pos) }

add_expr
: mult_expr
| add_expr '+' mult_expr     { result = Binary.new('+', val[0], val[2], @pos) }
| add_expr '-' mult_expr     { result = Binary.new('-', val[0], val[2], @pos) }

mult_expr
: unary_expr
| mult_expr '*' unary_expr    { result = Binary.new('*', val[0], val[2], @pos) }
| mult_expr '/' unary_expr    { result = Binary.new('/', val[0], val[2], @pos) }

unary_expr
: postfix_expr
| '-' unary_expr   { result = Binary.new('-', DIGIT.new(0, @pos), val[1], @pos) }
/* syntax sugar */
| '&' unary_expr   {
  if val[1].class == Unary && val[1].op == '*'
    result = val[1].val
  else
    result = Unary.new('&', val[1], @pos)
  end
}
| '*' unary_expr   { result = Unary.new('*', val[1], @pos) }

postfix_expr
: primary_expr
/* syntax sugar */  
| postfix_expr LBBRA expression RBBRA   { result = Unary.new('*', Binary.new('+', val[0], val[2], @pos), @pos) }
| IDENTIFIER LPAR argument_expression_list RPAR   { result = Refer.new(val[0], val[2], @pos) }
| IDENTIFIER LPAR RPAR    { result = Refer.new(val[0], :void, @pos) }

primary_expr
: IDENTIFIER    { result = Refer.new(val[0], nil, @pos) }
| DIGIT   { result = DIGIT.new(val[0], @pos) }
| LPAR expression RPAR   { result = val[1] }

argument_expression_list
: assign_expr   { result = val }
| argument_expression_list COMMA assign_expr   { result = val[0] << val[2] }

end

---- header ----

require 'pp'
require_relative './class.rb'
require_relative './lexer.rb'
require_relative './analize.rb'
require_relative './ir.rb'

---- inner ----
  def parse
    begin
      filename = ARGV[0]
      @tokens = lexscan(filename)
      do_parse
    rescue Racc::ParseError => e
      $stderr.puts e, e.backtrace
      $stderr.print "parse error : at #{@pos}\n"
    end
  end
  
  def next_token
    @info = @tokens.shift
    @pos = @info[1][1] if @info
    [@info[0], @info[1][0]] if @info
  end

---- footer ----
    
    if __FILE__ == $0
      parser = MyParser.new
      tree = parser.parse
      $sem = []
      $sem[0] = {}
      $sem[0][:print] = Env.new(:print, :proto, [["void", :none], [["int", :none]]])
      tree.each do |block|
        analize(block, 0)
        $sem.each_with_index do |h, i|
          next if i == 0
          h.clear
        end
      end
      pp tree.flatten!(1)
      tree.each do |block|
        ir(block)
      end
      pp $mid
    end
