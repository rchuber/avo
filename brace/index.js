var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function(req, res){
	res.sendfile('index.html');
});

app.use(express.static('public'));

io.on('connection', function(socket){
	console.log('a user connected');
	socket.on('recording', function(msg){
		io.emit('recording', msg);
	});
	socket.on('recording', function(msg){
		console.log('recording: ' + msg);
	});
});

http.listen(3000, function(){
	console.log('listening on *:3000');
});
