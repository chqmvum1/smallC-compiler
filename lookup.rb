# coding: utf-8
#
# 環境検索メソッドlookup
#

def lookup(key, lev)
  lev.downto(0) do |l|
    if $sem[l][key]
      return $sem[l][key]
      break
    end
  end
end
