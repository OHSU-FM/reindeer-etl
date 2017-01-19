module ReindeerHelper

  LOT_ID_YEAR = {
    "A02" => "4yr",
    "A03" => "4yr",
    "A04" => "4yr",
    "A05" => "4yr",
    "A06" => "mixed",
    "A07" => "4yr",
    "A08" => "mixed",
    "A09" => "mixed",
    "A10" => "mixed",
    "A11" => "4yr",
    "C01" => "3yr",
    "C02" => "3yr",
    "C03" => "3yr",
    "C04" => "3yr",
    "C05" => "3yr",
    "C07" => "3yr"
  }

  LOT_ID_ALIAS = {
    "A02" => "6",
    "A03" => "7",
    "A04" => "1",
    "A05" => "10",
    "A06" => "5",
    "A07" => "11",
    "A08" => "2",
    "A09" => "12",
    "A10" => "13",
    "A11" => "14",
    "C01" => "8",
    "C02" => "9",
    "C03" => "15",
    "C04" => "16",
    "C05" => "17",
    "C07" => "3"
  }

  LOT_NAVY_PROGRAMS = ["A06", "A08", "A09", "A10"]

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

  def h_hash_maker target, result
    {target => result}
  end
end
