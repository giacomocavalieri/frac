import frac
import gleam/order
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn new_positives_test() {
  frac.new(3, 2)
  |> frac.numerator
  |> should.equal(3)

  frac.new(3, 2)
  |> frac.denominator
  |> should.equal(2)
}

pub fn new_negatives_test() {
  frac.new(-3, -2)
  |> frac.numerator
  |> should.equal(3)

  frac.new(-3, -2)
  |> frac.denominator
  |> should.equal(2)
}

pub fn new_positive_numerator_negative_denominator_test() {
  frac.new(3, -2)
  |> frac.numerator
  |> should.equal(-3)

  frac.new(3, -2)
  |> frac.denominator
  |> should.equal(2)
}

pub fn new_positive_denominator_negative_numerator_test() {
  frac.new(-3, 2)
  |> frac.numerator
  |> should.equal(-3)

  frac.new(-3, 2)
  |> frac.denominator
  |> should.equal(2)
}

pub fn to_float_test() {
  frac.new(3, 2)
  |> frac.to_float
  |> should.equal(1.5)
}

pub fn to_float_0_numerator_test() {
  frac.new(0, 2)
  |> frac.to_float
  |> should.equal(0.0)
}

pub fn to_float_0_denominator_test() {
  frac.new(2, 0)
  |> frac.to_float
  |> should.equal(0.0)
}

pub fn approximate_exact_number_1_test() {
  frac.approximate(1.5, 10)
  |> should.equal(frac.new(3, 2))
}

pub fn approximate_exact_number_2_test() {
  frac.approximate(1.75, 10)
  |> should.equal(frac.new(7, 4))
}

pub fn approximate_real_number_1_test() {
  frac.approximate(3.1415926, 10)
  |> should.equal(frac.new(22, 7))
}

pub fn approximate_real_number_2_test() {
  frac.approximate(3.1415926, 150)
  |> should.equal(frac.new(355, 113))
}

pub fn approximate_real_number_3_test() {
  frac.approximate(0.124456432, 10)
  |> should.equal(frac.new(1, 8))
}

pub fn approximate_read_number_4_test() {
  frac.approximate(1.625, 10)
  |> should.equal(frac.new(13, 8))
}

pub fn approximate_whole_number_1_test() {
  frac.approximate(3.0, 1000)
  |> should.equal(frac.new(3, 1))
}

pub fn approximate_whole_number_2_test() {
  frac.approximate(4.0, 1000)
  |> should.equal(frac.new(4, 1))
}

pub fn to_lowest_terms_1_test() {
  frac.new(4, 2)
  |> should.equal(frac.new(2, 1))
}

pub fn to_lowest_terms_2_test() {
  frac.new(13, 8)
  |> should.equal(frac.new(13, 8))
}

pub fn to_lowest_terms_3_test() {
  frac.new(17, 34)
  |> should.equal(frac.new(1, 2))
}

pub fn to_lowest_terms_4_test() {
  frac.new(1, 11)
  |> should.equal(frac.new(1, 11))
}

pub fn to_lowest_terms_5_test() {
  frac.new(0, 11)
  |> should.equal(frac.new(0, 1))
}

pub fn to_lowest_terms_6_test() {
  frac.new(11, 0)
  |> should.equal(frac.new(1, 0))
}

pub fn to_lowest_terms_7_test() {
  frac.new(0, 0)
  |> should.equal(frac.new(0, 0))
}

pub fn to_mixed_numbers_1_test() {
  frac.new(1, 2)
  |> frac.to_mixed_numbers
  |> should.equal(#(0, frac.new(1, 2)))
}

pub fn to_mixed_numbers_2_test() {
  frac.new(1, 3)
  |> frac.to_mixed_numbers
  |> should.equal(#(0, frac.new(1, 3)))
}

pub fn to_mixed_numbers_3_test() {
  frac.new(13, 8)
  |> frac.to_mixed_numbers
  |> should.equal(#(1, frac.new(5, 8)))
}

pub fn divide_does_not_reduce_to_lowest_terms_test() {
  frac.new(2, 4)
  |> frac.divide(frac.new(1, 3))
  |> should.equal(frac.new(6, 4))
}

pub fn multiply_does_not_reduce_to_lowest_terms_test() {
  frac.new(2, 4)
  |> frac.multiply(frac.new(3, 2))
  |> should.equal(frac.new(6, 8))
}

pub fn add_1_test() {
  frac.new(2, 4)
  |> frac.add(frac.new(3, 4))
  |> should.equal(frac.new(5, 4))
}

pub fn add_2_test() {
  frac.new(2, 4)
  |> frac.add(frac.new(3, 7))
  |> should.equal(frac.new(13, 14))
}

pub fn add_3_test() {
  frac.new(2, 11)
  |> frac.add(frac.new(3, 17))
  |> should.equal(frac.new(67, 187))
}

pub fn add_4_test() {
  frac.new(2, 4)
  |> frac.add(frac.new(3, 8))
  |> should.equal(frac.new(7, 8))
}

pub fn add_does_not_reduce_to_lowest_term_test() {
  frac.new(1, 4)
  |> frac.add(frac.new(5, 4))
  |> should.equal(frac.new(24, 16))
}

pub fn subtract_1_test() {
  frac.new(2, 4)
  |> frac.subtract(frac.new(3, 4))
  |> should.equal(frac.new(-1, 4))
}

pub fn subtract_2_test() {
  frac.new(1, 4)
  |> frac.subtract(frac.new(3, 7))
  |> should.equal(frac.new(-5, 28))
}

pub fn subtract_3_test() {
  frac.new(2, 11)
  |> frac.subtract(frac.new(3, 17))
  |> should.equal(frac.new(1, 187))
}

pub fn subtract_4_test() {
  frac.new(2, 4)
  |> frac.subtract(frac.new(3, 8))
  |> should.equal(frac.new(1, 8))
}

pub fn subtract_5_test() {
  frac.new(1, 4)
  |> frac.subtract(frac.new(5, 4))
  |> should.equal(frac.new(-1, 1))
}

pub fn subtract_does_not_reduce_to_lowest_term_test() {
  frac.new(1, 4)
  |> frac.subtract(frac.new(5, 4))
  |> should.equal(frac.new(-16, 16))
}

pub fn compare_positives_test() {
  frac.compare(frac.new(1, 2), frac.new(3, 2))
  |> should.equal(order.Lt)

  frac.compare(frac.new(3, 2), frac.new(1, 2))
  |> should.equal(order.Gt)

  frac.compare(frac.new(1, 2), frac.new(1, 2))
  |> should.equal(order.Eq)
}

pub fn compare_positive_and_negative_test() {
  frac.compare(frac.new(1, 2), frac.new(-3, 2))
  |> should.equal(order.Gt)

  frac.compare(frac.new(0, 2), frac.new(-3, 2))
  |> should.equal(order.Gt)

  frac.compare(frac.new(-1, 2), frac.new(3, 2))
  |> should.equal(order.Lt)

  frac.compare(frac.new(-1, 2), frac.new(0, 2))
  |> should.equal(order.Lt)
}

pub fn compare_negative_and_negative_test() {
  frac.compare(frac.new(-1, 2), frac.new(-3, 2))
  |> should.equal(order.Gt)

  frac.compare(frac.new(-3, 2), frac.new(-1, 2))
  |> should.equal(order.Lt)

  frac.compare(frac.new(-1, 2), frac.new(-1, 2))
  |> should.equal(order.Eq)
}
