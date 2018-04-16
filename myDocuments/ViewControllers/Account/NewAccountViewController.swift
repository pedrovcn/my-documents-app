//
//  NewAccountViewController.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 16/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccount() {
        if !validFields() {
            return
        }
        
        let user = User()
        user.name = (nameTextfield?.text)!
        user.email = (emailTextfield?.text)!
        user.phone = (phoneTextfield?.text)!
        user.password = Utils.md5((passwordTextfield?.text)!)
        
        Service.createUser(user: user) { error in
            
            var title = "Sucesso"
            var message = "Conta criada com sucesso. Faça o login para começar a usar o myDocuments."
            
            if(error != nil) {
                title = "Erro"
                message = (error?.localizedDescription)!
            }
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: { action in
                if(title == "Sucesso") {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func cancelEditing() {
        self.view.endEditing(true)
    }

    func validFields() -> Bool {
        
        if nameTextfield.text?.count == 0 {
            let alert = UIAlertController.simpleAlert(title:"Erro", message:"Informe o nome")
            present(alert, animated: true, completion: nil)
            return false
        }
        
        if emailTextfield.text?.count == 0 {
            let alert = UIAlertController.simpleAlert(title:"Erro", message:"Informe o email")
            present(alert, animated: true, completion: nil)
            return false
        }
        
        if passwordTextfield.text?.count == 0 {
            let alert = UIAlertController.simpleAlert(title:"Erro", message:"Informe o telefone")
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
    
    // MARK: TextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
