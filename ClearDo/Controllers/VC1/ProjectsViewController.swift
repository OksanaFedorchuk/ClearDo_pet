//
//  ViewController.swift
//  ClearDo
//
//  Created by Oksana on 25.11.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
    
    var projectArray = [Task]()
    var fakeProjectArray = [Task]()
    var addProjectButton = AddButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonConstraints()
        buttonAction()
        configureTapGesture()
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
        guard fakeProjectArray.isEmpty else { return }
        fakeProjectArray.append(Task.empty())
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


}


// MARK: - TableView data source methods

extension ProjectsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? projectArray.count : fakeProjectArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell!
        if indexPath.section == 0 {
            let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
            projectCell.configureWith(projectArray[indexPath.row])
            projectCell.projectCreationDelegate = self
            cell = projectCell
        } else {
            let creationCell = tableView.dequeueReusableCell(withIdentifier: "ProjectCreationCell", for: indexPath) as! ProjectCreationCell
            creationCell.configureWith(fakeProjectArray[indexPath.row])
            creationCell.projectCreationDelegate = self
            cell = creationCell
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let creationCell = cell as? ProjectCreationCell else { return }
        creationCell.projectTextfield.becomeFirstResponder()
    }
}


// MARK: - ProjectCreationable
extension ProjectsViewController: ProjectCreationable {
    func didFinishEnteringProject(_ project: Task) {
        fakeProjectArray.removeAll()
        fakeProjectArray.append(Task.empty())
        projectArray.append(project)
        reloadTableView()
    }
    
    func didCancelEntering() {
        fakeProjectArray.removeAll()
        reloadTableView()
    }
}
    



