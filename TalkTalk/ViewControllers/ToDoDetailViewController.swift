//
//  ToDoDetailViewController.swift
//  TalkTalk
//
//  Created by admin on 10/17/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit

class ToDoDetailViewController: UIViewController {

    
    
   
    var tempText = ""
    
    @IBAction func Close(_ sender: Any) {
        
        self.closeview()
       
        
    }
    
    @IBOutlet weak var ToDoTitleLable: UILabel!
    
    @IBOutlet weak var ContentView: UIScrollView!
    
    @IBAction func Approve(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirm Messege", message: "Approved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Close\" alert occured.")
            
            DataManage.sharedInstance.appprovedToDoTitle = self.ToDoTitleLable.text!
            
            self.approved(title: self.ToDoTitleLable.text! )
            //ToDoTableViewController.sharedInstance.deleteRow(rowtitle: "Test")
            
        }))
        //alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Default action"), style: .default, handler: { _ in
        //    NSLog("The \"Close\" alert occured.")
        //}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func Reject(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Messege", message: "Rejected.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Close\" alert occured.")
            
            self.rejected(title: self.ToDoTitleLable.text! )
            //ToDoTableViewController.sharedInstance.deleteRow(rowtitle: "Test")
            
        }))
        //alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Default action"), style: .default, handler: { _ in
        //    NSLog("The \"Close\" alert occured.")
        //}))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var ApproveButton: UIButton!
    
    @IBOutlet weak var RejectButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Todo Detail View Appeared")
        
        print(DataManage.sharedInstance.selectedToDoTitle)
        ToDoTitleLable?.text = DataManage.sharedInstance.selectedToDoTitle
        ApproveButton.layer.cornerRadius = 10
        ApproveButton.layer.borderWidth = 1
        RejectButton.layer.cornerRadius = 10
        RejectButton.layer.borderWidth = 1
        
        
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Todo Detail View Appeared")
        
       
        if DataManage.sharedInstance.selectedToDoTitle == "E-Approval(#1233)"{
           // self.tempText = DataManage.sharedInstance.StringTwo
        }
        else
        {
          //  self.tempText = DataManage.sharedInstance.StringOne
            
        }
        //print(self.tempText)
        let labelTwo: UILabel = {
            let label = UILabel()
            label.text = self.tempText
            label.translatesAutoresizingMaskIntoConstraints = false
            
            //ContentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
            //ContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
            //ContentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
            //ContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true
            return label
        }()
        
        ContentView.addSubview(labelTwo)
        
        //labelTwo.leadingAnchor.constraint(equalTo: ContentView.leadingAnchor, constant: 16.0).isActive = true
        //labelTwo.topAnchor.constraint(equalTo: ContentView.topAnchor, constant: 16.0).isActive = true
        
        //ChatTo?.text = FriendViewController.sharedInstance1.selectedFriendName
       
    }
    
    private func presentTabScreenViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "TabViewControllerIdentifier")
        self.present(loginVC, animated: true, completion: nil)
    }
    
    private func presentJoinScreenViewController() {
        let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let joinVC = storyboard.instantiateViewController(withIdentifier: "JoinViewControllerIdentifier")
        self.present(joinVC, animated: true, completion: nil)
    }
    
    
    private func closeview()
    {
        //ToDoTableViewController.sharedInstance.headlines remove
        DataManage.sharedInstance.selectedRow = -1
        ToDoTableViewController.sharedInstance.selectedRow = -1
        print(ToDoTableViewController.sharedInstance.selectedRow)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func approved(title:String)
    {
        //ToDoTableViewController.sharedInstance.headlines remove
        self.dismiss(animated: true, completion: nil)
    }
    
    private func rejected(title:String)
    {
        //ToDoTableViewController.sharedInstance.headlines remove
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
