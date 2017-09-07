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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Button Actions
    @IBAction func loginButtonAction(_ sender: Any) {
    }
    
    @IBAction func signoutButtonAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
        
    }
    
    @IBAction func facebookLoginButtonAction(_ sender: Any) {
    }
    
    @IBAction func googleSgininButtonAction(_ sender: Any) {
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleSgininButton: GIDSignInButton!
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
