//
//  ViewController.swift
//  TODO App
//
//  Created by Darek on 15/10/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var addNewTaskViewController: AddNewTaskViewController?
    private lazy var newTaskSavedAlert: UIView = NewTaskSavedAlert()

    private lazy var taskTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private var tasks: [Task] = [] {
        didSet{
            taskTable.reloadData()
        }
    }
    
    private var addNewTaskButton: AddNewTaskButton = {
        let button = AddNewTaskButton(type: .system)
        button.addTarget(self, action: #selector(handleShowAddNewTask), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 50)
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .appLightBlue
        self.title = "Zadania:"
        
        configureAddNewTaskButton()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTaskAndReloadTable()
    }
    
    //MARK: - Alerts
    private func deleteTaskAlert(task: Task, completion: @escaping () -> Void){
        let alert = UIAlertController(title: "Usuwanie", message: "Czy napewno chcesz usunąć wybrane zadanie?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Usuń", style: .destructive, handler: { _ in
            CoreDataService.shared.deleteSpecyficTask(task: task) {[unowned self] in
                self.fetchTaskAndReloadTable()
                completion()
            }
        }))
        alert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { action in
            completion()
        }))
 
        self.present(alert, animated: true)
    }
    
    //MARK: - Helper functions
    private func configureAddNewTaskButton(){
        view.addSubview(addNewTaskButton)
        addNewTaskButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,  paddingBottom: 20, paddingRight: 20, width: 80, height: 80)
    }
    
    func fetchTaskAndReloadTable(){
        if let tasks =  CoreDataService.shared.fetchTasks()  {
            self.tasks = tasks
        }

    }
    
    // MARK: - Selectors
    @objc func handleShowAddNewTask(){
        let cv = AddNewTaskViewController()
        cv.delegate = self
        navigationController?.pushViewController(cv, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func configureTableView(){
        taskTable.delegate = self
        taskTable.dataSource = self
        taskTable.register(TaskTableCell.self, forCellReuseIdentifier: "taskTableCell")
        taskTable.rowHeight = 100
        taskTable.separatorStyle = .none
        taskTable.allowsSelection = false

        view.addSubview(taskTable)
        taskTable.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor , right: view.rightAnchor)
        view.bringSubviewToFront(addNewTaskButton)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.count == 0 {
            taskTable.setNoDataPlaceholder(title: "Brak zadań", subtitle: "Tutaj pojawią się zadania gdy zostaną dodane")
        } else {
            taskTable.removeNoDataPlaceholder()
        }
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTable.dequeueReusableCell(withIdentifier: "taskTableCell", for: indexPath) as! TaskTableCell
        cell.task = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = taskTable.cellForRow(at: indexPath) as! TaskTableCell
        
        //DeleteAction:
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, sourceView, completionHandler in
            guard let task = cell.task else { return }
            self.deleteTaskAlert(task: task) {
                completionHandler(true)
            }
        }
        let deleteImage = UIImage(named: "deleteActionIcon")
        deleteAction.image = deleteImage
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
}

extension HomeViewController: AddNewTaskViewControllerProtocol{
    func showNewTaskSavedAlert() {
        let alertHeight = 40.0
        view.addSubview(newTaskSavedAlert)
        newTaskSavedAlert.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: alertHeight)

        view.layoutIfNeeded()
        newTaskSavedAlert.frame.origin.y -= alertHeight

        UIView.animate(withDuration: 0.3) {
            self.newTaskSavedAlert.frame.origin.y += alertHeight
        } completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 3) {
                self.newTaskSavedAlert.frame.origin.y -= alertHeight
            } completion: { _ in
                self.newTaskSavedAlert.removeFromSuperview()
            }
        }
    }
}

