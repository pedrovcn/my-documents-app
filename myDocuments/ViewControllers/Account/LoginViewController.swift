//
//  LoginViewController.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 16/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        if !validFields() {
            return
        }
        let email = emailTextfield.text
        let password = Utils.md5(passwordTextfield.text!)
        
        let user = User()
        user.email = email!
        user.password = password
        
        Service.loginUser(user: user) { error in
            if error != nil {
                let alert = UIAlertController.simpleAlert(title: "Erro", message: "Usuário/senha incorretos")
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.performSegue(withIdentifier: "DocumentList", sender: nil)
            }
        }
    }
    
    @IBAction func cancelEditing() {
        self.view.endEditing(true)
    }
    
    func validFields() -> Bool {
        
        if emailTextfield.text?.count == 0 {
            let alert = UIAlertController.simpleAlert(title:"Erro", message:"Informe o email")
            present(alert, animated: true, completion: nil)
            return false
        }
        
        if passwordTextfield.text?.count == 0 {
            let alert = UIAlertController.simpleAlert(title:"Erro", message:"Informe a senha")
            present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
