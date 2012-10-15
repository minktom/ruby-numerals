class EnglishPhrase

  attr_reader :value

  def initialize(value)
    unless value.is_a?(Integer)
      raise ArgumentError.new("Only integers are allowed")
    end
    @value = value
  end

  def to_s
    textualize
  end

  private

  def textualize
    return unless value

    ary = []
    ary << 'minus' if value < 0

    if (1100..1999).include?(value.abs)
      ary += textualize_hundreds value.abs
    else
      ary += textualize_thousands value.abs 
    end

    insert_and_before_last_number(ary).join(' ')
  end

  def textualize_thousands num, exp=0
    return unless num
    carry, remain = num.divmod 1000
    ary = []
    ary += textualize_thousands(carry, exp+3) if carry > 0
    ary += textualize_hundreds(remain) if remain > 0 || (exp == 0 && num == 0)
    ary << Scale.new(exp) if exp > 0 && remain > 0
    ary
  end

  def textualize_hundreds num
    return unless num
    hundreds, remain = num.divmod 100
    ary = []
    if hundreds > 0
      ary << Number.new(hundreds)
      ary << Scale.new(2)
    end
    if remain > 0 || num == 0
      ary << Number.new(remain)
    end
    ary
  end

  def insert_and_before_last_number ary
    return ary if numbers_count_in_array(ary) < 2
    poped = []
    while !poped.last.is_a?(Number) do
      poped << ary.pop
    end
    ary << 'and'
    ary += poped.reverse
    ary
  end

  def numbers_count_in_array ary
    ary.select{|e| e.is_a?(Number) }.size
  end

end

# Number
class EnglishPhrase::Number < String
  NUMBERS = {
    0 => 'zero',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety',
  }

  def initialize num
    raise ArgumentError.new("Only integers are allowed") unless num.is_a? Integer
    raise ArgumentError.new("Only numbers between 0..99 are allowed") unless (0..99).include? num
    super textualize(num)
  end

  def zero?
    self == NUMBERS[0]
  end

  private

  def textualize num
    if NUMBERS.keys.include?(num)
      NUMBERS[num]
    else
      tens, ones = num.divmod 10
      "#{NUMBERS[tens*10]}-#{NUMBERS[ones]}"
    end
  end

end

# Scale
class EnglishPhrase::Scale < String
  SCALES = {
    2 => 'hundred',
    3 => 'thousand',
    6 => 'million',
    9 => 'billion',
    12 => 'trillion',
    15 => 'quadrillion',
    18 => 'quintillion',
    21 => 'sexillion'
    # ...
  }
  def initialize scale
    unless SCALES.keys.include? scale
      raise ArgumentError.new("Unknown scale factor")
    end
    super SCALES[scale]
  end
end
