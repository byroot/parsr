# Parsr

Parsr aim to provide a way to safely evaluate a ruby expression composed only with literals,
just as Python's [ast.literal_eval](http://docs.python.org/library/ast.html#ast.literal_eval).

## Example

```ruby
Parsr.literal_eval(%q{ [1, "2", 3.4 => 5..6, foo: [7, bar: /(bb|[^b]{2})/ix] ] })
```

[![Build Status](https://secure.travis-ci.org/byroot/parsr.png)](http://travis-ci.org/byroot/parsr)
