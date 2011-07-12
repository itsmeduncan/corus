# Corus

Use this gem to define what is not nullable related to an ActiveRecord backed class

### Install

    config.gem 'corus'

### Usage

```ruby
    class Foo < ActiveRecord::Base
        tartarus :bar
    end

    thing = Foo.create(:bar => :baz)
    thing.bar = nil
    thing.valid? #=> false

    thing.save! #=> #<ActiveRecord::RecordInvalid: Validation failed: Bar can't be changed from 'baz' to nil>

    thing.save #=> false

    thing.bar = "widget"
    thing.valid? #=> true

    things.save #=> true
```

### License

See LICENSE for information.