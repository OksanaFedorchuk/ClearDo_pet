//
//  ViewController.swift
//  ClearDo
//
//  Created by Oksana on 25.11.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [String]()
//    var itemArray = ["New"]
    var newToDo: String = ""
    var addProjectButton = AddProjectButton()

    
    override func viewDidLoad() {
        buttonConstraints()
        buttonAction()
        super.viewDidLoad()
        configureTapGesture()
        
    }
    
    func buttonConstraints() {
        view.addSubview(addProjectButton)
        view.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func buttonAction() {
        addProjectButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        itemArray.append("")
        tableView.reloadData()
        print("Button tapped!")
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let  off = scrollView.contentOffset.y

           addProjectButton.frame = CGRect(x: 285, y:   off + 485, width: addProjectButton.frame.size.width, height: addProjectButton.frame.size.height)
    }
    
    func configureTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TodoListViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
        tableView.reloadData()
    }
    
    // MARK: - TableView data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ReusableCell
        cell.delegate = self
        return cell
        
        
    }
}


extension TodoListViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("Did end editing")
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newToDo = textField.text ?? ""
        if newToDo == "" {
            textField.resignFirstResponder()
        } else {
            print("\(newToDo)")
            itemArray.append(newToDo)
        }
        tableView.reloadData()
        return true
    }
}

