//
//  SignUpViewController.swift
//  MovieShare
//
//  Created by David Sann on 7/8/20.
//  Copyright © 2020 David Sann. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
   
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Set looks for all elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Check Fields for valid data, if correct return nil, else error message as String
    func validateFields() -> String? {
        
        // Check that all fields have data
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let cleanPass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPass) == false {
            // Password is not secure
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let err = validateFields()
        if err != nil {
            // Display Error Message
            displayError(err!)
        }
        else {
            // Clean data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the User
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                // Check Errors
                if error != nil {
                    // An error has occured
                    self.displayError("Error creating user")
                }
                else {
                    // User creation success
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.displayError("Error saving user data.")
                        }
                    }
                    // Transition to the Home Screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
        let tabViewController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.tabViewController) as? UITabBarController
        
        view.window?.rootViewController = tabViewController
        view.window?.makeKeyAndVisible()
    }
    
    func displayError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
