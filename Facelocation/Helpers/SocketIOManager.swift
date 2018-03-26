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
        print("\(socket.status) +++ СТАТУС")
        
        let jsonDic = ["chat": "5a6b6a6c0129a2792d5ab5c1",
                       "user": "5a6b52d60129a2792d5ab5b1"]
        
        if JSONSerialization.isValidJSONObject(jsonDic) {
            print("ВИПОЛНИЛОСЬ")
//            print("ЧАТ - \(chat)")
//            print("ЮЗЕР - \(user)")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                socket.emit("join", jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        print("\(socket.status) +++ СТАТУС2")
    }
    
    class func disconnectSocket(){
        print("СОКЕТ ОТКЛЮЧЕН")
        socket.disconnect()
    }

    class func removeListener(){
        print("СЛУШАТЕЛЬ СООБЩЕНИЙ УДАЛЕН")
        socket.off("new-message-mob")
    }

    class func sendMessage(messageData: Codable){
        socket.emit("save-message", with: messageData as! [Any])
    }

    class func connectToChatRoom(chat: String, user: String){
        print("ПОДКЛЮЧЕНИЕ В КОМНАТУ")
        
        let jsonDic = ["chat": chat,
                       "user": user]
        
        if JSONSerialization.isValidJSONObject(jsonDic) {
            print("ЧАТ - \(chat)")
            print("ЮЗЕР - \(user)")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                socket.emit("join", jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    class func reciveMessage(){
        print("ЗАПУСТИЛИ СЛУШАТЕЛЬ")
        
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
//
//
//            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//            // here "decoded" is of type `Any`, decoded from JSON data
//
//            // you can now cast it with the right type
//            if let dictFromJSON = decoded as? [String:String] {
//                // use dictFromJSON
//            }
//        } catch {
//            print(error.localizedDescription)
//        }

        socket.on("new-message-mob") { (dataArray, ack) in
            print("ПОЛУЧИЛ СООБЩЕНИЕ")
            print("\(dataArray.count) +++ dddd")
        }
    }
    
    
    class func isSocketConnected() -> Bool{
        if socket.status == .connected {
            print("СОКЕТ ПОДКЛЮЧЕН")
            return true
        }
        return false
    }
    
    
    override init() {
        super.init()
    
    }
}
