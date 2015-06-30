require 'minitest_helper'

describe ReindeerETL::Transforms::Recode do

    it 'must recode values' do
        row = {g: :a}
        transform = ReindeerETL::Transforms::Recode.new :codes=>{:a=>:b}, :cols=>[:g]
        transform.process row
        row[:g].must_equal :b
    end
    
    it 'must raise an error if the column does not exist' do
        row = {hhh: :a}
        transform = ReindeerETL::Transforms::Recode.new codes: {a: :b}, cols: [:g] 
        
        assert_raises(ReindeerETL::Errors::RecordInvalid){ 
            transform.process row
        }
    end
    
    it 'must raise an error if parameters are missing' do
        assert_raises(ArgumentError){ 
            ReindeerETL::Transforms::Recode.new codes: {}
        }
        assert_raises(ArgumentError){ 
            ReindeerETL::Transforms::Recode.new cols: {}
        }
        ReindeerETL::Transforms::Recode.new codes: {a: :b}, cols: [:hhh]
    end


end


