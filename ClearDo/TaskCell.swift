//
//  TaskCell.swift
//  ClearDo
//
//  Created by Oksana on 14.01.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var taskTextField: UITextField!
    
    var delegate: UITextFieldDelegate? {
            didSet {
                taskTextField.delegate = delegate
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTextField.becomeFirstResponder()
    }

}
