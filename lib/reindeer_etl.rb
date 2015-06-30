module ReindeerETL
  # Your code goes here...

  module Sources
  end

  module Transforms
  end

  module Destinations
  end

end

require 'reindeer_etl/version'
require 'reindeer_etl/errors'

require 'reindeer_etl/transforms/simple_transforms'
require 'reindeer_etl/transforms/recode'
require 'reindeer_etl/transforms/rename_fields'
require 'reindeer_etl/transforms/response_status'

require 'reindeer_etl/sources/base_source'
require 'reindeer_etl/sources/csv_source'
require 'reindeer_etl/sources/multi_source'

require 'reindeer_etl/destinations/csv_dest'
