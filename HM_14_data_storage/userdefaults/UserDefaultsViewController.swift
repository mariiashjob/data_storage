//
//  UserDefaultsViewController.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 08.11.2022.
//

import Foundation
import UIKit

class UserDefaultsViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.text = UserDefaultsPersistance.shared.firstName
        lastNameTextField.text = UserDefaultsPersistance.shared.lastName
    }
    
    
    @IBAction func addNewFirstName(_ sender: Any) {
        UserDefaultsPersistance.shared.firstName = firstNameTextField.text
    }
    
    @IBAction func addNewLastName(_ sender: Any) {
        UserDefaultsPersistance.shared.lastName = lastNameTextField.text
    }
    
}
