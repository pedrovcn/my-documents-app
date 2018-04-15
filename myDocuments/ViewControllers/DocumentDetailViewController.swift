//
//  DocumentDetailViewController.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 15/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class DocumentDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var documentDateLabel: UILabel!
    
    var document: Document? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        documentNameLabel.text = document?.name
        documentDateLabel.text = document?.date
//        photoImageView.image = UIImage.returnImageBase64()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
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
