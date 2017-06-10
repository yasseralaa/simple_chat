require 'faye'

bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

bayeux.bind(:subscribe) do |client_id|
  puts "Client #{client_id} connected"
end

bayeux.bind(:disconnect) do |client_id|
  puts "Client #{client_id} disconnected"
end

run bayeux