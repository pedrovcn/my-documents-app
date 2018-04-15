//
//  AddDocumentViewController.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 14/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController {

    @IBOutlet weak var nameDocumentTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDocument() {
        let documentName = self.nameDocumentTextfield.text
        
        let doc = Document.init(nameDocument: documentName!)
    
        Service.saveDocument(document: doc!) { error in
            
            var title = "Sucesso"
            var message = "Documento salvo."
            
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
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

}
