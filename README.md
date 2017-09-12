# SimpleEnum::Scopes

SimpleEnum::Scopes is extension of SimpleEnum, which brings scopes to ActiveRecord enum attributes.

It'll avoid to write a bunch of scopes doing basically the same job.

## Usage

```ruby
class User
    as_enum :states, [:very_bad, :bad, :good, :very_good]
end


User.status_as(:bad, :very_good)
# User.where(status_cd: [User.bad, User.very_good])


User.status_between(:bad, :very_good)
# User.where(status_cd: User.bad..User.very_good)
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
