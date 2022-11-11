//
//  RealmPersistance.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 08.11.2022.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
}

class RealmPersistance {
    
    static let shared = RealmPersistance()
    static let realm = try! Realm()
    
    static func add(id: Int, title: String) {
        try! realm.write {
            let task = Task()
            task.id = id
            task.title = title
            realm.add(task)
        }
    }
    
    static func delete(task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    static func getTasksById(_ id: Int) -> Results<Task> {
        return realm.objects(Task.self).filter("id == \(id)")
    }
    
    static func getTasks() -> [String] {
        var tasks: [String] = []
        for result in realm.objects(Task.self) {
            tasks.append(result.title)
        }
        return tasks
    }
    
    static func getObjects() -> Results<Task> {
        return realm.objects(Task.self)
    }
}
