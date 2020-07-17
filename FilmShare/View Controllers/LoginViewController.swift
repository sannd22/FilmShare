//
//  LoginViewController.swift
//  MovieShare
//
//  Created by David Sann on 7/8/20.
//  Copyright © 2020 David Sann. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpElements() {
           
           // Hide error label
           errorLabel.alpha = 0
           
           // Set looks for all elements
           Utilities.styleTextField(emailTextField)
           Utilities.styleTextField(passwordTextField)
           Utilities.styleFilledButton(loginButton)
       }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Credentials
        
        
        // Clean data
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // Sign in
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // Failed SignIn
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                let tabViewController = self.storyboard?.instantiateViewController(identifier: Constants.StoryBoard.tabViewController) as? UITabBarController
                
                self.view.window?.rootViewController = tabViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
