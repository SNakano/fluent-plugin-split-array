# fluent-plugin-split-array

Fluent filter plugin to split array

[![Build Status](https://travis-ci.org/SNakano/fluent-plugin-split-array.svg)](https://travis-ci.org/SNakano/fluent-plugin-split-array)
[![Gem](https://img.shields.io/gem/dt/fluent-plugin-split-array.svg)](https://rubygems.org/gems/fluent-plugin-split-array)


## install

```
gem install fluent-plugin-split-array
```

### Requirements

| fluent-plugin-script | fluentd    |
|----------------------|------------|
| >= 0.1.0             | >= v0.14.0 |
| <  0.0.2             | <  v0.14.0 |

## Configuration Example

## Example 1

```
<filter foo.bar.*>
  type split_array
</filter>
```

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

```
<filter foo.bar.*>
  type split_array
  split_key records
</filter>
```

### input

```
{"requestId":"034f","timestamp":1578090901599,"records":[{"data":"Log entry 1"},{"data":"Log entry 2"}]}
```

### output

```
{'data' => 'Log entry 1'}
{'data' => 'Log entry 2'}
```

## Example 3

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
