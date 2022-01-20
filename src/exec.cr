require "./exec/**"

class Exec
  def self.every(interval, &block)
    spawn(name: "Every #{interval}") do
      loop do
        sleep interval
        spawn(name: "Every #{interval} - payload", same_thread: false, &block)
      end
    end
  end
end
