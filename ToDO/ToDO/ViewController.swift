//
//  ViewController.swift
//  ToDO
//
//  Created by 김기현 on 2023/08/23.
//

//
import UIKit
import CoreData
import SnapKit

class ViewController: UIViewController {

    let coreDataManager = CoreDataManager.shared
    
    var tableView: UITableView!
    
    var sectionedItems: [String: [Task]] = [:]
    
    let sectionTitles = ["운동", "일", "생활"]
    
    var selectedSection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Auto Layout 설정
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)

        }
    
        
        // 네비게이션 바에 추가 버튼 추가
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataFromCoreData()
    }
    
    private func loadDataFromCoreData() {
        let tasks = coreDataManager.fetchTasks()
        
        sectionedItems = Dictionary(grouping: tasks, by: { $0.section ?? "" })
        
        tableView.reloadData()
    }
    
    // 추가 버튼 눌렀을 때의 액션
    @objc func addTask() {
        let alertController = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "할 일 입력"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "섹션 입력 (운동, 일, 생활 중 하나)"
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            if let taskTitle = alertController.textFields?[0].text,
               let sectionTitle = alertController.textFields?[1].text {
                // Core Data에 할 일 추가
                self?.coreDataManager.createTask(title: taskTitle, isCompleted: false, section: sectionTitle)
                // 데이터를 다시 읽어와서 sectionedItems에 업데이트
                self?.loadDataFromCoreData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제합니두") { [weak self] (action, view, completionHandler) in
               guard let self = self else { return }
               
               let sectionTitle = self.sectionTitles[indexPath.section]
               var itemsInSection = self.sectionedItems[sectionTitle] ?? []
               
               // 선택된 셀에 해당하는 할 일 객체를 가져옵니다.
               if itemsInSection.indices.contains(indexPath.row) {
                   let taskToDelete = itemsInSection[indexPath.row]
                   
                   // Core Data에서 데이터를 삭제합니다.
                   self.coreDataManager.deleteTask(taskToDelete)
                   
                   // UI에서 셀을 삭제합니다.
                   itemsInSection.remove(at: indexPath.row)
                   
                   // sectionedItems 딕셔너리를 업데이트합니다.
                   self.sectionedItems[sectionTitle] = itemsInSection
                   
                   tableView.deleteRows(at: [indexPath], with: .fade)
                   
                   // completionHandler를 호출하여 스와이프 동작을 완료합니다.
                   completionHandler(true)
               } else {
                   // 실패한 경우 completionHandler를 호출하여 스와이프 동작을 취소합니다.
                   completionHandler(false)
               }
           }
           
           // 스와이프 동작 구성
           let configuration = UISwipeActionsConfiguration(actions: [delete])
           return configuration
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sectionTitles[section]
        return sectionedItems[sectionTitle]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let sectionTitle = sectionTitles[indexPath.section]
        if let tasksInSection = sectionedItems[sectionTitle], tasksInSection.indices.contains(indexPath.row) {
            let task = tasksInSection[indexPath.row]
            cell.textLabel?.text = task.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionTitle = sectionTitles[indexPath.section]
        if let tasksInSection = sectionedItems[sectionTitle], tasksInSection.indices.contains(indexPath.row) {
            let task = tasksInSection[indexPath.row]
            // 할 일을 선택한 경우의 동작 구현
            // 예: 수정 또는 완료 처리
            print("Selected task: \(task.title ?? "")")
        }
    }
}
