//
//  RegisterViewController.swift
//  RoomyApp
//
//  Created by MAC on 9/5/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signupInBtn(_ sender: Any) {
        
        guard let email = emailTxtField.text, !(emailTxtField.text?.isEmpty)! else { return }
        guard let name = nameTxtField.text, !(nameTxtField.text?.isEmpty)! else { return }
        guard let password = passwordTxtField.text, !(passwordTxtField.text?.isEmpty)! else { return }
        loadingView.startAnimating()
        RoomyRouter.register(name: name, email: email, password: password).requestEndPointWithoutData(onRequestSuccess: { (response) in
            let user = try? JSONDecoder().decode(User.self, from: response.data!)
            self.loadingView.stopAnimating()
            let alert = UIAlertController(title: "Registered!", message: user?.message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) { (Error) in
            let alert = UIAlertController(title: "Error!", message: "Invalid Data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }.subscribe()
    }
    

    
}
