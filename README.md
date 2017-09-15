# SimpleEnum::Scopes

SimpleEnum::Scopes is extension of SimpleEnum, which brings scopes to ActiveRecord enum attributes.

It'll avoid to write a bunch of scopes doing basically the same job.

## Usage

```ruby
class Object
    as_enum :state, [:very_bad, :bad, :good, :very_good]
end


Object.states_as(:bad, :very_good)
# Object.where(state_cd: [Object.states[:bad], Object.states[:very_good]])


Object.state_between(:bad, :very_good)
# Object.where(state_cd: Object.states[:bad]..Object.states[:very_good])
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
