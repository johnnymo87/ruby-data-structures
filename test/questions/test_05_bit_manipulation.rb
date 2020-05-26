require 'minitest/autorun'

describe <<-Q do
You are given two 32-bit numbers, N and M, and two bit positions, i and j.
Write a method to insert M into N such that M starts at bit j and ends at bit
i. You can assume that the bits j and i have enough space to fit all of M. That
is, if M = 10011, you can assume that there are at least 5 bits between j and
i. You would not, for example have j = 3 and i = 2, because M could not fully
fit between bit 3 and bit 2.

EXAMPLE

Input: N = 10000000000, M = 10011, i = 2, j = 6
Output: N = 10001001100
Q
  # To clear all bits from the most significant bit through i (inclusive), we
  # create a mask with a 1 at the ith bit (1 << i). Then, we subtract 1 from it,
  # giving us a sequence of 0s followed by i 1s. We then AND our number with
  # this mask to leave just the last i bits.
  def clearBitsMSBthroughI(num, i)
    mask = (1 << i) - 1
    mask & num
  end

  # To clear all bits from i through 0 (inclusive), we take a sequence of all 1s
  # (which is -1) and shift it left by i bits. This gives us a sequences of
  # 1s (in the most significant bits) followed by i 0 bits.
  def clearBitsIthrough0(num, i)
    mask = -1 << i
    mask & num
  end

  def insert_bits(background:, foreground:, left_boundary:, right_boundary:)
    ones_with_right_margin_zeroed = clearBitsIthrough0(
      background,
      right_boundary
    )
    ones_with_both_margins_zeroed = clearBitsMSBthroughI(
      ones_with_right_margin_zeroed,
      left_boundary + 1
    )
    zeroes_with_both_margins_oned = ~ones_with_both_margins_zeroed
    background_with_middle_zeroed = zeroes_with_both_margins_oned & background
    background_with_middle_zeroed | (foreground << right_boundary)
  end

  it 'works when the background is blank' do
    insert_bits(
      background: 0b100_0000_0000,
      foreground: 0b1_0011,
      left_boundary: 6,
      right_boundary: 2
    ).to_s(2).must_equal(
      0b100_0100_1100.to_s(2)
    )
  end

  it 'works when the background is not blank' do
    insert_bits(
      background: 0b111_1111_1111,
      foreground: 0b1_0011,
      left_boundary: 6,
      right_boundary: 2
    ).to_s(2).must_equal(
      0b111_1100_1111.to_s(2)
    )
  end
end
