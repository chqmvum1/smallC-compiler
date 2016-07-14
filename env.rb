# coding: utf-8
#
# Env:オブジェクト情報を格納
#

class Env
  attr_accessor :name, :lev, :kind, :type, :offset
  def initialize(name, lev, kind, type, offset = nil)
    @name = name
    @lev  = lev
    @kind = kind
    @type = type
    @offset = offset
  end
end
