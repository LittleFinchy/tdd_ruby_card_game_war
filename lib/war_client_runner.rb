require "socket"

class WarClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new("localhost", port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay = 0.1)
    sleep(delay)
    @output = @socket.read_nonblock(1000).chomp # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end

client = WarClient.new(3335)
while true
  output = ""
  until output != ""
    output = client.capture_output
  end
  print output
  client.provide_input(gets.chomp)
end
