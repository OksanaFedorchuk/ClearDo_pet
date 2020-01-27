//
//  TasksViewController.swift
//  ClearDo
//
//  Created by Oksana on 14.01.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController {
    
    var taskArray = ["Task"]
    var newTask: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.delegate = self
        return cell
    }
}

extension TasksViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newTask = textField.text ?? ""
        if newTask == "" {
            textField.resignFirstResponder()
        } else {
            print("\(newTask)")
            taskArray.append(newTask)
        }
        tableView.reloadData()
        return true
    }
}
