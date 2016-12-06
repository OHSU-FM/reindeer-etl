require "rest-client"
require "pp"
require "pry"

require_relative "reindeer-etl/version"
require_relative "reindeer-etl/errors"

require_relative "reindeer-etl/mildred/mildred"

require_relative "reindeer-etl/transforms/simple_transforms"
require_relative "reindeer-etl/transforms/recode"
require_relative "reindeer-etl/transforms/rename_fields"
require_relative "reindeer-etl/transforms/response_status"

require_relative "reindeer-etl/sources/base_source"
require_relative "reindeer-etl/sources/csv_source"
require_relative "reindeer-etl/sources/multi_source"

require_relative "reindeer-etl/destinations/csv_dest"
