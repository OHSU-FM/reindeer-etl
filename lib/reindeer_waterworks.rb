
module ReindeerWaterworks
  # Your code goes here...
  autoload :Version, 'reindeer_waterworks/version'

  module Sources
    autoload :CSVSource, 'reindeer_waterworks/sources/csv_source'
  end

  module Transforms
    autoload :Renamer, 'reindeer_waterworks/transforms/renamer'
  end
end


