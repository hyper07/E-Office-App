//
//  JoinViewController.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 8/21/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit
import SocketIO

class JoinViewController: UIViewController {


    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var NameText: UITextField!
    
    @IBOutlet weak var PWText: UITextField!
    
    @IBAction func JoinClicked(_ sender: Any) {
        
        
        
        
    }
    
    
    @IBAction func CancelJoin(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerIdentifier")
            
            // if it will be the root
            UIApplication.shared.keyWindow?.rootViewController?.present(vc!, animated: true, completion: nil)
        })
        
    }
    
    
   
    
    //}: UIButton!
/*
    @IBAction func JoinClicked()
    {
        
     self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
     self.dismiss(animated: true, completion: {
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerIdentifier")
     
     // if it will be the root
     UIApplication.shared.keyWindow?.rootViewController?.present(vc!, animated: true, completion: nil)
     })
        
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadNextVC() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            // Code to push/present new view controller
        }
    }
    
}
