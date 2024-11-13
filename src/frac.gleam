//// This module has many functions to deal with
//// [simple fractions](https://en.wikipedia.org/wiki/Fraction#Simple,_common,_or_vulgar_fractions):
//// fractions with an integer numerator and denominator.
////
//// | If you need to...             | You can use...                                                               |
//// |-------------------------------|------------------------------------------------------------------------------|
//// | create a fraction             | [new](#new), [from_int](#from_int), [approximate](#approximate)              |
//// | get the numerator/denominator | [numerator](#numerator), [denominator](#denominator)                         |
//// | simplify a fraction           | [to_mixed_numbers](#to_mixed_numbers)                                        |
//// | combine fractions together    | [add](#add), [subtract](#subtract), [multiply](#multiply), [divide](#divide) |
//// | turn a fraction into a float  | [to_float](#to_float)                                                        |
//// | compare fractions             | [compare](#compare)                                                          |
////

import gleam/float
import gleam/int
import gleam/order.{type Order, Eq, Gt, Lt}

/// A [simple fraction](https://en.wikipedia.org/wiki/Fraction#Simple,_common,_or_vulgar_fractions)
/// with an integer numerator and denominator.
///
pub opaque type Fraction {
  Fraction(numerator: Int, denominator: Int)
}

// --- CONVERSIONS -------------------------------------------------------------

/// Returns the floating point number you get by dividing the numerator of a
/// fraction by its denominator.
///
/// > Note that if the denominator is `0` you'll get `0` as the result.
///
/// ## Examples
///
/// ```gleam
/// assert to_float(new(3, 2)) == 1.5
/// assert to_float(new(2, 0)) == 0.0
/// ```
///
pub fn to_float(fraction: Fraction) -> Float {
  let Fraction(numerator:, denominator:) = fraction
  int.to_float(numerator) /. int.to_float(denominator)
}

/// Creates a new fraction with the given nominator and denominator 1.
///
/// ## Examples
///
/// ```gleam
/// assert numerator(from_int(10)) == 10
/// assert denominator(from_int(10)) == 1
/// ```
///
pub fn from_int(numerator: Int) -> Fraction {
  Fraction(numerator:, denominator: 1)
}

/// Creates a new fraction with the given numerator and denominator.
///
/// > Note that this function ensures that only the numerator can be negative,
/// > so `new(1, -2)` will be the same as `new(-1, 2)`.
///
/// ## Examples
///
/// ```gleam
/// assert numerator(new(1, 2)) == 1
/// assert denominator(new(1, 2)) == 2
/// ```
///
pub fn new(numerator numerator: Int, denominator denominator: Int) -> Fraction {
  case denominator >= 0 {
    True -> to_lowest_terms(numerator, denominator)
    False -> to_lowest_terms(-numerator, -denominator)
  }
}

fn to_lowest_terms(numerator: Int, denominator: Int) -> Fraction {
  let gcd = gcd(numerator, denominator)
  let numerator = numerator / gcd
  let denominator = denominator / gcd
  Fraction(numerator:, denominator:)
}

/// Approximates a float into a simple fraction whose denominator is at most
/// `max_denominator`.
///
/// > ⚠️ This might result in a fraction that does not exactly yield the
/// > float number passed in as input. Precision only goes as far as 5 decimal
/// > digits.
///
/// ## Examples
///
/// ```gleam
/// assert approximate(0.333, 10) == new(1, 3)
/// assert approximate(0.2, 10) == new(1, 5)
/// ```
///
pub fn approximate(from float: Float, max_denominator limit: Int) -> Fraction {
  // https://kevinboone.me/rationalize.html
  let scale = 100_000
  let x = float.round(float *. int.to_float(scale))
  let a = x / scale

  let x = { scale * scale } / { x - a * scale }
  let b = x / scale

  factors(x, b, a * b + 1, b, a, 1, limit, scale)
}

fn factors(x, prev, n1, d1, n2, d2, max_d, scale) {
  let x = scale * scale / { x - prev * scale }
  let a = x / scale

  case a {
    0 -> new(n1, d1)
    _ -> {
      let n = n2 + a * n1
      let d = d2 + a * d1
      case d > max_d {
        True -> new(n1, d1)
        False -> factors(x, a, n, d, n1, d1, max_d, scale)
      }
    }
  }
}

// --- ACCESSING NUMERATOR/DENOMINATOR -----------------------------------------

/// Returns the numerator of a fraction.
///
pub fn numerator(fraction: Fraction) -> Int {
  fraction.numerator
}

/// Returns the denominator of a fraction.
///
pub fn denominator(fraction: Fraction) -> Int {
  fraction.denominator
}

// --- SIMPLIFYING FRACTIONS ---------------------------------------------------

/// Turns the fraction into a
/// [mixed number](https://en.wikipedia.org/wiki/Fraction#Mixed_numbers): that
/// is an integer and a
/// [proper fraction](https://en.wikipedia.org/wiki/Fraction#Proper_and_improper_fractions)
/// that added together produce the original fraction.
///
/// ## Examples
///
/// ```gleam
/// assert to_mixed_numbers(new(11, 4)) == #(2, new(3, 4))
/// // 2 + 3/4 is equal to 11/4
/// ```
///
pub fn to_mixed_numbers(fraction: Fraction) -> #(Int, Fraction) {
  let Fraction(numerator:, denominator:) = fraction
  #(
    numerator / denominator,
    new(numerator: numerator % denominator, denominator:),
  )
}

// --- FRACTION ARITHMETIC -----------------------------------------------------

/// Divides one fraction by another.
///
/// ## Examples
///
/// ```gleam
/// assert divide(new(2, 4), new(1, 3)) == new(3, 2)
/// ```
///
pub fn divide(one: Fraction, by other: Fraction) -> Fraction {
  new(
    numerator: one.numerator * other.denominator,
    denominator: one.denominator * other.numerator,
  )
}

/// Multiplies one fraction by another.
///
/// ## Examples
///
/// ```gleam
/// assert multiply(new(1, 2), by: new(4, 5)) == new(2, 5)
/// ```
///
pub fn multiply(one: Fraction, by other: Fraction) -> Fraction {
  new(
    numerator: one.numerator * other.numerator,
    denominator: one.denominator * other.denominator,
  )
}

/// Adds two fractions together.
///
/// ## Examples
///
/// ```gleam
/// assert sum(new(2, 4), new(3, 4)) == new(5, 4)
/// ```
///
pub fn add(one: Fraction, other: Fraction) -> Fraction {
  let Fraction(numerator: one_num, denominator: one_den) = one
  let Fraction(numerator: other_num, denominator: other_den) = other
  let gcd = gcd(one_num, other_num)

  new(
    numerator: { { one_den * other_num } / gcd }
      + { { other_den * one_num } / gcd },
    denominator: { one_den * other_den } / gcd,
  )
}

/// Subtracts one fraction from another.
///
/// ## Examples
///
/// ```gleam
/// assert subtract(new(2, 4), new(3, 4)) == new(-1, 4)
/// ```
///
pub fn subtract(one: Fraction, other: Fraction) -> Fraction {
  let Fraction(numerator: one_num, denominator: one_den) = one
  let Fraction(numerator: other_num, denominator: other_den) = other
  let gcd = gcd(one_num, other_num)
  new(
    numerator: { { other_den * one_num } / gcd }
      - { { one_den * other_num } / gcd },
    denominator: one_den * other_den / gcd,
  )
}

// --- COMPARISONS -------------------------------------------------------------

/// Compares two fractions.
///
/// ## Examples
///
/// ```gleam
/// assert compare(new(1, 2), new(3, 2)) == Lt
/// assert compare(new(1, 2), new(1, 2)) == Eq
/// assert compare(new(1, 2), new(1, 3)) == Gt
/// ```
///
pub fn compare(one: Fraction, with other: Fraction) -> Order {
  case one, other {
    _, _ if one == other -> Eq

    Fraction(numerator: one_num, ..), Fraction(numerator: other_num, ..)
      if one_num >= 0 && other_num < 0
    -> Gt

    Fraction(numerator: one_num, ..), Fraction(numerator: other_num, ..)
      if other_num >= 0 && one_num < 0
    -> Lt

    Fraction(numerator: one_num, denominator: one_den),
      Fraction(numerator: other_num, denominator: other_den)
    -> {
      let gcd = gcd(one_num, other_num)
      let one_num = { other_den * one_num } / gcd
      let other_num = { one_den * other_num } / gcd
      int.compare(one_num, other_num)
    }
  }
}

// --- UTILS -------------------------------------------------------------------

/// Returns the greatest common divisor between two numbers.
///
/// > If any of the two numbers is zero, the result is the other number.
///
fn gcd(a: Int, b: Int) -> Int {
  case a, b {
    gcd, 0 -> int.absolute_value(gcd)
    a, b -> gcd(b, a % b)
  }
}
