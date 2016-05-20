def lookup(key, lev)
  lev.downto(0) do |l|
    if $sem[l][key]
      return $sem[l][key]
      break
    end
  end
end
