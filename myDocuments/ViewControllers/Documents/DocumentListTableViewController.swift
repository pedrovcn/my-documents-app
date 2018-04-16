//
//  DocumentListTableViewController.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 14/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class DocumentListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDocumentsList()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor.lightGray
        self.refreshControl?.addTarget(self, action: #selector(refreshDocumentsList), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func refreshDocumentsList() {
        Service.getAllDocuments() { error in
            if error != nil {
                let alert = UIAlertController.simpleAlert(title: "Erro", message: (error?.localizedDescription)!)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.tableView.reloadData()
            }
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApplicationManager.sharedInstance.documentsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)

        cell.textLabel?.text = ApplicationManager.sharedInstance.documentsArray[indexPath.row].name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DocumentDetail") {
            let navViewController = segue.destination as! UINavigationController
            let viewController = navViewController.viewControllers[0] as! DocumentDetailViewController
            viewController.document = ApplicationManager.sharedInstance.documentsArray[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

}
