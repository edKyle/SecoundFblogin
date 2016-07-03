//
//  afterLoginfbFirstViewController.swift
//  SecoundFblogin
//
//  Created by Kyle on 7/1/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SDWebImage

class afterLoginfbFirstViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbLogOutButton: FBSDKLoginButton!
    @IBOutlet weak var personPicture: UIImageView!
    @IBOutlet weak var activityCircle: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLogOutButton.delegate = self
   
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        getFbPicture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFbPicture(){
        
        activityCircle.startAnimating()
        
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large)"])
        request.startWithCompletionHandler({ (connection, result, error) in
            
            if  let info = result{
                info as! NSDictionary
            if let imageURL = info.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as? String {
                
                let nsurl = NSURL(string: imageURL)
             
                self.personPicture.sd_setImageWithURL(nsurl)
                
                self.activityCircle.stopAnimating()
                }
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        if FBSDKAccessToken.currentAccessToken() == nil{
            
            performSegueWithIdentifier("fbLogoutSague", sender: self)
    
        }
    
    }
}