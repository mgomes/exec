# Exec

A lightweight library for executing blocks at specified intervals. This library
aims to solve the following:

* Reliably run blocks at specified intervals regardless of the runtime duration of the block.
* Keep it light (avoid timezones and dependencies)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     exec:
       github: mgomes/exec
   ```

2. Run `shards install`

## Usage

```crystal
require "exec"
```

Specify the execution intervals for your code blocks:

```crystal
Exec.every(1.second) do
  do_work
end
```

```crystal
Exec.every(3.hours) do
  do_work
end
```

