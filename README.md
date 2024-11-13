# 🧮 frac

[![Package Version](https://img.shields.io/hexpm/v/frac)](https://hex.pm/packages/frac)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/frac/)

Work with fractions in Gleam!

```gleam
import frac

pub fn main() {
  let result =
    frac.new(1, 2)
    |> frac.add(frac.new(1, 3))

  let assert True = result == frac.new(5, 6)
}
```

To add this package to your project you can:

```sh
gleam add frac@1
```
