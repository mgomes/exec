require "./spec_helper"

describe Exec do
  it "executes the block for a given interval" do
    count = Atomic(Int32).new(1)
    Exec.every(50.milliseconds) do
      count.add(1)
    end

    sleep 250.milliseconds

    count.get.should be_close(5, 1)
  end

  it "handles blocks that run past the interval" do
    count = Atomic(Int32).new(1)
    Exec.every(50.milliseconds) do
      count.add(1)
      sleep 250.milliseconds
    end

    sleep 250.milliseconds

    count.get.should be_close(5, 1)
  end

  it "handles nesting of exec blocks" do
    count1 = Atomic(Int32).new(1)
    count2 = Atomic(Int32).new(6)
    Exec.every(50.milliseconds) do
      count1.add(1)
      Exec.every(50.milliseconds) do
        count2.add(-1)
      end
    end

    sleep 250.milliseconds

    count1.get.should be_close(5, 1)
    count2.get.should be_close(0, 1)
  end

  it "handles multiple exec blocks simultaneously" do
    count1 = Atomic(Int32).new(1)
    Exec.every(50.milliseconds) do
      count1.add(1)
    end

    count2 = Atomic(Int32).new(1)
    Exec.every(25.milliseconds) do
      count2.add(1)
    end

    sleep 250.milliseconds

    count1.get.should be_close(5, 1)
    count2.get.should be_close(10, 1)
  end

  it "handles long running exec blocks" do
    count = Atomic(Int32).new(1)
    Exec.every(50.milliseconds) do
      count.add(1)
    end

    sleep 250.milliseconds
    count.get.should eq 5
    sleep 250.milliseconds
    count.get.should be_close(10, 1)
    sleep 250.milliseconds
    count.get.should be_close(15, 1)
    sleep 2500.milliseconds
    count.get.should be_close(65, 5)
  end

  it "handles longer intervals" do
    count = Atomic(Int32).new(1)
    Exec.every(3.seconds) do
      count.add(1)
    end

    sleep 4.seconds

    count.get.should eq 2
  end
end
