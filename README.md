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

## Caveats

* In the usage examples above, if the `do_work` method takes longer to execute than the specified interval, the next interval will be executed before the existing code block has completed. Therefore, multiple versions of `do_work` will be executing concurrently. If this is a concern for your code block, ensure you have enough margin built into the interval or that you've built in other safety measures to prevent corruption.

* You'll likely want to compile your applications with the `-Dpreview_mt` flag to take advantage of parallel execution. You can then run your binary with the `CRYSTAL_WORKERS=N` environment variable. Set `N` to the number of cores on your CPU.
