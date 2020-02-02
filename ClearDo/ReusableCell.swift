//
//  ReusableCell.swift
//  ClearDo
//
//  Created by Oksana on 03.12.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

protocol ItemCreationable {
    func didFinishEnetringItem(_ item: String)
    func didCancelEntering()
}

class ReusableCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var todoTextfield: UITextField!
        
    var itemDelegate: ItemCreationable?
    
        // Makes each new textfield a first responder when return is pressed
        override func awakeFromNib() {
            super.awakeFromNib()
            todoTextfield.delegate = self
            todoTextfield.becomeFirstResponder()
        }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = todoTextfield.text else { return true }
        if text.isEmpty {
            itemDelegate?.didCancelEntering()
        } else {
            itemDelegate?.didFinishEnetringItem(text)
            todoTextfield.becomeFirstResponder()
        }
        return true
    }

}

