require 'minitest_helper'

describe ReindeerETL::Transforms::RenameFields do
    before do
        cols = {:aaa=>:bbb, :ccc=>:ddd}
        @transform = ReindeerETL::Transforms::RenameFields.new cols
    end

    it 'must raise an error when the column is not in the row' do
        row = {}
        assert_raises(ReindeerETL::Errors::RecordInvalid){ @transform.process row }
    end
    
    it 'must rename fields' do
        row = {:aaa=>555, :ccc=>888}
        row = @transform.process row
        row.keys.include?(:aaa).must_equal false
        row.keys.include?(:bbb).must_equal true
    end

end

