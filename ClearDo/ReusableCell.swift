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
        
    var delegate: UITextFieldDelegate? {
            didSet {
                todoTextfield.delegate = delegate
            }
        }
    
        // Makes each new textfield a first responder when return is pressed
        override func awakeFromNib() {
            super.awakeFromNib()
            todoTextfield.becomeFirstResponder()
        }
        
    
}
