//
//  ViewController.swift
//  FirebaseText
//
//  Created by Praveen Samuel . J on 07/11/16.
//  Copyright © 2016 Praveen Samuel . J. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var password: UITextField!
    
    //var databaseReference = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func SignUpPressed(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if error != nil {
                self.errorMessage.text = error?.localizedDescription
            }
            else{
                self.errorMessage.text = "Registered Successfully"
                FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (user, error) in
                    if error == nil{
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("Email").setValue(self.email.text!)
                        self.performSegue(withIdentifier: "SuccessSegue", sender: nil)
                    }
                })
            }
        })
       
    }
}

