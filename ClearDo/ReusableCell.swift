//
//  ReusableCell.swift
//  ClearDo
//
//  Created by Oksana on 03.12.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var todoTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTextFields()
    }
    
    private func configureTextFields() {
        todoTextfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
