require 'bunny'
require 'json'

b =Bunny.new('amqp://jtnipnty:oiyV4umiKwf_la6R-2DQ7rmOXDO3LCcT@otter.rmq.cloudamqp.com/jtnipnty')
b.start
ch=b.create_channel
q=ch.queue('INPUT', durable: true)
file=File.read('sample.json')
puts "---------------------About to Publish------------------"
ch.default_exchange.publish(file , routing_key: 'INPUT', persistent: true)
puts "---------------------Published-------------------------"
b.close
