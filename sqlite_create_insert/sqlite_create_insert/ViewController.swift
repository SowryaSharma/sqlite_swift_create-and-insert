//
//  ViewController.swift
//  sqlite_create_insert
//
//  Created by Cumulations Technologies on 02/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initDatabase()
    }


}

import SQLite3
import UIKit

class createDataBase{
    init()
    {
        db = openDatabase()
        createTable()
    }
    var db:OpaquePointer?
    let dbPath = "myDatabase.sqlite"
    
    func openDatabase() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        if (sqlite3_open(fileURL.path,&db) == SQLITE_OK){
            print("dartabase created")
            return db
        }
        else{
            print("couldnt open")
            return nil
        }
        
    }
    func createTable(){
        let createtableQuery = "CREATE TABLE IF NOT EXISTS FIRSTTABLE  (Id INTEGER PRIMARY KEY,name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(db,createtableQuery,-1,&createTableStatement,nil) == SQLITE_OK){
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("table created")
            }
            else{
                print("error")
            }
        }
        else{
                print("error")
            }
                   
    }
    
    func inseertIntoTAble(id:Int,name:String){
        let insertQuery = "INSERT INTO FIRSTTABLE (id,name) values(?,?)"
        var insertStatement:OpaquePointer?
        if(sqlite3_prepare_v2(db, insertQuery,-1,&insertStatement,nil) == SQLITE_OK){
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            if(sqlite3_step(insertStatement) == SQLITE_DONE){
                print("data inserted")
            }
            else{
                print("error")
                
            }
  
        }
    }
    
}
func initDatabase(){
let obj = createDataBase()
print(obj.db!)
obj.inseertIntoTAble(id: 2, name: "katy")
}
