//
//  DataTable.swift
//  Facelocation
//
//  Created by Nastro Mo on 18.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import SQLite

class DataBaseHelper{
    
    static var db: Connection!
    
    static var usersTable = Table("USERS")
    
    static let id = Expression<Int64>("id")
    static let USER_ID = Expression<String?>("USER_ID")
    static let USER_FIRST_LOGIN = Expression<Bool>("USER_FIRST_LOGIN")
    static let USER_EMAIL = Expression<String?>("USER_EMAIL")
    static let USER_ROLE = Expression<String?>("USER_ROLE")
    static let USER_STATUS = Expression<String?>("USER_STATUS")
    static let USER_TOKEN = Expression<String?>("USER_TOKEN")
    static let USER_NAME = Expression<String?>("USER_NAME")
    static let USER_LASTNAME = Expression<String?>("USER_LASTNAME")
    static let USER_PHONE = Expression<String?>("USER_PHONE")
    static let USER_JOB = Expression<String?>("USER_JOB")
    static let USER_AVATAR_URL = Expression<String?>("USER_AVATAR_URL")
    
    static var userDataArray = [String]()
   
    
    //Create a directory and SQLite file, them open connection to this DB file
    class func createDataBase(){
        do {
            //Create a directory for future DB file
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            //Create DB file in created before directory
            let dataBaseFileURL = documentDirectory.appendingPathComponent("facelocationDB").appendingPathExtension("sqlite3")
            
            //Open a connection to DB file
            db = try Connection(dataBaseFileURL.path)
            
            print("ФАЙЛ ДЛЯ БД СОЗДАН УСПЕШНО! СОЕДИНЕНИЕ УСТАНОВЛЕНО.")
        } catch {
            print(error)
        }
    }
    
    
    //Create a table with columns in our DB file
    class func createTable(){
        do {
            try db.run(usersTable.create{ t in
                t.column(id, primaryKey: true)
                t.column(USER_ID)
                t.column(USER_FIRST_LOGIN)
                t.column(USER_EMAIL)
                t.column(USER_ROLE)
                t.column(USER_STATUS)
                t.column(USER_TOKEN)
                t.column(USER_NAME)
                t.column(USER_LASTNAME)
                t.column(USER_PHONE)
                t.column(USER_JOB)
                t.column(USER_AVATAR_URL)
                })
            print("БАЗА ДАННЫХ СОЗДАНА УСПЕШНО!")
        } catch {
            print(error)
        }
    }
    
    
    //Insert user in to DB table
    class func insertUser(userID: String,
                          userFirstLogin: Bool,
                          userEmail: String,
                          userToken: String,
                          userAvatarURL: String){
        let insert = usersTable.insert(USER_ID <- userID,
                                       USER_FIRST_LOGIN <- userFirstLogin,
                                       USER_EMAIL <- userEmail,
                                       USER_TOKEN <- userToken,
                                       USER_AVATAR_URL <- userAvatarURL)
        
        do {
            try db.run(insert)
            
            //Add user data to userDataArray
            self.getLogedUsers()
            print("ПОЛЬЗОВАТЕЛЬ УСПЕШНО ДОБАВЛЕН В БД")
        } catch {
            print(error)
        }
        
    }
    
    //Get all users who have USER_FIRST_LOGIN = true (true = 1 in SQLite)
    class func getLogedUsers() -> Int64{
        do {
            //db.prepare returns a Statement obj wich is similar to Array
            let usersStatement = try db.prepare("SELECT * FROM USERS WHERE USER_FIRST_LOGIN = '1'")
            
            print(usersStatement.description)
            for user in usersStatement {
                print(user[1]!)
                userDataArray.append(user[1] as! String)           //USER_ID in userDataArray 0
                
                print(user[3]!)
                userDataArray.append(user[3] as! String)           //USER_EMAIL in userDataArray 1
                
                print(user[6]!)
                userDataArray.append(user[6] as! String)           //USER_TOKEN in userDataArray 2
                
                print(user[11]!)
                userDataArray.append(user[11] as! String)           //USER_AVATAR_URL in userDataArray 3
            }
            
            //Get numbers of returned rows
            let scalar = try db.scalar("SELECT count(*) FROM USERS") as! Int64
            
            print("КОЛИЧЕСТВО ПОЛЬЗОВАТЕЛЕЙ В БД СО ЗНАЧЕНИЕМ USER_FIRST_LOGIN: \(scalar)")
            return scalar
            
        } catch {
            print(error)
            print("ОШИБКА ДОСТАВАНИЯ ЮЗЕРА")
            return 0
        }
    }
    
    
    //Delete user who clicked "Exit" in app menu
    class func deleteUser(userID: String){
        do {
            let user = usersTable.filter(USER_ID == "\(userID)")
            try db.run(user.delete())
            print("УДАЛЕНИЕ ЮЗЕРА ПРОИЗВЕДЕНО УСПЕШНО")
        } catch {
            print(error)
            print("ОШИБКА УДАЛЕНИЯ ЮЗЕРА ИЗ БД")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
