//
//  ReusableCell.swift
//  ClearDo
//
//  Created by Oksana on 03.12.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

protocol ProjectCreationable {
    func didFinishEnteringProject(_ project: String)
    func didCancelEntering()
}

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectTextfield: UITextField!
        
    var projectCreationDelegate: ProjectCreationable?
    
    // Makes each new textfield a first responder when return is pressed
    override func awakeFromNib() {
        super.awakeFromNib()
        projectTextfield.delegate = self
    }

    func configureWith(_ item: String) {
        projectTextfield.text = item
    }
}


extension ProjectCell: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = projectTextfield.text else { return true }
        if text.isEmpty {
            projectCreationDelegate?.didCancelEntering()
        } else {
            projectCreationDelegate?.didFinishEnteringProject(text)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
