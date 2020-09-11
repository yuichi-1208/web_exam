require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'web.html.erb')
server.mount('/web', WEBrick::HTTPServlet::ERBHandler, 'web.html.erb')
server.mount('/webgoya_one.cgi', WEBrick::HTTPServlet::CGIHandler, 'webgoya_one.rb')
server.mount('/webgoya_two.cgi', WEBrick::HTTPServlet::CGIHandler, 'webgoya_two.rb')

server.start
