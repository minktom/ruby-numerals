require File.expand_path(File.dirname(__FILE__) + '../../../app/models/english_phrase')

def test_with_cases cases={}
  cases.each do |key, value|
    it "should give '#{value}' if initialize with #{key}" do
      EnglishPhrase.new(key).to_s.should == value
    end
  end
end

describe EnglishPhrase do

  context 'initialize' do
    it 'shoud set the value' do
      EnglishPhrase.new(42).value.should == 42
    end

    it 'should raise ArgumentError for arguments that are not integer' do
      expect{ EnglishPhrase.new('a') }.to raise_error(ArgumentError)
    end
  end

  context '0..9 number conversion' do
    test_cases = {
      0 => 'zero',
      1 => 'one',
      6 => 'six',
      8 => 'eight'
    }
    test_with_cases test_cases
  end

  context '10..20 number conversion' do
    test_cases = {
      10 => 'ten',
      11 => 'eleven',
      15 => 'fifteen',
      19 => 'nineteen'
    }
    test_with_cases test_cases
  end

  context '21..99 number conversion' do
    test_cases = {
      21 => 'twenty-one',
      40 => 'forty',
      63 => 'sixty-three',
      88 => 'eighty-eight'
    }
    test_with_cases test_cases
  end

  context '100..999 number conversion' do
    test_cases = {
      100 => 'one hundred',
      134 => 'one hundred and thirty-four',
      583 => 'five hundred and eighty-three',
      912 => 'nine hundred and twelve'
    }
    test_with_cases test_cases
  end

  context '1100..1999 number conversion' do
    test_cases = {
      1100 => 'eleven hundred',
      1456 => 'fourteen hundred and fifty-six',
      1860 => 'eighteen hundred and sixty',
    }
    test_with_cases test_cases
  end

  context 'large number conversion' do
    test_cases = {
      5_400 => 'five thousand and four hundred',
      22_000 => 'twenty-two thousand',
      15_435_273 => 'fifteen million four hundred thirty-five thousand twohundred and seventy-three',
      40_000_000 => 'forty million'
    }
    test_with_cases test_cases
  end


  context 'excercise example number conversion' do
    test_cases = {
      7    => 'seven',
      42   => 'forty-two',
      2001 => 'two thousand and one',
      1999 => 'nineteen hundred and ninety-nine'
    }
    test_with_cases test_cases
  end

end