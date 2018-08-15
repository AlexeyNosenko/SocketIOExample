var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

http.listen(3000, function(){
  console.log(http);
  console.log('Listening on *:3000');
});

var userList = [];
var userTypingList = [];
var typingUsers = {};

var spam = io.of('/spam').on('connection', function(clientSocket){
	console.log('spam: new connection');

	clientSocket.on('spaming', function(){
		console.log('spam: spaming');
		var message = {} 
		message["title"] = "New game"
	    message["message"] = "bla bla bla woooh puf puf!"
	    message["url"] = "https://google.ru"
	    message["btnOk"] = "Buy"
	    message["btnCancel"] = "Cancel"
		spam.emit("spam", message);
		console.log('spam: emit spam');
	});
});

var chat = io.of('/chat').on('connection', function(clientSocket){
  console.log('chat: new connection');

  clientSocket.on('disconnect', function(){
    console.log('chat: disconnected');

    for (var i = 0; i < userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList[i]["isConnected"] = false;
        var clientNickname = userList[i]["nickname"];

        var message = "User " + clientNickname + " was disconnected.";
	    var messageInfo = {};
	    messageInfo["message"] = message
	    chat.emit("infoMessage", messageInfo);

	    delete typingUsers[clientNickname];
        break;
      }
    }
  });


  clientSocket.on("exitUser", function(clientNickname){
    for (var i = 0; i < userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList.splice(i, 1);
        break;
      }
    }
    var result = {}
    result["nickname"] = null
    clientSocket.broadcast.emit("updateUserList", result);
  });


  clientSocket.on('textMessage', function(clientNickname, message){
    var sendMessage = {};
    sendMessage["nickname"] = clientNickname;
    sendMessage["message"] = message
    sendMessage["sendDate"] = new Date().toLocaleString();
    delete typingUsers[clientNickname];
    clientSocket.broadcast.emit('textMessage', sendMessage);
  });

  clientSocket.on('imageMessage', function(clientNickname, message){
    var sendMessage = {};
    sendMessage["nickname"] = clientNickname;
    sendMessage["message"] = message
    sendMessage["sendDate"] = new Date().toLocaleString();
    delete typingUsers[clientNickname];
    clientSocket.broadcast.emit('imageMessage', sendMessage);
  });


  clientSocket.on("connectUser", function(clientNickname, ans) {
      var message = "User " + clientNickname + " was connected.";
      
      console.log(message);
      var result = {}
      result["nickname"] = clientNickname

      var userInfo = {};
      var foundUser = false;

      for (var i = 0; i < userList.length; i++) {
        if (userList[i]["nickname"] == clientNickname) {
        	console.log("User founded...");
        	foundUser = true;
        	// if (userList[i]["isConnected"] == true) {
        	// 	console.log("This online. Error");
        	// 	result["connected"] = false
      			// result["reason"] = "This client is already online"
        	// } else {
        	  console.log("This offline");
        	  userList[i]["isConnected"] = true
	          userList[i]["id"] = clientSocket.id;
	          userInfo = userList[i];
	          result["connected"] = true
        	  result["reason"] = ""
        	// }
          break;
        }

        if (userList[i]["id"] == clientSocket.id) {
        	if (userList[i]["nickname"] != clientNickname) {
        		userList[i]["nickname"] = clientNickname
        	}
        }
      }

      if (!foundUser) {
      	console.log("User not found. Added...");
        userInfo["id"] = clientSocket.id;
        userInfo["nickname"] = clientNickname;
        userInfo["isConnected"] = true
        userList.push(userInfo);
        result["connected"] = true
        result["reason"] = ""
      }

      var messageInfo = {};
      messageInfo["message"] = message

      if (result["connected"]) {
      	chat.emit("infoMessage", messageInfo);                          ///// <--------
      	var updateUserList = {}
  	    updateUserList["nickname"] = null
  	    clientSocket.broadcast.emit("updateUserList", updateUserList);  ///// <--------
      }
      // var result = {}
      // result["nickname"]
      // result["connected"]
      // result["reason"]
      ans(result)
  });

  // clientSocket.on("eventAck", function(data, ans) {
  //   console.log("eventAck");
  //   console.log(data);
  //   ans("My message from ack")
  // });

  // clientSocket.emit("checkAck", function(ans) {
  //       console.log("checkAck...");
  //       console.log(ans);
  //       console.log("checkAck");
  // })

  clientSocket.on("userEnterMessage", function(clientNickname, isEnter){
  	if (isEnter) {
  		console.log("User " + clientNickname + " is writing a message...");
  		typingUsers[clientNickname] = 1;
  	} else {
  		console.log("User " + clientNickname + " has stopped writing a message...");
  		delete typingUsers[clientNickname];
  	}

  	
  	var needShow = false
  	var message = ""

  	var keys = Object.keys(typingUsers);
  	if (keys.length > 0) {
  		var nicknames = ""
		keys.forEach(function(item, i, arr) {
	  		nicknames = nicknames + item + ", ";
	  		needShow = true
	  	});

	  	message = nicknames.slice(0, -2) + " is writing a message..."
  	}  	

  	var result = {}
  	result["message"] = message
  	result["needShow"] = needShow

    chat.emit("userTypingUpdate", result);
  });
});
