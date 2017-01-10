require 'set'
require_relative '../reindeer_helper'

module ReindeerETL::Sources
  class MultiSource

    include ReindeerHelper

    # @param key [String] col name (present in all sources) to join on
    # @param klass [String] namespaced class name of ReindeerETL source
    # @param path_opts [Array[Hash]] list of hashes (count equal to the
    #   number of sources) containing opts for each source. opt format is
    #   determined by the expectations of the source class. order is the
    #   same as the @klass list
    # @param expect_full_match [Boolean] true if every row in first
    #   source is expected to be matched in every other source
    # @param target_cols [Array[Array[String]]] Optional list of lists of
    #   column string names to be appended to initial source. order of
    #   outer list designates which source the internal cols come from.
    #   all cols are always added from first source, so
    #   target_cols.count == paths.count - 1
    def initialize key, paths, opts={}
      @key = key
      @klass = opts[:klass].nil? ? ReindeerETL::Sources::CSVSource : Object.const_get(opts[:klass])
      @path_opts = opts[:path_opts] || Array.new(paths.length, {})
      @expect_full_match = opts[:expect_full_match] || false
      @target_cols = opts[:target_cols]
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
            if source_targets.empty?
              begin
                rows[rindex] = rows[rindex].merge(row)
              rescue TypeError
                if @expect_full_match
                  raise ReindeerETL::Errors::RecordInvalid.new("Expected full match")
                else
                  next
                end
              end
            else
              source_targets.map {|t| underscore_string t }.each do |tar|
                if row.keys.map {|k| substring_bw(k, "<", ">") }.include? tar
                  k = row.keys.select{|k| substring_bw(k, "<",">") == tar }.first
                  rows[rindex] = rows[rindex].merge(row.select{|key, v| key == k })
                else
                  raise hell
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
