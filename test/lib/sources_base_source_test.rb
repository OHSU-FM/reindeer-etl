require 'minitest_helper'

describe ReindeerETL::Sources::BaseSource do
    it 'must remove columns when asked' do
        transform = ReindeerETL::Sources::BaseSource.new '', :only=>[:aa, :bb]
        row = {aa: 1, bb: 2, cc: 3}
        transform.base_transform row
        row.keys.must_equal [:aa, :bb]
    end

    it 'must raise error if required fields missing' do
        transform = ReindeerETL::Sources::BaseSource.new '', :require=>[:aa]
        row = {cc: 3}
        assert_raises(ReindeerETL::Errors::RecordInvalid){transform.base_transform row}
    end

end
