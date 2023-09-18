//
//  CoreDataManager.swift
//  ToDO
//
//  Created by 김기현 on 2023/09/19.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Create
    func createTask(title: String, isCompleted: Bool) {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.title = title
        newTask.createDate = Date()
        newTask.modifyDate = Date()
        newTask.isCompleted = isCompleted
        
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    // Read
    func fetchTasks() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    // Update
    func updateTask(_ task: Task, newTitle: String, isCompleted: Bool) {
        task.title = newTitle
        task.modifyDate = Date()
        task.isCompleted = isCompleted
        
        do {
            try context.save()
        } catch {
            print("Update failed: \(error)")
        }
    }
    
    // Delete
    func deleteTask(_ task: Task) {
        context.delete(task)
        
        do {
            try context.save()
        } catch {
            print("Delete failed: \(error)")
        }
    }
}
