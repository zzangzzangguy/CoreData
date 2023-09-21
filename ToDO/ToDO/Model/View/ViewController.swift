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
    var viewModel: TaskListViewModel!
//    var selectedSection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
        
    }
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
            navigationItem.rightBarButtonItem = addButton

        }
        func setupViewModel() {
            viewModel = TaskListViewModel(coreDataManager: coreDataManager)
            viewModel.loadData()
        }
    
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
                self?.viewModel.addTask(title: taskTitle, section: sectionTitle)
                self?.tableView.reloadData()
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
        return viewModel.numberOfSections
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .destructive, title: "삭제합니두") { [weak self] (action, view, completionHandler) in
//               guard let self = self else { return }
//
//            let sectionTitle = self.viewModel.sectionTitles[indexPath.section]
//            var itemsInSection = self.viewModel.getSectionedItems()[sectionTitle] ?? []
//
//               // 선택된 셀에 해당하는 할 일 객체를 가져옵니다.
//               if itemsInSection.indices.contains(indexPath.row) {
//                   let taskToDelete = itemsInSection[indexPath.row]
//
//                   // Core Data에서 데이터를 삭제
//                   self.viewModel.deleteTask(at: indexPath)
//
//                   // UI에서 셀을 삭제
//                   itemsInSection.remove(at: indexPath.row)
//
//                   // sectionedItems 딕셔너리를 업데이트합니다.
//                   self.viewModel.sectionItems[sectionTitle] = itemsInSection
//
//                   tableView.deleteRows(at: [indexPath], with: .fade)
//
//                   completionHandler(true)
//               } else {
//                   completionHandler(false)
//               }
//           }
//
//           // 스와이프 동작 구성
//           let configuration = UISwipeActionsConfiguration(actions: [delete])
//           return configuration
//       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let task = viewModel.task(at: indexPath) {
                   cell.textLabel?.text = task.title
               }
               
               return cell
           }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = viewModel.task(at: indexPath) {
            print("Selected task: \(task.title ?? "")")
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let delete = UIContextualAction(style: .destructive, title: "삭제합니두") { [weak self] (action, view, completionHandler) in
               guard let self = self else { return }

               let sectionTitle = self.viewModel.sectionTitles[indexPath.section]
               var itemsInSection = self.viewModel.getSectionedItems()[sectionTitle] ?? []

               // 선택된 셀에 해당하는 할 일 객체를 가져옵니다.
               if itemsInSection.indices.contains(indexPath.row) {
                   let taskToDelete = itemsInSection[indexPath.row]

                   // Core Data에서 데이터를 삭제
                   self.viewModel.deleteTask(at: indexPath)

                   // UI에서 셀을 삭제
                   itemsInSection.remove(at: indexPath.row)

                   // sectionedItems 딕셔너리를 업데이트합니다.
                   self.viewModel.sectionedItems[sectionTitle] = itemsInSection

                   tableView.deleteRows(at: [indexPath], with: .fade)

                   completionHandler(true)
               } else {
                   completionHandler(false)
               }
           }

           // 스와이프 동작 구성
           let configuration = UISwipeActionsConfiguration(actions: [delete])
           return configuration
       }
   }
