//
//  ViewController.swift
//  ClearDo
//
//  Created by Oksana on 25.11.2019.
//  Copyright © 2019 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
    
    var projectArray = [String]()
    var fakeProjectArray = [String]()
    var addProjectButton = AddButton()

    
    override func viewDidLoad() {
        buttonConstraints()
        buttonAction()
        super.viewDidLoad()
        configureTapGesture()
        
    }
    
//    MARK: - Add Button
    func buttonConstraints() {
        view.addSubview(addProjectButton)
        addProjectButton.translatesAutoresizingMaskIntoConstraints = false
        addProjectButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26).isActive = true
        addProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -26).isActive = true
        addProjectButton.widthAnchor.constraint(equalToConstant: 66).isActive = true
        addProjectButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    func buttonAction() {
        addProjectButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton!) {
        defer {
            tableView.reloadData()
        }
        guard fakeProjectArray.isEmpty else { return }
        fakeProjectArray.append("")
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let  off = scrollView.contentOffset.y
        addProjectButton.frame = CGRect(x: 285, y:   off + 485, width: addProjectButton.frame.size.width, height: addProjectButton.frame.size.height)
    }
    
    
//    MARK: - Tap on the view hides keyboard
    func configureTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProjectsViewController.handleTap))
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
            return projectArray.count
        }
        return fakeProjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        cell.projectCreationDelegate = self
        return cell
    }

}

// MARK: - Extensions

extension ProjectsViewController: ProjectCreationable {
    func didFinishEnetringProject(_ project: String) {
        projectArray.append(project)
        tableView.reloadData()
    }
    
    func didCancelEntering() {
        fakeProjectArray.removeAll()
        tableView.reloadData()
    }
}
    



