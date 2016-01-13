# fluent-plugin-split-array

Fluent filter plugin to split array

[![Build Status](https://travis-ci.org/SNakano/fluent-plugin-split-array.svg)](https://travis-ci.org/SNakano/fluent-plugin-split-array)
[![Gem](https://img.shields.io/gem/dt/fluent-plugin-split-array.svg)](https://rubygems.org/gems/fluent-plugin-split-array)


## install

```
gem install fluent-plugin-split-array
```

## Configuration Example

```
<filter foo.bar.*>
  type split_array
</filter>
```

## Example 1

### input

```
[{'a' => 'b'}, {'a' => 'c'}]
```

### output

```
{'a' => 'b'}
{'a' => 'c'}
```

## Example 2

### fluent.conf

Monitoring RabbitMQ all queues status
```
<source>
  type exec
  command curl -s -u guest:gutest http://127.0.0.1:15672/api/queues
  format json
  tag rabbitmq
  run_interval 10s
</source>

<filter rabbitmq>
  type split_array
</filter>

<match rabbitmq>
  type stdout
</match>
```
