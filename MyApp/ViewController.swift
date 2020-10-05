//
//  ViewController.swift
//  MyApp
//
//  Created by Yann Durand on 24/09/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var scheduler: UIDatePicker!
    @IBAction func cancel(sender: UIBarButtonItem) {
       let isInAddMode = presentingViewController is UINavigationController
        
       if isInAddMode {
         dismiss(animated: true, completion: nil)
       }
       else {
         navigationController!.popViewController(animated: true)
       }
    }
    
    @IBAction func setLabelText(_ sender: UIButton) {
        nameLabel.text = nameTextField.text
    }
    
    var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = item {
           nameTextField.text = item.name
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if sender as AnyObject? === saveButton {
        let name = nameTextField.text ?? ""
        item = Item(name: name)
      }
    }
    
}

