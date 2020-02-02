//
//  TasksViewController.swift
//  ClearDo
//
//  Created by Oksana on 14.01.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController {

    var taskArray = [String]()
    var fakeTaskArray = [String]()
    var addTaskButton = AddButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAction()
        buttonConstraints()

    }
    //    MARK: - Add Button
    func buttonConstraints() {
        view.addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26).isActive = true
        addTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -26).isActive = true
        addTaskButton.widthAnchor.constraint(equalToConstant: 66).isActive = true
        addTaskButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    func buttonAction() {
        addTaskButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        defer {
            tableView.reloadData()
        }
        guard fakeTaskArray.isEmpty else { return }
        fakeTaskArray.append("")
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let  off = scrollView.contentOffset.y
        addTaskButton.frame = CGRect(x: 285, y:   off + 485, width: addTaskButton.frame.size.width, height: addTaskButton.frame.size.height)
    }

    //    MARK: - Tap on the view hides keyboard
    func configureTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TasksViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
        tableView.reloadData()
    }
    
        // MARK: - TableView data source methods
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            2
        }
        
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return taskArray.count
            }
            return fakeTaskArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
            cell.taskCreationDelegate = self
            return cell
        }

    }

    // MARK: - Extensions

extension TasksViewController: TaskCreationable {
    
        func didFinishEnteringTask(_ task: String) {
            taskArray.append(task)
            tableView.reloadData()
            }
        func didCancelEnteringTask() {
            fakeTaskArray.removeAll()
            tableView.reloadData()
            }
        }
