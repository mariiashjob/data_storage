//
//  CoreDataTasksViewController.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 10.11.2022.
//

import Foundation
import UIKit

class CoreDataTasksViewController: UIViewController {
    
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    private var allTasks: Int {
        return CoreDataClient.allTasks.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        if let newTaskName = newTaskTextField.text {
            CoreDataClient.addTask(id: 0, title: newTaskName)
            newTaskTextField.text = nil
            table.reloadData()
            table.layoutSubviews()
            for cell in table.visibleCells {
                cell.awakeFromNib()
            }
        }
    }
}

extension CoreDataTasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataTaskCell", for: indexPath) as! CoreDataTaskCell
        let tasks = CoreDataClient.allTasks
        let task = tasks[indexPath.row]
        task.id = Int64(indexPath.row)
        CoreDataClient.saveContext()
        if let taskName = task.title {
            cell.taskNameLabel.text = " \u{2022} \(taskName)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CoreDataTaskCell else {
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
