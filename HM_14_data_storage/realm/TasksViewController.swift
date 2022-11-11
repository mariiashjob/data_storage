//
//  TasksViewController.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 08.11.2022.
//

import Foundation
import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    private var countTasks: Int {
        return RealmPersistance.getObjects().count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        if let newTaskName = newTaskTextField.text  {
            RealmPersistance.add(id: countTasks + 1, title: newTaskName)
            newTaskTextField.text = nil
            table.reloadData()
            table.layoutSubviews()
            for cell in table.visibleCells {
                cell.awakeFromNib()
            }
        }
    }
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let tasks = RealmPersistance.getObjects()
        let task = tasks[indexPath.row]
        try! RealmPersistance.realm.write {
            task.id = indexPath.row
        }
        cell.taskNameLabel.text = " \u{2022} \(task.title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TaskCell else {
            return
        }
        cell.id = indexPath.row
        cell.table = tableView
        cell.isTaskNeededToDelete = true
        for cell in tableView.visibleCells {
            if !cell.isSelected {
                cell.awakeFromNib()
            } else {
                cell.layoutSubviews()
            }
        }
    }
}
