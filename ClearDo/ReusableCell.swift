//
//  ReusableCell.swift
//  ClearDo
//
//  Created by Oksana on 03.12.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell, UITextFieldDelegate {

    var delegate: UITextFieldDelegate? {
        didSet {
            todoTextfield.delegate = delegate
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        todoTextfield.delegate = self
        todoTextfield.becomeFirstResponder()
    }
    
    @IBOutlet weak var todoTextfield: UITextField!
    
    
}
