//
//  ViewController.swift
//  ClearDo
//
//  Created by Oksana on 25.11.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
//    var itemArray = [String]()
    var itemArray = ["New"]
    var newToDo: String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTapGesture()
        
    }
    
    func configureTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TodoListViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
        
        let doubleTapgesture = UITapGestureRecognizer(target: self, action: #selector(TodoListViewController.doubleTapped))
        doubleTapgesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapgesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func doubleTapped() {
        itemArray.append("")
        tableView.reloadData()
    }
    
    // TableView data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ReusableCell
        cell.delegate = self
        
//        print("\(itemArray[indexPath.row])")
        return cell
        
        
    }


////     Table view delegate methods
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
}


extension TodoListViewController: UITextFieldDelegate {
    
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//    }
    

    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("Did end editing")
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
//    let textFieldIndex =
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newToDo = textField.text ?? ""
        if newToDo == "" {
            textField.resignFirstResponder()
        } else {
            print("\(newToDo)")
            itemArray.append(newToDo)
        }
        //textField.becomeFirstResponder()
        tableView.reloadData()
        return true
    }
}

