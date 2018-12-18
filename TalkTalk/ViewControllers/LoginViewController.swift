//
//  LoginViewController.swift
//  LoginScreen
//
//  Created by Florian Marcu on 1/15/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import FacebookCore
import FacebookLogin
import TwitterKit
import UIKit
import SocketIO

class LoginViewController: UIViewController {

   
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    // Facebook login permissions
    // Add extra permissions you need
    // Remove permissions you don't need
    private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]

    @IBAction func didTapLoginButton(_ sender: LoginButton) {
        // Regular login attempt. Add the code to handle the login by email and password.
        guard let id = usernameTextField.text, let pass = passwordTextField.text else {
            // It should never get here
            return
        }
        
        SocketIOManager.sharedInstance.connectToServerWithAccount(account: id, password: pass,completionHandler: { (result) -> Void in
            
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    if result != nil {
           
                        let temp = self.convertoObject(inArray: result!)
                        
                        print(temp["code"] as Any)
                        if temp["code"] as! NSNumber == 200
                        {
                            
                            SocketIOManager.sharedInstance.LogedInAccount = id
                            SocketIOManager.sharedInstance.LogedInPassword = pass
                                                       
                            self.presentTabScreenViewController()
                        }
                        else if temp["code"] as! NSNumber == 201
                        {
                            let alert = UIAlertController(title: "Alert", message: "ID and Password not matched.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                            }))
                             self.presentTabScreenViewController()
                           // self.present(alert, animated: true, completion: nil)
                            //
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Alert", message: "ID not exist .", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Join", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"Join\" alert occured.")
                                self.presentJoinScreenViewController()
                                
                            }))
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"Close\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                            //self.presentJoinScreenViewController()
                        }
                        
                        // you can now cast it with the right type
                        //if let dictFromJSON = decoded as? [String:String] {
                            
                          //  print(dictFromJSON)
                        
                        //}
                        
                        //dump(tempResult["code"])
                        //self.tblUserList.hidden = false
                    }
                    else
                    {
                        // for error handling process when result is null. maybe server fail... or
                         self.presentTabScreenViewController()
                        print("test");
                    }
                }
            }
            
        })
    }

    @IBAction func didTapFacebookLoginButton(_ sender: FacebookLoginButton) {
        // Facebook login attempt
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: readPermissions, viewController: self, completion: didReceiveFacebookLoginResult)
    }

    @IBAction func didTapTwitterLoginButton(_ sender: TwitterLoginButton) {
        // Twitter login attempt
        TWTRTwitter.sharedInstance().logIn(completion: { session, error in
            if let session = session {
                // Successful log in with Twitter
                print("signed in as \(session.userName)");
                let info = "Username: \(session.userName) \n User ID: \(session.userID)"
                self.didLogin(id: "Twitter", pw: info)
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    private func didReceiveFacebookLoginResult(loginResult: LoginResult) {
        switch loginResult {
        case .success:
            didLoginWithFacebook()
        case .failed(_): break
        default: break
        }
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
    
    private func convertoObject(inArray:Array<Any>)  -> NSDictionary {
        
        let tempArray = (inArray as NSArray)[0] as! NSObject
        //let type1 = type(of: tempArray)
        let dict = tempArray as! NSDictionary
        //print(dict["code"])
        return dict
    }

    private func didLoginWithFacebook() {
        // Successful log in with Facebook
        if let accessToken = AccessToken.current {
            let facebookAPIManager = FacebookAPIManager(accessToken: accessToken)
            facebookAPIManager.requestFacebookUser(completion: { (facebookUser) in
                if let _ = facebookUser.email {
                    let info = "First name: \(facebookUser.firstName!) \n Last name: \(facebookUser.lastName!) \n Email: \(facebookUser.email!)"
                    self.didLogin(id: "Facebook", pw: info)
                }
            })
        }
    }
    /*
    private func didLogin(method: String, info: String) {
        let message = "Successfully logged in with \(method). " + info
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
     */
    private func didLogin(id: String, pw: String) {
        
       
        
        let message = "Successfully logged in with \(id). " + pw
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
