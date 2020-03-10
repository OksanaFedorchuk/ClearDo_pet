//
//  ViewController.swift
//  ClearDo
//
//  Created by Oksana on 25.11.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit
import CoreData

class ProjectsViewController: UITableViewController {
    
    var taskEntities = [TaskEntity]()
    
    var tasks = [Task]()
    var fakeTasks = [Task]()
    var addProjectButton = AddButton()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonConstraints()
        buttonAction()
        configureTapGesture()
        loadProjects()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //    MARK: - Add Button
    private func buttonConstraints() {
        view.addSubview(addProjectButton)
        addProjectButton.translatesAutoresizingMaskIntoConstraints = false
        addProjectButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26).isActive = true
        addProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -26).isActive = true
        addProjectButton.widthAnchor.constraint(equalToConstant: 66).isActive = true
        addProjectButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    private func buttonAction() {
        addProjectButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        defer {
            reloadTableView()
        }
        guard fakeTasks.isEmpty else { return }
        fakeTasks.append(Task.empty())
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let  off = scrollView.contentOffset.y
        addProjectButton.frame = CGRect(x: 285, y:   off + 485, width: addProjectButton.frame.size.width, height: addProjectButton.frame.size.height)
    }
    
    
    //    MARK: - Tap on the view hides keyboard
    private func configureTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProjectsViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
        didCancelEntering()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Model Manipulation Methods
    
    func saveProjects() {
        
        do {
            try context.save()
        } catch {
            print("Error saving project \(error)")
        }
        tableView.reloadData()
    }
    
    func loadProjects() {

        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let sortingByDate = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortingByDate]
        do {
            taskEntities = try context.fetch(request)
            tasks = makeTaskFromTaskEntity(taskEntity: taskEntities)
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func makeProjectFrom(task: Task) -> TaskEntity {
        let entity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context)
        let newProject = TaskEntity(projectName: task.text, isDone: task.isDone, createdAt: task.createdAt, updatedAt: task.updatedAt, entity: entity!, insertIntoManagedObjectContext: context)
        return newProject
    }
    
    func makeTaskFromTaskEntity(taskEntity: [TaskEntity]) -> [Task] {
        taskEntity.map { Task(text: $0.projectName, createdAt: $0.createdAt ?? Date(), updatedAt: $0.updatedAt ?? Date()) }
    }

//    func editTask(taskEdited: Task) {
//        
//    }
    
}



// MARK: - TableView data source and delegate methods

extension ProjectsViewController {

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? tasks.count : fakeTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        if indexPath.section == 0 {
            let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell

            projectCell.configureWith(tasks[indexPath.row])
            projectCell.projectCreationDelegate = self
            cell = projectCell
        } else {
            let creationCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCreationCell", for: indexPath) as! ProjectCreationCell
            creationCell.configureWith(fakeTasks[indexPath.row])
            creationCell.projectCreationDelegate = self
            cell = creationCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            //put edited value here

        print("\(String(describing: tasks[indexPath.row].text))")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let creationCell = cell as? ProjectCreationCell else { return }
        creationCell.projectTextfield.becomeFirstResponder()
    }
}


// MARK: - ProjectCreationable
extension ProjectsViewController: ProjectCreationable {
    
    func didFinishEnteringProject(_ taskEntered: Task) {
        fakeTasks.removeAll()
        taskEntities.append(makeProjectFrom(task: taskEntered))
        saveProjects()
        loadProjects()
        fakeTasks.append(Task.empty())
        reloadTableView()
    }
    
    func didCancelEntering() {
        fakeTasks.removeAll()
        reloadTableView()
    }
}




