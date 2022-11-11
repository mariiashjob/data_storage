//
//  CoreDataClient.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 10.11.2022.
//

import SwiftUI
import UIKit
import CoreData

class CoreDataClient {
    
    static let shared = CoreDataClient()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = appDelegate.persistentContainer.viewContext
    
    static var allTasks: [CoreDataTask] {
        let fetchRequest: NSFetchRequest<CoreDataTask>
        fetchRequest = CoreDataTask.fetchRequest()
        return try! context.fetch(fetchRequest)
    }
    
    static func saveContext() {
        appDelegate.saveContext()
    }
    
    static func addTask(id: Int64, title: String) {
        let task = CoreDataTask(context: context)
        task.id = id
        task.title = title
        saveContext()
    }
    
    static func deleteTask(_ task: CoreDataTask) {
        context.delete(task)
        saveContext()
    }
    
    static func getTaskById(_ id: Int64) -> CoreDataTask? {
        allTasks.first { task in
          return task.id == id
        }
    }
}
