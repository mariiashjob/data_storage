//
//  TaskCell.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 08.11.2022.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var table: UITableView? = nil
    var isTaskNeededToDelete = false
    var id: Int? = nil
    
    private let cornerRadius: CGFloat = 5
    
    override func awakeFromNib() {
        deleteButton.alpha = 0
        taskNameLabel.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isSelected {
            deleteButton.alpha = 1
            taskNameLabel.backgroundColor = .darkGray
            taskNameLabel.layer.masksToBounds = true
            deleteButton.layer.cornerRadius = cornerRadius
            taskNameLabel.layer.cornerRadius = cornerRadius
        } 
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        guard let tableView = table , let id = id else { return }
        let tasks = RealmPersistance.getTasksById(id)
        for task in tasks {
            if isTaskNeededToDelete {
                RealmPersistance.delete(task: task)
            }
        }
        tableView.reloadData()
        tableView.layoutSubviews()
        for cell in tableView.visibleCells {
            cell.awakeFromNib()
        }
    }
}
