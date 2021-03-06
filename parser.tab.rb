#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.14
# from Racc grammer file "".
#

require 'racc/parser.rb'


require 'pp'
require_relative './class.rb'
require_relative './lexer.rb'
require_relative './analize.rb'
require_relative './ir.rb'
require_relative './sva.rb'
require_relative './remove.rb'
require_relative './addr.rb'
require_relative './gen.rb'

class MyParser < Racc::Parser

module_eval(<<'...end parser.rb/module_eval...', 'parser.rb', 233)
     
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

...end parser.rb/module_eval...
##### State transition tables begin ###

racc_action_table = [
    38,    76,    62,    64,    76,    65,    25,    66,   134,   139,
   138,    41,    99,    42,    43,    44,    45,    27,    99,    38,
    76,    62,    64,    27,    65,    23,    66,   137,    31,    60,
    41,    61,    42,    43,    44,    45,    27,    86,    62,    64,
   100,    65,    38,    66,    62,    64,   100,    65,    60,    66,
    61,     8,     9,    41,   136,    42,    43,    44,    45,    27,
    84,    38,    71,    62,    64,    60,    65,    61,    66,   107,
    99,    60,    41,    61,    42,    43,    44,    45,    27,   116,
    38,   141,    62,    64,    76,    65,    23,    66,   140,    24,
    60,    41,    61,    42,    43,    44,    45,    27,   100,    38,
    76,    62,    64,   115,    65,   112,    66,   148,   109,    60,
    41,    61,    42,    43,    44,    45,    27,    76,    38,    71,
    62,    64,   105,    65,   135,    66,    70,   101,    60,    41,
    61,    42,    43,    44,    45,    27,    90,    38,    80,    62,
    64,    79,    65,    77,    66,    29,    30,    60,    41,    61,
    42,    43,    44,    45,    27,    69,    62,    64,    23,    65,
    38,    66,    62,    64,    30,    65,    60,    66,    61,     8,
     9,    41,    32,    42,    43,    44,    45,    27,    48,    62,
    64,   147,    65,    60,    66,    61,    22,    62,    64,    60,
    65,    61,    66,    62,    64,   149,    65,    18,    66,    62,
    64,    10,    65,   152,    66,    90,    60,   nil,    61,   nil,
    62,    64,   nil,    65,    60,    66,    61,   nil,    62,    64,
    60,    65,    61,    66,    62,    64,    60,    65,    61,    66,
    62,    64,   nil,    65,   nil,    66,   nil,    60,   nil,    61,
   nil,    62,    64,   nil,    65,    60,    66,    61,   nil,    62,
    64,    60,    65,    61,    66,    62,    64,    60,    65,    61,
    66,    62,    64,   nil,    65,   nil,    66,   nil,    60,   nil,
    61,   nil,    62,    64,   nil,    65,    60,    66,    61,   nil,
    62,    64,    60,    65,    61,    66,    62,    64,    60,    65,
    61,    66,    62,    64,   nil,    65,   nil,    66,   nil,    60,
   nil,    61,    68,     8,     9,    62,    64,    60,    65,    61,
    66,   132,   nil,    60,   nil,    61,   nil,    62,    64,    60,
    65,    61,    66,    62,    64,   nil,    65,   nil,    66,   nil,
    62,    64,    60,    65,    61,    66,    62,    64,   nil,    65,
   nil,    66,    62,    64,    60,    65,    61,    66,    62,    64,
    60,    65,    61,    66,   nil,    62,    64,    60,    65,    61,
    66,    62,    64,    60,    65,    61,    66,    62,    64,    60,
    65,    61,    66,    74,    73,    60,   nil,    61,    93,    94,
    95,    96,    60,   nil,    61,    34,     8,     9,    60,   nil,
    61,    75,    76,   nil,    60,   nil,    61,    93,    94,    95,
    96,    93,    94,    95,    96,    97,    98,    29,    30,    88,
    89,    97,    98,    91,    92,    19,    20,    15,    16,     8,
     9,    97,    98,     8,     9,    97,    98,    97,    98,    91,
    92,     8,     9 ]

racc_action_check = [
   152,   106,   152,   152,   130,   152,    17,   152,   106,   130,
   114,   152,   126,   152,   152,   152,   152,   152,    57,    47,
   113,    47,    47,    17,    47,    22,    47,   113,    22,   152,
    47,   152,    47,    47,    47,    47,    47,    47,    92,    92,
   126,    92,    46,    92,    46,    46,    57,    46,    47,    46,
    47,    46,    46,    46,   112,    46,    46,    46,    46,    46,
    46,    83,    67,    83,    83,    92,    83,    92,    83,    67,
   127,    46,    83,    46,    83,    83,    83,    83,    83,    83,
   147,   131,   147,   147,    82,   147,    16,   147,   131,    16,
    83,   147,    83,   147,   147,   147,   147,   147,   127,    42,
   143,    42,    42,    81,    42,    78,    42,   143,    74,   147,
    42,   147,    42,    42,    42,    42,    42,   111,   135,    33,
   135,   135,    64,   135,   111,   135,    33,    59,    42,   135,
    42,   135,   135,   135,   135,   135,    53,   137,    44,   137,
   137,    43,   137,    41,   137,    37,    37,   135,   137,   135,
   137,   137,   137,   137,   137,    32,    95,    95,    30,    95,
    27,    95,    27,    27,    29,    27,   137,    27,   137,    27,
    27,    27,    23,    27,    27,    27,    27,    27,    27,   141,
   141,   142,   141,    95,   141,    95,    15,    94,    94,    27,
    94,    27,    94,    97,    97,   145,    97,    10,    97,   138,
   138,     1,   138,   151,   138,   118,   141,   nil,   141,   nil,
    98,    98,   nil,    98,    94,    98,    94,   nil,    93,    93,
    97,    93,    97,    93,   136,   136,   138,   136,   138,   136,
    96,    96,   nil,    96,   nil,    96,   nil,    98,   nil,    98,
   nil,    91,    91,   nil,    91,    93,    91,    93,   nil,    60,
    60,   136,    60,   136,    60,    89,    89,    96,    89,    96,
    89,    99,    99,   nil,    99,   nil,    99,   nil,    91,   nil,
    91,   nil,   100,   100,   nil,   100,    60,   100,    60,   nil,
    88,    88,    89,    88,    89,    88,   101,   101,    99,   101,
    99,   101,    45,    45,   nil,    45,   nil,    45,   nil,   100,
   nil,   100,    31,    31,    31,   105,   105,    88,   105,    88,
   105,   105,   nil,   101,   nil,   101,   nil,   149,   149,    45,
   149,    45,   149,    80,    80,   nil,    80,   nil,    80,   nil,
    79,    79,   105,    79,   105,    79,    77,    77,   nil,    77,
   nil,    77,    76,    76,   149,    76,   149,    76,    66,    66,
    80,    66,    80,    66,   nil,    62,    62,    79,    62,    79,
    62,    61,    61,    77,    61,    77,    61,    90,    90,    76,
    90,    76,    90,    36,    36,    66,   nil,    66,   120,   120,
   120,   120,    62,   nil,    62,    24,    24,    24,    61,   nil,
    61,    39,    39,   nil,    90,   nil,    90,   121,   121,   121,
   121,    55,    55,    55,    55,   122,   122,    20,    20,    52,
    52,   123,   123,    54,    54,    12,    12,     7,     7,     2,
     2,   124,   124,    71,    71,    56,    56,   125,   125,   119,
   119,     0,     0 ]

racc_action_pointer = [
   420,   201,   408,   nil,   nil,   nil,   nil,   413,   nil,   nil,
   197,   nil,   413,   nil,   nil,   181,    80,     4,   nil,   nil,
   403,   nil,    19,   165,   375,   nil,   nil,   158,   nil,   159,
   152,   292,   147,   116,   nil,   nil,   369,   141,   nil,   389,
   nil,   134,    97,   132,   129,   288,    40,    17,   nil,   nil,
   nil,   nil,   388,   113,   389,   375,   395,    14,   nil,   121,
   245,   357,   351,   nil,   113,   nil,   344,    59,   nil,   nil,
   nil,   412,   nil,   nil,   103,   nil,   338,   332,    89,   326,
   319,   101,    81,    59,   nil,   nil,   nil,   nil,   276,   251,
   363,   237,    34,   214,   183,   152,   226,   189,   206,   257,
   268,   282,   nil,   nil,   nil,   301,    -2,   nil,   nil,   nil,
   nil,   114,    45,    17,     8,   nil,   nil,   nil,   182,   405,
   352,   371,   375,   381,   391,   397,     8,    66,   nil,   nil,
     1,    78,   nil,   nil,   nil,   116,   220,   135,   195,   nil,
   nil,   175,   167,    97,   nil,   193,   nil,    78,   nil,   313,
   nil,   193,    -2,   nil ]

racc_action_default = [
    -2,   -82,    -1,    -3,    -5,    -6,    -7,   -82,   -26,   -27,
   -82,    -4,   -82,    -9,   -11,   -82,   -13,   -82,   154,    -8,
   -82,   -12,   -13,   -82,   -82,   -15,   -20,   -82,   -10,   -82,
   -13,   -82,   -82,   -82,   -17,   -21,   -82,   -82,   -28,   -82,
   -30,   -82,   -82,   -82,   -82,   -38,   -82,   -82,   -42,   -43,
   -45,   -47,   -49,   -51,   -53,   -55,   -58,   -63,   -66,   -69,
   -82,   -82,   -82,   -73,   -77,   -78,   -82,   -82,   -19,   -14,
   -16,   -82,   -23,   -24,   -82,   -29,   -82,   -82,   -82,   -82,
   -38,   -82,   -37,   -82,   -40,   -44,   -41,   -46,   -82,   -82,
   -82,   -82,   -82,   -82,   -82,   -82,   -82,   -82,   -82,   -82,
   -82,   -82,   -70,   -71,   -72,   -82,   -82,   -18,   -22,   -25,
   -48,   -82,   -82,   -82,   -82,   -36,   -39,   -50,   -52,   -54,
   -56,   -57,   -59,   -60,   -61,   -62,   -64,   -65,   -67,   -68,
   -82,   -82,   -76,   -80,   -79,   -82,   -82,   -82,   -38,   -74,
   -75,   -82,   -31,   -82,   -34,   -82,   -81,   -82,   -33,   -38,
   -32,   -82,   -82,   -35 ]

racc_goto_table = [
    78,   110,    47,    81,     7,    87,     7,    49,    82,   102,
   103,   104,    33,   117,    21,   122,   123,   124,   125,    67,
     3,    83,    11,   126,   127,     1,    85,    46,    21,   106,
   133,    37,   120,   121,    72,   108,   118,   119,   114,    26,
   111,    87,   113,    82,    17,    28,     2,   131,   128,   129,
    37,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   130,   nil,   146,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   142,   nil,   144,   145,   nil,   nil,   143,
   nil,    82,   nil,   nil,   nil,   150,   nil,   151,   nil,   nil,
   153,   nil,    82 ]

racc_goto_check = [
    16,    21,    20,    18,     7,    16,     7,     4,    17,    28,
    28,    28,    12,    21,    10,    26,    26,    26,    26,    12,
     3,    20,     3,    27,    27,     1,     4,    19,    10,    17,
    21,     7,    25,    25,    15,    14,    23,    24,    18,    13,
    17,    16,    17,    17,    11,     9,     2,    31,    28,    28,
     7,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    17,   nil,    21,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    16,   nil,    16,    18,   nil,   nil,    17,
   nil,    17,   nil,   nil,   nil,    16,   nil,    18,   nil,   nil,
    16,   nil,    17 ]

racc_goto_pointer = [
   nil,    25,    46,    20,   -20,   nil,   nil,     4,   nil,    25,
    -1,    37,   -12,    22,   -36,    -2,   -42,   -37,   -42,     0,
   -25,   -75,   nil,   -53,   -53,   -59,   -78,   -74,   -51,   nil,
   nil,   -58 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,     4,     5,     6,    36,    12,    13,
    14,   nil,   nil,    40,    35,   nil,    50,    39,   nil,   nil,
   nil,    51,    52,    53,    54,    55,    56,    57,    58,    59,
    63,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 35, :_reduce_none,
  0, 35, :_reduce_none,
  1, 36, :_reduce_3,
  2, 36, :_reduce_4,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  1, 37, :_reduce_none,
  3, 38, :_reduce_8,
  1, 42, :_reduce_9,
  3, 42, :_reduce_10,
  1, 43, :_reduce_11,
  2, 43, :_reduce_12,
  1, 44, :_reduce_13,
  4, 44, :_reduce_14,
  3, 39, :_reduce_15,
  4, 45, :_reduce_16,
  3, 45, :_reduce_17,
  5, 45, :_reduce_18,
  4, 45, :_reduce_19,
  3, 40, :_reduce_20,
  1, 46, :_reduce_21,
  3, 46, :_reduce_22,
  2, 48, :_reduce_23,
  1, 49, :_reduce_24,
  2, 49, :_reduce_25,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 50, :_reduce_none,
  2, 50, :_reduce_29,
  1, 50, :_reduce_30,
  5, 50, :_reduce_31,
  7, 50, :_reduce_32,
  6, 50, :_reduce_33,
  5, 50, :_reduce_34,
  9, 50, :_reduce_35,
  3, 50, :_reduce_36,
  1, 52, :_reduce_none,
  0, 52, :_reduce_none,
  4, 47, :_reduce_39,
  3, 47, :_reduce_40,
  3, 47, :_reduce_41,
  2, 47, :_reduce_none,
  1, 53, :_reduce_43,
  2, 53, :_reduce_44,
  1, 54, :_reduce_45,
  2, 54, :_reduce_46,
  1, 51, :_reduce_none,
  3, 51, :_reduce_48,
  1, 55, :_reduce_none,
  3, 55, :_reduce_50,
  1, 56, :_reduce_none,
  3, 56, :_reduce_52,
  1, 57, :_reduce_none,
  3, 57, :_reduce_54,
  1, 58, :_reduce_none,
  3, 58, :_reduce_56,
  3, 58, :_reduce_57,
  1, 59, :_reduce_none,
  3, 59, :_reduce_59,
  3, 59, :_reduce_60,
  3, 59, :_reduce_61,
  3, 59, :_reduce_62,
  1, 60, :_reduce_none,
  3, 60, :_reduce_64,
  3, 60, :_reduce_65,
  1, 61, :_reduce_none,
  3, 61, :_reduce_67,
  3, 61, :_reduce_68,
  1, 62, :_reduce_none,
  2, 62, :_reduce_70,
  2, 62, :_reduce_71,
  2, 62, :_reduce_72,
  1, 63, :_reduce_none,
  4, 63, :_reduce_74,
  4, 63, :_reduce_75,
  3, 63, :_reduce_76,
  1, 64, :_reduce_77,
  1, 64, :_reduce_78,
  3, 64, :_reduce_79,
  1, 65, :_reduce_80,
  3, 65, :_reduce_81 ]

racc_reduce_n = 82

racc_shift_n = 154

racc_token_table = {
  false => 0,
  :error => 1,
  :SEMI => 2,
  :COMMA => 3,
  "*" => 4,
  :IDENTIFIER => 5,
  :LBBRA => 6,
  :DIGIT => 7,
  :RBBRA => 8,
  :LPAR => 9,
  :RPAR => 10,
  :INT => 11,
  :VOID => 12,
  :IF => 13,
  :ELSE => 14,
  :DO => 15,
  :WHILE => 16,
  :FOR => 17,
  :RETURN => 18,
  :LBRA => 19,
  :RBRA => 20,
  "=" => 21,
  "||" => 22,
  "&&" => 23,
  "==" => 24,
  "!=" => 25,
  "<" => 26,
  ">" => 27,
  "<=" => 28,
  ">=" => 29,
  "+" => 30,
  "-" => 31,
  "/" => 32,
  "&" => 33 }

racc_nt_base = 34

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "SEMI",
  "COMMA",
  "\"*\"",
  "IDENTIFIER",
  "LBBRA",
  "DIGIT",
  "RBBRA",
  "LPAR",
  "RPAR",
  "INT",
  "VOID",
  "IF",
  "ELSE",
  "DO",
  "WHILE",
  "FOR",
  "RETURN",
  "LBRA",
  "RBRA",
  "\"=\"",
  "\"||\"",
  "\"&&\"",
  "\"==\"",
  "\"!=\"",
  "\"<\"",
  "\">\"",
  "\"<=\"",
  "\">=\"",
  "\"+\"",
  "\"-\"",
  "\"/\"",
  "\"&\"",
  "$start",
  "target",
  "program",
  "external_declaration",
  "declaration",
  "function_prototype",
  "function_definition",
  "type_specifier",
  "declarator_list",
  "declarator",
  "direct_declarator",
  "function_declarator",
  "parameter_type_list",
  "compound_statement",
  "parameter_declaration",
  "parameter_declarator",
  "statement",
  "expression",
  "expression_opt",
  "declaration_list",
  "statement_list",
  "assign_expr",
  "logical_OR_expr",
  "logical_AND_expr",
  "equality_expr",
  "relational_expr",
  "add_expr",
  "mult_expr",
  "unary_expr",
  "postfix_expr",
  "primary_expr",
  "argument_expression_list" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

module_eval(<<'.,.,', 'parser.rb', 19)
  def _reduce_3(val, _values, result)
    result = [val]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 20)
  def _reduce_4(val, _values, result)
     result << [val[1]] 
    result
  end
.,.,

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

module_eval(<<'.,.,', 'parser.rb', 32)
  def _reduce_8(val, _values, result)
     result = Declaration.new(val[0], val[1], @pos)
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 37)
  def _reduce_9(val, _values, result)
     result = val 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 38)
  def _reduce_10(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 43)
  def _reduce_11(val, _values, result)
     result = [:none, val].flatten 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 44)
  def _reduce_12(val, _values, result)
     result = '*', val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 49)
  def _reduce_13(val, _values, result)
     result = ID.new(val[0], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 50)
  def _reduce_14(val, _values, result)
     result = Ary.new(val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 55)
  def _reduce_15(val, _values, result)
     result = Func_proto.new(val[0], val[1][0], val[1][1], @pos ) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 60)
  def _reduce_16(val, _values, result)
     result = ID.new([:none, val[0]], @pos),  val[2], @pos 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 61)
  def _reduce_17(val, _values, result)
     result = ID.new([:none, val[0]], @pos), [], @pos 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 62)
  def _reduce_18(val, _values, result)
     result = ID.new(['*', val[1]], @pos), val[3], @pos  
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 63)
  def _reduce_19(val, _values, result)
     result = ID.new(['*', val[1]], @pos), [], @pos 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 68)
  def _reduce_20(val, _values, result)
     result =  Func_def.new(val[0], val[1][0], val[1][1], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 73)
  def _reduce_21(val, _values, result)
     result = val 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 74)
  def _reduce_22(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 79)
  def _reduce_23(val, _values, result)
     result = val.flatten  
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 84)
  def _reduce_24(val, _values, result)
     result = [ ID.new( [:none, val[0]], @pos) ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 85)
  def _reduce_25(val, _values, result)
     result = ID.new( ['*', val[1]],  @pos) 
    result
  end
.,.,

# reduce 26 omitted

# reduce 27 omitted

# reduce 28 omitted

module_eval(<<'.,.,', 'parser.rb', 97)
  def _reduce_29(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 98)
  def _reduce_30(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 99)
  def _reduce_31(val, _values, result)
     result = IF.new(val[2], val[4], nil, @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 100)
  def _reduce_32(val, _values, result)
     result = IF.new( val[2],  val[4], val[6], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 101)
  def _reduce_33(val, _values, result)
     result = val[1], While.new(val[4], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 102)
  def _reduce_34(val, _values, result)
     result = While.new(val[2], val[4], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 103)
  def _reduce_35(val, _values, result)
     result = val[2], While.new(val[4], [val[8], val[6]], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 104)
  def _reduce_36(val, _values, result)
     result = Return.new(val[1], @pos ) 
    result
  end
.,.,

# reduce 37 omitted

# reduce 38 omitted

module_eval(<<'.,.,', 'parser.rb', 115)
  def _reduce_39(val, _values, result)
     result = Compound.new(val[1], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 116)
  def _reduce_40(val, _values, result)
     result =  Compound.new(val[1], nil, @pos ) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 117)
  def _reduce_41(val, _values, result)
     result = Compound.new(nil, val[1], @pos ) 
    result
  end
.,.,

# reduce 42 omitted

module_eval(<<'.,.,', 'parser.rb', 123)
  def _reduce_43(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 124)
  def _reduce_44(val, _values, result)
     result = val[0] << val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 129)
  def _reduce_45(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 130)
  def _reduce_46(val, _values, result)
     result = val[0] << val[1] 
    result
  end
.,.,

# reduce 47 omitted

module_eval(<<'.,.,', 'parser.rb', 136)
  def _reduce_48(val, _values, result)
     result = val[0], val[2] 
    result
  end
.,.,

# reduce 49 omitted

module_eval(<<'.,.,', 'parser.rb', 142)
  def _reduce_50(val, _values, result)
     result = Assign.new('=', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 51 omitted

module_eval(<<'.,.,', 'parser.rb', 148)
  def _reduce_52(val, _values, result)
     result = Binary.new('||', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 53 omitted

module_eval(<<'.,.,', 'parser.rb', 154)
  def _reduce_54(val, _values, result)
     result = Binary.new('&&', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 55 omitted

module_eval(<<'.,.,', 'parser.rb', 160)
  def _reduce_56(val, _values, result)
     result = Binary.new('==', val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 161)
  def _reduce_57(val, _values, result)
     result = Binary.new('!=', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 58 omitted

module_eval(<<'.,.,', 'parser.rb', 166)
  def _reduce_59(val, _values, result)
     result = Binary.new('<', val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 167)
  def _reduce_60(val, _values, result)
     result = Binary.new('>', val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 168)
  def _reduce_61(val, _values, result)
     result = Binary.new('<=', val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 169)
  def _reduce_62(val, _values, result)
     result = Binary.new('>=', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 63 omitted

module_eval(<<'.,.,', 'parser.rb', 175)
  def _reduce_64(val, _values, result)
     result = Binary.new('+', val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 176)
  def _reduce_65(val, _values, result)
     result = Binary.new('-', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 66 omitted

module_eval(<<'.,.,', 'parser.rb', 182)
  def _reduce_67(val, _values, result)
     result = Binary.new('*', val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 183)
  def _reduce_68(val, _values, result)
     result = Binary.new('/', val[0], val[2], @pos) 
    result
  end
.,.,

# reduce 69 omitted

module_eval(<<'.,.,', 'parser.rb', 189)
  def _reduce_70(val, _values, result)
     result = Binary.new('-', DIGIT.new("0", @pos), val[1], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 190)
  def _reduce_71(val, _values, result)
     result = (val[1].class == Unary && val[1].op == '*') ? val[1].val : Unary.new('&', val[1], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 191)
  def _reduce_72(val, _values, result)
     result = Unary.new('*', val[1], @pos) 
    result
  end
.,.,

# reduce 73 omitted

module_eval(<<'.,.,', 'parser.rb', 197)
  def _reduce_74(val, _values, result)
     result = Unary.new('*', Binary.new('+', val[0], val[2], @pos), @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 198)
  def _reduce_75(val, _values, result)
     result = Func_call.new(val[0], val[2], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 199)
  def _reduce_76(val, _values, result)
     result = Func_call.new(val[0], :void, @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 204)
  def _reduce_77(val, _values, result)
     result = Refer.new(val[0], :val, @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 205)
  def _reduce_78(val, _values, result)
     result = DIGIT.new(val[0], @pos) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 206)
  def _reduce_79(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 211)
  def _reduce_80(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.rb', 212)
  def _reduce_81(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

end   # class MyParser

     
     if __FILE__ == $0
       parser = MyParser.new
       tree = parser.parse.flatten!
       $sem = []
       $sem[0] = {}
       $sem[0][:print] = Env.new(:print, 0, :proto, [["void", :none], [["int", :none]]])
       $mid = []
       $vars = []
       tree.each do |block|
         analize(block, 0)
         $sem.each_with_index do |h, i|
           next if i == 0
           h.clear
         end
         ir(block)
       end
       
       $code = ["    .data",
                "line_break: .asciiz \"\\n\"",
                "L0:",
                "    .text",
                "    .globl main"
               ]
       $mid.each do |block|
         $p_offset = 4
         $v_offset = 4
         $max_offset = 0
         $min_offset = 0
         addr(block)
         #        puts "max_offset : #{$max_offset}"
         #        puts "min_offset : #{$min_offset}"
         gen(block)
       end

        puts $code
       
       File.open("#{ARGV[0]}".chop!, 'w') do |f|
         $code.each do |c|
           next if c == nil
           f.puts(c)
         end
       end
     end
