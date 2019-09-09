//
//  LoginViewController.swift
//  RoomyApp
//
//  Created by MAC on 9/1/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        guard let email = emailTxtField.text, !(emailTxtField.text?.isEmpty)! else { return }
        guard let password = passwordTxtField.text, !(passwordTxtField.text?.isEmpty)! else { return }
        loadingView.startAnimating()
        RoomyRouter.login(email: email, password: password).requestEndPointWithoutData(onRequestSuccess: { (response) in
        let user = try? JSONDecoder().decode(User.self, from: response.data!)
            
        UserDefaults.standard.set(user?.auth_token, forKey: "userToken")
        self.loadingView.stopAnimating()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let roomViewController = storyBoard.instantiateViewController(withIdentifier: "roomViewController") as! GetRoomViewController
            self.present(roomViewController, animated: true, completion: nil)
        }) { (erorr) in
            print("Erorr")
            self.loadingView.stopAnimating()
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }.subscribe()
      
    }
}



