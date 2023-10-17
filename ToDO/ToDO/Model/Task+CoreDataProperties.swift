//
//  Task+CoreDataProperties.swift
//  ToDO
//
//  Created by 김기현 on 2023/09/19.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var modifyDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var section: String?

}

extension Task : Identifiable {

}
