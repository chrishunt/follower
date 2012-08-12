require 'followers/comparison'

describe Followers::Comparison do
  subject { Followers::Comparison }

  describe '.lost' do
    it 'returns list of lost followers' do
      subject.lost([1, 2, 3], [2]).should == [1, 3]
    end

    it 'works when there were no followers yesterday' do
      subject.lost([], [2, 3]).should == []
    end

    it 'works when no followers were lost' do
      subject.lost([1, 2, 3], [1, 2, 3]).should == []
    end

    it 'works when all followers were lost' do
      subject.lost([1, 2, 3], [4, 5, 6]).should == [1, 2, 3]
    end
  end

  describe '.gained' do
    it 'returns list of gained followers' do
      subject.gained([1, 2, 3], [1, 2, 3, 4]).should == [4]
    end

    it 'works when there were no followers yesterday' do
      subject.gained([], [2, 3]).should == [2, 3]
    end

    it 'works when no followers were gained' do
      subject.gained([1, 2, 3], [1, 2, 3]).should == []
    end

    it 'works when all followers were gained' do
      subject.gained([1, 2, 3], [4]).should == [4]
    end
  end
end
