//
//  ToDoTableViewController.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 8/29/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit



struct Headline {
    
    var id : Int
    var date : Date
    var title : String
    var text : String
    var image : String
    
}

fileprivate func parseDate(_ str : String) -> Date {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    return dateFormat.date(from: str)!
}

fileprivate func firstDayOfMonth(date : Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
}

class ToDoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var ToDoTable: UITableView!
    
    static let sharedInstance = ToDoTableViewController()
    
    var headlines = [
        Headline(id: 1, date: parseDate("2018-08-15"), title: "E-Approval(#1233)", text: "For new employee, purchase 5 computer and 10 monitors.", image: "E-Approval"),
        Headline(id: 2, date: parseDate("2018-08-26"), title: "PO/Payment(#4224)", text: "Purchase requst mold for item KISS01, KISS02, KISS03.", image: "PoPayment"),
        Headline(id: 3, date: parseDate("2018-08-26"), title: "Expense(#2312)", text: "Business Trip Expense for traveling Asia to support SAP MM Setup", image: "Expense"),
        Headline(id: 4, date: parseDate("2018-08-27"), title: "Expense(#2421)", text: "IT Team Dinner for New Employees. 12 Employees attended and Controller attended", image: "Expense"),
        Headline(id: 5, date: parseDate("2018-09-01"), title: "Voucher(#2432)", text: "For wireless extender setup at HQ building. 20 Netgear extender will be purcased from Amazon.", image: "Voucher")
        ]

  
    var sections = [TableSection<Date, Headline>]()
    var selectedRow = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
        print("view apprear called")
        print(DataManage.sharedInstance.selectedRow)
        
        if(DataManage.sharedInstance.selectedRow > -1)
        {
            deleteRow(rowindex: DataManage.sharedInstance.selectedRow)
        }
        else
        {
            ToDoTable.delegate = self
            ToDoTable.dataSource = self
            self.sections = TableSection.group(rowItems: self.headlines, by: { (headline) in
                //return firstDayOfMonth(date: headline.date)
                return headline.date
            })
            
            ToDoTable.reloadData()
        }
     
        
    }
    
    
    func findIndexPath(title: String) -> Int {
        
        let tablelists = self.headlines
        var counter = 0;
        for tablelist in tablelists {
            
            if(title == tablelist.title)
            {
                return counter;
            }
            counter = counter + 1
            
            
        }
        return -1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]//  self.sections[section]
        let date = section.sectionItem
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.rowItems.count
    }
 
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = ToDoTable.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.selectionStyle = .none
       
        let section = self.sections[indexPath.section]
        let headline = section.rowItems[indexPath.row]
        // set the text from the data model
        cell.textLabel?.text = headline.title
        cell.detailTextLabel?.text = headline.text
        cell.imageView?.image = UIImage(named: headline.image)
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
       
        let selectedName = ToDoTable.cellForRow(at: indexPath)!.textLabel!.text!
        self.selectedRow = indexPath.row
        
        DataManage.sharedInstance.selectedRow = findIndexPath(title: selectedName)
        
       //print(ToDoTable.cellForRow(at: indexPath)!.textLabel!.text!)
        viewDetailView(todoTitle: selectedName)
        
    }
  
    
    
    
    func viewDetailView(todoTitle: String)
    {
        
        DataManage.sharedInstance.selectedToDoTitle = todoTitle;
        self.presentToDoDetailViewController(Name: todoTitle)
    
    }
    
    // Use this method whenever you want to present your Login Screen
    private func presentToDoDetailViewController(Name:String) {
        
        /*
         let ProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "FriendInfoView") as! ProfileViewController
         ProfileVC.text = Name
         self.present(ProfileVC, animated: true, completion: nil)*/
        let todoVC = storyboard?.instantiateViewController(withIdentifier: "todoDetailView") as! ToDoDetailViewController
        //ProfileVC.text = Name
        present(todoVC, animated:true)
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // swipe to delete
    func tableView(_ tableView: UITableView, commit editngStyle:UITableViewCellEditingStyle, forRowAt indexPath:IndexPath){
        
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Rate") { (action , indexPath ) -> Void in
            self.isEditing = false
            print("Rate button pressed")
        }
        
        //if editngStyle == UITableViewCellEditingStyle.delete{
            //headlines.remove(at:indexPath.row)
            //ToDoTable.deleteRows(at: [indexPath], with: .fade)
            //print(indexPath.section)
        
            if editngStyle == .delete {
                //sections.removeAtIndex(indexPath.section - 1)
                //let section = self.sections[indexPath.section]
                //let headline = section.rowItems[indexPath.row]
                
                //self.selectedRow = indexPath.row
                //let selectedName = ToDoTable.cellForRow(at: indexPath)!.textLabel!.text!
                
                
                let selectedIndex = findIndexPath(title: ToDoTable.cellForRow(at: indexPath)!.textLabel!.text!)
                print(selectedIndex)
                deleteRow(rowindex:selectedIndex)
               
                
            }
      
        //}
        
    }
    
    
    func deleteRow(rowindex:Int){
        
        print("delete row called")
        headlines.remove(at: rowindex)
        ToDoTable.delegate = self
        ToDoTable.dataSource = self
        self.sections = TableSection.group(rowItems: self.headlines, by: { (headline) in
            //return firstDayOfMonth(date: headline.date)
            return headline.date
        })
        
        ToDoTable.reloadData()
        DataManage.sharedInstance.selectedRow = -1
        
        
        
    }
    
    
  
    
    
    
    func loadNextVC() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            // Code to push/present new view controller
        }
    }
    
    
   
    
    /*************
    // MARK: - Table view data source
    
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
  
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count - 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath as IndexPath) as UITableViewCell;
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell;
        
        cell.textLabel?.text = array[indexPath.section][indexPath.row + 1]
        cell.textLabel?.text = array[indexPath.section][indexPath.row + 1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        
        return array[section][0]
    }
    
     
     
    **********/
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
