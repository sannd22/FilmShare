//
//  LoginViewController.swift
//  MovieShare
//
//  Created by David Sann on 7/8/20.
//  Copyright © 2020 David Sann. All rights reserved.
//

import UIKit

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
    }
    
}
