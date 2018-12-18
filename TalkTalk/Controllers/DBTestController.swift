//
//  DBTestController.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 9/29/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import SQLite3

class DBTestController: UIViewController {

    var db: OpaquePointer?
    @IBOutlet weak var Text1: UITextField!
    
    @IBOutlet weak var Text2: UITextField!
    
    @IBOutlet weak var Text3: UITextField!
    
    @IBOutlet weak var Text4: UITextView!
    
    
    @IBAction func Btn1(_ sender: Any) {
        
        self.saveValue()
        
        
        
    }
    @IBAction func Btn2(_ sender: Any) {
        
        
        
        
    }
    
    
    static let sharedInstance = DBTestController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //the database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("TalkTalk.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Chat(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, message TEXT, roomNumber TEXT, dateText DATE, dateInt INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS ChatGroup(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, message TEXT, roomNumber TEXT, dateText DATE, dateInt INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func saveValue()
    {
        
        
        //creating a statement
        var stetement: OpaquePointer? = nil
        
        //the insert query
        let queryString = "INSERT INTO Chat (name, message, roomNumber, dateText, dateInt) VALUES (?,?,?,?,?);"


        /*
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stetement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //binding the parameters
        if sqlite3_bind_text(stetement, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stetement, 2, message, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding message: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stetement, 3, roomNumber, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding roomNumber: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stetement, 4, String(currentDate), -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding dateString: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int64(stetement, 5, sqlite3_int64(dateInt)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding dateInt: \(errmsg)")
            return
        }
        
       
        //executing the query to insert values
        if sqlite3_step(stetement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
        */
        
        if sqlite3_prepare_v2(db, queryString, -1, &stetement, nil) == SQLITE_OK {
            //let id: Int32 = 1
            //let name: NSString = "Ray"
            
            let name = self.Text1.text
            let message = self.Text4.text
            let roomNumber = self.Text2.text
            
            let someDate = Date()
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let currentDate = formatter.string(from: someDate).split(separator: " ")[0] // string purpose I add
            let timeInterval = someDate.timeIntervalSince1970
            let dateInt = Int(timeInterval*1000)
            
            
            sqlite3_bind_text(stetement, 1, String(self.Text1.text!), -1, nil)
            sqlite3_bind_text(stetement, 2, String(self.Text4.text), -1, nil)
            sqlite3_bind_text(stetement, 3, String(self.Text2.text!), -1, nil)
            sqlite3_bind_text(stetement, 4, String(currentDate), -1, nil)
            sqlite3_bind_int64(stetement, 5, sqlite3_int64(dateInt))
    
            
            // 4
            if sqlite3_step(stetement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(stetement)
        
       self.Text1.text=""
       self.Text4.text=""
       self.Text2.text=""
        
        
    }
    /*
    func saveValue()
    {
        //getting values from textfields
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let powerRanking = textFieldPowerRanking.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //validating that values are not empty
        if(name?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(powerRanking?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        //creating a statement
        var stetement: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO Heroes (name, powerrank) VALUES (?,?)"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stetement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //binding the parameters
        if sqlite3_bind_text(stetement, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stetement, 2, (powerRanking! as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        //executing the query to insert values
        if sqlite3_step(stetement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
        //emptying the textfields
        textFieldName.text=""
        textFieldPowerRanking.text=""
        
        
        readValues()
        
        //displaying a success message
        print("Herro saved successfully")
    }
    func readValues(){
        
        //first empty the list of heroes
        heroList.removeAll()
        
        //this is our select query
        let queryString = "SELECT * FROM Heroes"
        
        //statement pointer
        var stetement:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stetement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //traversing through all the records
        while(sqlite3_step(stetement) == SQLITE_ROW){
            let id = sqlite3_column_int(stetement, 0)
            let name = String(cString: sqlite3_column_text(stetement, 1))
            let powerrank = sqlite3_column_int(stetement, 2)
            
            //adding values to list
            heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
