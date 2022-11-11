//
//  CoreDataTask+CoreDataProperties.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 10.11.2022.
//
//

import Foundation
import CoreData


extension CoreDataTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataTask> {
        return NSFetchRequest<CoreDataTask>(entityName: "CoreDataTask")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?

}

extension CoreDataTask : Identifiable {

}
