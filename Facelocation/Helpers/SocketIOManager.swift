//
//  SocketIOManager.swift
//  Facelocation
//
//  Created by Nastro Mo on 25.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import SocketIO


class SocketIOManager: NSObject {

    static let manager = SocketManager(socketURL: URL(string: "https://face-location.com:443")!, config: [.log(true), .compress])
    static let socket = manager.defaultSocket

    
    class func connectSocket(){
        self.manager.config = SocketIOClientConfiguration(
            arrayLiteral: .connectParams(["token": DataBaseHelper.userDataArray[2]]), .secure(true)
        )
        socket.connect()
    }
    
    
    
    class func onConnected(chat: String, user: String){
        print("\(socket.status) - СТАТУС СОКЕТА В СОКЕТ МЕНЕДЖЕРЕ")
        socket.on(clientEvent: .connect) { data, ack in
            print("СОКЕТ ПОДКЛЮЧЕН")
            connectToChatRoom(chat: chat, user: user)
        }
    }
    
    
    
    class func connectToChat(chat: String, user: String){
        print("\(socket.status) СТАТУС СОКЕТА ВНУТРИ КОННЕКТ ТУ ЧАТ")
            connectToChatRoom(chat: chat, user: user)

    }

    
    
    class func disconnectSocket(){
        print("СОКЕТ ОТКЛЮЧЕН")
        socket.disconnect()
    }
    
    

    class func removeListener(){
        print("СЛУШАТЕЛЬ СООБЩЕНИЙ УДАЛЕН")
        socket.off("new-message-mob")
        socket.off("connect")
        socket.removeAllHandlers()
    }
    
    

    class func sendMessage(messageData: Codable){
        print("СООБЩЕНИЕ ОТПРАВЛЕННО")
        socket.emit("save-message", with: messageData as! [Any])
    }
    
    

    class func connectToChatRoom(chat: String, user: String){

        print("CHEKING SOCKET CONNECTION 1-ST TIME - \(socket.status)")
        
        let jsonObject: [String: Any] = [
            "chat": chat,
            "user": user
        ]
        socket.emit("join", jsonObject)
        
        print("CHEKING SOCKET CONNECTION 2-ND TIME - \(socket.status)")
    }
    
        //Check this for async message showing:
        //https://github.com/appcoda/SocketIOChat/blob/master/SocketChat/ChatViewController.swift

}
