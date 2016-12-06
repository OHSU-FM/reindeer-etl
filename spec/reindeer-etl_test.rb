require 'minitest_helper'

class TestReindeerETL < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ReindeerETL::VERSION
  end

end
