require 'bunny'
require 'json'
b = Bunny.new('amqp://jtnipnty:oiyV4umiKwf_la6R-2DQ7rmOXDO3LCcT@otter.rmq.cloudamqp.com/jtnipnty')
b.start

ch = b.create_channel
q = ch.queue('INPUT', durable: true)

puts ' [*] Waiting for messages. To exit press CTRL+C'

begin
  q.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    puts " Received-----> '#{body}'"
    sleep body.count('.')
    puts ' -----------Done---------------'
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  b.close
end