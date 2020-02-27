//
//  ReusableCell.swift
//  ClearDo
//
//  Created by Oksana on 03.12.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit
import CoreData

protocol ProjectCreationable {
    func didFinishEnteringProject(_ project: Project)
    func didCancelEntering()
}

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectTextfield: UITextField!
        
    var projectCreationDelegate: ProjectCreationable?
    var project: Project?

    // Makes each new textfield a first responder when return is pressed
    override func awakeFromNib() {
        super.awakeFromNib()
        projectTextfield.delegate = self
    }
    

    func configureWith(_ project: Project) {
        self.project = project
        projectTextfield.text = self.project?.projectName
    }
}


extension ProjectCell: UITextFieldDelegate {

    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let textfieldText = projectTextfield.text else { return true }
        if textfieldText.isEmpty {
            projectCreationDelegate?.didCancelEntering()
        } else {
            if let project = project {
                project.projectName = textfieldText
                projectCreationDelegate?.didFinishEnteringProject(project)
            }
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
