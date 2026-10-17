import frac
import gleam/order
import gleeunit

pub fn main() {
  gleeunit.main()
}

pub fn new_positives_test() {
  assert frac.numerator(frac.new(3, 2)) == 3
  assert frac.denominator(frac.new(3, 2)) == 2
}

pub fn new_negatives_test() {
  assert frac.numerator(frac.new(-3, -2)) == 3
  assert frac.denominator(frac.new(-3, -2)) == 2
}

pub fn new_positive_numerator_negative_denominator_test() {
  assert frac.numerator(frac.new(3, -2)) == -3
  assert frac.denominator(frac.new(3, -2)) == 2
}

pub fn new_positive_denominator_negative_numerator_test() {
  assert frac.numerator(frac.new(-3, 2)) == -3
  assert frac.denominator(frac.new(-3, 2)) == 2
}

pub fn to_float_test() {
  assert frac.to_float(frac.new(3, 2)) == 1.5
}

pub fn to_float_0_numerator_test() {
  assert frac.to_float(frac.new(0, 2)) == 0.0
}

pub fn to_float_0_denominator_test() {
  assert frac.to_float(frac.new(2, 0)) == 0.0
}

pub fn approximate_exact_number_1_test() {
  assert frac.approximate(1.5, 10) == frac.new(3, 2)
}

pub fn approximate_exact_number_2_test() {
  assert frac.approximate(1.75, 10) == frac.new(7, 4)
}

pub fn approximate_real_number_1_test() {
  assert frac.approximate(3.1415926, 10) == frac.new(22, 7)
}

pub fn approximate_real_number_2_test() {
  assert frac.approximate(3.1415926, 150) == frac.new(355, 113)
}

pub fn approximate_real_number_3_test() {
  assert frac.approximate(0.124456432, 10) == frac.new(1, 8)
}

pub fn approximate_read_number_4_test() {
  assert frac.approximate(1.625, 10) == frac.new(13, 8)
}

pub fn approximate_whole_number_1_test() {
  assert frac.approximate(3.0, 1000) == frac.new(3, 1)
}

pub fn approximate_whole_number_2_test() {
  assert frac.approximate(4.0, 1000) == frac.new(4, 1)
}

pub fn to_lowest_terms_1_test() {
  assert frac.new(4, 2) == frac.new(2, 1)
}

pub fn to_lowest_terms_2_test() {
  assert frac.new(13, 8) == frac.new(13, 8)
}

pub fn to_lowest_terms_3_test() {
  assert frac.new(17, 34) == frac.new(1, 2)
}

pub fn to_lowest_terms_4_test() {
  assert frac.new(1, 11) == frac.new(1, 11)
}

pub fn to_lowest_terms_5_test() {
  assert frac.new(0, 11) == frac.new(0, 1)
}

pub fn to_lowest_terms_6_test() {
  assert frac.new(11, 0) == frac.new(1, 0)
}

pub fn to_lowest_terms_7_test() {
  assert frac.new(0, 0) == frac.new(0, 0)
}

pub fn to_mixed_numbers_1_test() {
  assert frac.to_mixed_numbers(frac.new(1, 2)) == #(0, frac.new(1, 2))
}

pub fn to_mixed_numbers_2_test() {
  assert frac.to_mixed_numbers(frac.new(1, 3)) == #(0, frac.new(1, 3))
}

pub fn to_mixed_numbers_3_test() {
  assert frac.to_mixed_numbers(frac.new(13, 8)) == #(1, frac.new(5, 8))
}

pub fn divide_does_not_reduce_to_lowest_terms_test() {
  assert frac.divide(frac.new(2, 4), frac.new(1, 3)) == frac.new(6, 4)
}

pub fn multiply_does_not_reduce_to_lowest_terms_test() {
  assert frac.multiply(frac.new(2, 4), frac.new(3, 2)) == frac.new(6, 8)
}

pub fn add_1_test() {
  assert frac.add(frac.new(2, 4), frac.new(3, 4)) == frac.new(5, 4)
}

pub fn add_2_test() {
  assert frac.add(frac.new(2, 4), frac.new(3, 7)) == frac.new(13, 14)
}

pub fn add_3_test() {
  assert frac.add(frac.new(2, 11), frac.new(3, 17)) == frac.new(67, 187)
}

pub fn add_4_test() {
  assert frac.add(frac.new(2, 4), frac.new(3, 8)) == frac.new(7, 8)
}

pub fn add_does_not_reduce_to_lowest_term_test() {
  assert frac.add(frac.new(1, 4), frac.new(5, 4)) == frac.new(24, 16)
}

pub fn subtract_1_test() {
  assert frac.subtract(frac.new(2, 4), frac.new(3, 4)) == frac.new(-1, 4)
}

pub fn subtract_2_test() {
  assert frac.subtract(frac.new(1, 4), frac.new(3, 7)) == frac.new(-5, 28)
}

pub fn subtract_3_test() {
  assert frac.subtract(frac.new(2, 11), frac.new(3, 17)) == frac.new(1, 187)
}

pub fn subtract_4_test() {
  assert frac.subtract(frac.new(2, 4), frac.new(3, 8)) == frac.new(1, 8)
}

pub fn subtract_5_test() {
  assert frac.subtract(frac.new(1, 4), frac.new(5, 4)) == frac.new(-1, 1)
}

pub fn subtract_does_not_reduce_to_lowest_term_test() {
  assert frac.subtract(frac.new(1, 4), frac.new(5, 4)) == frac.new(-16, 16)
}

pub fn compare_positives_test() {
  assert frac.compare(frac.new(1, 2), frac.new(3, 2)) == order.Lt
  assert frac.compare(frac.new(3, 2), frac.new(1, 2)) == order.Gt
  assert frac.compare(frac.new(1, 2), frac.new(1, 2)) == order.Eq
}

pub fn compare_positive_and_negative_test() {
  assert frac.compare(frac.new(1, 2), frac.new(-3, 2)) == order.Gt
  assert frac.compare(frac.new(0, 2), frac.new(-3, 2)) == order.Gt
  assert frac.compare(frac.new(-1, 2), frac.new(3, 2)) == order.Lt
  assert frac.compare(frac.new(-1, 2), frac.new(0, 2)) == order.Lt
}

pub fn compare_negative_and_negative_test() {
  assert frac.compare(frac.new(-1, 2), frac.new(-3, 2)) == order.Gt
  assert frac.compare(frac.new(-3, 2), frac.new(-1, 2)) == order.Lt
  assert frac.compare(frac.new(-1, 2), frac.new(-1, 2)) == order.Eq
}
