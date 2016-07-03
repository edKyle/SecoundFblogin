//
//  ViewController.swift
//  SecoundFblogin
//
//  Created by Kyle on 6/29/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SDWebImage

class ViewController: UIViewController,FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if FBSDKAccessToken.currentAccessToken() != nil{
            
        performSegueWithIdentifier("loginSegue", sender: self)
            
            
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    }
    
}



