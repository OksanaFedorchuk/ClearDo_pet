//
//  ReusableCell.swift
//  ClearDo
//
//  Created by Oksana on 03.12.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit
//import CoreData

protocol ProjectCreationable {
    func didFinishEnteringProject(_ taskEntered: Task)
    func didCancelEntering()
}

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectTextfield: UITextField!
        
    var projectCreationDelegate: ProjectCreationable?
    var task: Task?

    // Makes each new textfield a first responder when return is pressed
    override func awakeFromNib() {
        super.awakeFromNib()
        projectTextfield.delegate = self
    }
    

    func configureWith(_ task: Task) {
        self.task = task
        projectTextfield.text = self.task?.text
    }
}


extension ProjectCell: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        false
    }

    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = projectTextfield.text else { return true }
        if text.isEmpty {
            projectCreationDelegate?.didCancelEntering()
        }
        else {
            if let task = task {
            task.text = text
            projectCreationDelegate?.didFinishEnteringProject(task)
                }
            }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
