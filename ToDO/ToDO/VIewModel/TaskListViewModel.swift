//
//  TaskListViewModel.swift
//  ToDO
//
//  Created by 김기현 on 2023/09/21.
//

import Foundation
import CoreData

class TaskListViewModel {
    private let coreDataManager: CoreDataManager
    private var tasks: [Task] = []
    internal var sectionedItems: [String: [Task]] = [:]
   

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    var numberOfSections: Int {
        return sectionTitles.count
    }
    
    var sectionTitles: [String] {
        return ["운동","일","생활"]
    }
    func loadData() {
        tasks = coreDataManager.fetchTasks()
        sectionedItems.removeAll()
        
        for section in sectionTitles {
            let tasksInSection = tasks.filter { $0.section == section }
            sectionedItems[section] = tasksInSection
        }
    }
    
    func taskCount(for section: Int) -> Int {
        let sectionTitle = sectionTitles[section]
        return tasks.filter { $0.section == sectionTitle }.count
    }
    func task(at indexPath: IndexPath) -> Task? {
        let sectionTitle = sectionTitles[indexPath.section]
          if let tasksInSection = sectionedItems[sectionTitle], indexPath.row < tasksInSection.count {
              return tasksInSection[indexPath.row]
          }
          return nil
      }
    
    func addTask(title: String, section: String) {
        coreDataManager.createTask(title: title, isCompleted: false, section: section)
        loadData()
    }
    func deleteTask(at indexPath: IndexPath) {
        if let task = task(at: indexPath) {
            coreDataManager.deleteTask(task)
            loadData()
        }
    }
            
    func getSectionedItems() -> [String: [Task]] {
            return sectionedItems
        }
    }
