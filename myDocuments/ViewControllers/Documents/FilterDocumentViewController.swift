//
//  FilterDocumentViewController.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 15/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class FilterDocumentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var filterTypePickerView: UIPickerView!
    @IBOutlet weak var infoDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.isHidden = true
        infoDateLabel.isHidden = true
        filterTypePickerView.dataSource = self
        filterTypePickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter() {
        
        let name = nameTextfield.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = formatter.string(from: datePicker.date)
        let endDate = formatter.string(from: Date())
        
        if filterTypePickerView.selectedRow(inComponent: 0) == 0 && (name?.isEmpty)! {
            let alert = UIAlertController.init(title: "Erro", message: "Informe um nome", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
            
        } else if filterTypePickerView.selectedRow(inComponent: 0) == 0 {
            Service.filterDocumentsByName(name: name!) { error in
                
                if error != nil {
                    let alert = UIAlertController.init(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else if filterTypePickerView.selectedRow(inComponent: 0) == 1 {
            Service.filterDocumentsByDate(startDate: startDate, endDate: endDate) { error in
    
                if error != nil {
                    let alert = UIAlertController.init(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
    
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController.init(title: "Erro", message: "Selecione um tipo de pesquisa.", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    // MARK: - Picker View Delegate/Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            datePicker.isHidden = true
            infoDateLabel.isHidden = true
            nameTextfield.isHidden = false
        case 1:
            datePicker.isHidden = false
            infoDateLabel.isHidden = false
            nameTextfield.isHidden = true
            nameTextfield.text = ""
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Nome"
        case 1:
            return "Data"
        default:
            return ""
            
        }
    }

}
