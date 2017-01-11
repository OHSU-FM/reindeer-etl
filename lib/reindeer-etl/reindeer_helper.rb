module ReindeerHelper

  def h_underscore_string string
    string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

  def h_regex
    /.*<([^>]*)/
  end

  def h_hash_maker sidx, target, result
    {" attribute_#{sidx + 1} <#{h_underscore_string target}>" => result}
  end
end
