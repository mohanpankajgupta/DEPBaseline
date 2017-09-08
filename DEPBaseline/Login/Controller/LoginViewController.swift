//
//  LoginViewController.swift
//  DEPBaseline
//
//  Created by Smita Tamboli on 06/09/17.
//  Copyright © 2017 Netcracker. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        configureFacebook()
        
        if (FBSDKAccessToken.current() != nil) {
            returnUserData()
        }
        
        configureSignoutButton()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Private methods
    
    private func configureFacebook() {
        facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"];
        facebookLoginButton.delegate = self
    }
    
    internal func configureSignoutButton() {
        signoutButton.isEnabled = (FBSDKAccessToken.current() != nil) || (GIDSignIn.sharedInstance().currentUser != nil) ? true : false
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        print("called")
    }
    
    
    /*func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        print("called")
    }*/
    
    internal func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name, last_name, email, picture.type(large)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error))")
            }
            else
            {
                let userDetail = result as! [String:Any]
                print(userDetail)
                
            }
        })
    }
    
    //MARK: Button Actions
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func signoutButtonAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        
        configureSignoutButton()
        
    }
    
    @IBOutlet weak var signoutButton: UIBarButtonItem!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
            return true
        }
        
    }
    
}

extension LoginViewController: FBSDKLoginButtonDelegate {
        
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if ((error) != nil) {
            // Process error
        } else {
            self.returnUserData()
        }
        
        configureSignoutButton()
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        FBSDKLoginManager().logOut()
    }
    
}

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            
            // Perform any operations on signed in user here.
            let userId = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print(userId ?? "")
            print(idToken ?? "")
            print(fullName ?? "")
            print(givenName ?? "")
            print(familyName ?? "")
            print(email ?? "")
            
        } else {
            print("\(error.localizedDescription)")
        }
        
        configureSignoutButton()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}
