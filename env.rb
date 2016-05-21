#
# Env:オブジェクト情報を格納
#

class Env
  attr_accessor :name, :kind, :type
  def initialize(name, kind, type)
    @name = name
    @kind = kind
    @type = type
  end
end
