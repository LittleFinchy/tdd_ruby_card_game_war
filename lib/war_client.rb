require "socket"

class WarClient
  attr_reader :socket, :output, :name

  def initialize(address = "localhost", port, name)
    @socket = TCPSocket.new(address, port)
    @name = name
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

# class TCPSocket
#   attr_accessor :address, :port, :name
#   attr_writer :name
#   attr_reader :name

#   def initialize(address, port)
#     @address = address
#     @port = port
#     @name = name
#   end
# end
