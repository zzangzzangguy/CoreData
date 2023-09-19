//
//  ViewController.swift
//  ToDO
//
//  Created by 김기현 on 2023/08/23.
//

//
import UIKit
import CoreData

class ViewController: UIViewController {

    // Core Data 관리를 위한 매니저 인스턴스
    let coreDataManager = CoreDataManager.shared
    
    // 할 일 목록 테이블 뷰
    var tableView: UITableView!
    
    // 섹션별 할 일 목록
    var sectionedItems: [String: [Task]] = [:]
    
    // 섹션 헤더 제목 배열
    let sectionTitles = ["운동", "일", "생활"]
    
    // 선택된 섹션
    var selectedSection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 할 일 목록을 표시할 테이블 뷰 생성
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Auto Layout 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 네비게이션 바에 추가 버튼 추가
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Core Data에서 데이터를 읽어와 sectionedItems에 업데이트
        loadDataFromCoreData()
    }
    
    // Core Data에서 데이터를 읽어와 sectionedItems에 업데이트하는 함수
    private func loadDataFromCoreData() {
        // Core Data에서 할 일 목록을 가져옴
        let tasks = coreDataManager.fetchTasks()
        
        // 섹션별로 할 일을 구분하여 sectionedItems에 저장
        sectionedItems = Dictionary(grouping: tasks, by: { $0.section ?? "" })
        
        // 테이블 뷰 업데이트
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
