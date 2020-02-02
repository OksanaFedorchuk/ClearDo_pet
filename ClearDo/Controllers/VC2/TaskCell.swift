//
//  TaskCell.swift
//  ClearDo
//
//  Created by Oksana on 14.01.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//

import UIKit

protocol TaskCreationable {
    func didFinishEnteringTask(_ task: String)
    func didCancelEnteringTask()
}

class TaskCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var taskTextField: UITextField!
    var taskCreationDelegate: TaskCreationable?
    
        // Makes each new textfield a first responder when return is pressed
        override func awakeFromNib() {
            super.awakeFromNib()
            taskTextField.delegate = self
            taskTextField.becomeFirstResponder()
        }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let task = taskTextField.text else { return true }
        if task.isEmpty {
            taskCreationDelegate?.didCancelEnteringTask()
        } else {
            taskCreationDelegate?.didFinishEnteringTask(task)
            taskTextField.becomeFirstResponder()
        }
        return true
    }
}

