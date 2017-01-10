require 'set'
require_relative '../reindeer_helper'

module ReindeerETL::Sources
  class MultiSource

    include ReindeerHelper # helper methods have h_ prefix

    # @param key [String] col name (present in all sources) to join on
    # @param paths [Array[String]] list of file paths. note: order is important
    # @param klass [String] namespaced class name of ReindeerETL source
    # @param path_opts [Array[Hash]] list of hashes (count equal to the
    #   number of sources) containing opts for each source. opt format is
    #   determined by the expectations of the source class. order is the
    #   same as the @paths list
    # @param expect_full_match [Boolean] true if every row in first
    #   source is expected to be matched in every other source
    # @param target_cols [Array[Array[String]]] Optional list of lists of
    #   column string names to be appended to initial source. order of
    #   outer list designates which source the internal cols come from.
    #   all cols are always added from first source, so
    #   target_cols.count == paths.count - 1
    # @param namespace [String] module where methods to get target_cols reside
    def initialize key, paths, opts={}
      @key = key
      @klass = opts[:klass].nil? ? ReindeerETL::Sources::CSVSource : Object.const_get(opts[:klass])
      @path_opts = opts[:path_opts] || Array.new(paths.length, {})
      @expect_full_match = opts[:expect_full_match] || false
      @target_cols = opts[:target_cols]
      @namespace = opts[:namespace]
      @sources = paths.zip(@path_opts).map{|path, opts|
        @klass.new path, opts
      }
    end

    def each
      rows = []
      all_keys = Set.new
      @sources.each_with_index do |source, source_idx|
        first_row = false
        source.each do |row|
          unless row.keys.include? @key
            raise ReindeerETL::Errors::RecordInvalid.new("Path#1 missing key: #{@key}")
          end

          if source_idx == 0 # first source
            rows << row
          else
            source_targets = @target_cols[source_idx - 1]
            rindex = rows.index{|r| r[@key] == row[@key] }

            if rindex.nil?
              if @expect_full_match
                raise ReindeerETL::Errors::RecordInvalid.new("Expected full match")
              else
                next
              end
            end

            if source_targets.empty?
              rows[rindex] = rows[rindex].merge(row)
            else
              source_targets.each do |tar|
                underscored_tar = h_underscore_string tar
                if row.keys.map {|k| k[/.*<([^>]*)/, 1] }.include? underscored_tar
                  k = row.keys.select{|k| k[/.*<([^>]*)/, 1] == tar }.first
                  rows[rindex] = rows[rindex].merge(row.select{|key, v| key == k })
                else
                  t=Object.const_get("ReindeerETL::Mods::#{@namespace}::#{tar}").new()
                  binding.pry
                  # TODO find it some other way!!!!!!!!!!!!!!!!!!
                end
              end
            end
          end
        end
      end
      rows.each {|r| yield r}
    end
  end
end
