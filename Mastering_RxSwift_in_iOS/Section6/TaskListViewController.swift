//
//  TaskListViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by pablo.jee on 2021/12/15.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var tasks = BehaviorRelay<[Tasks]>(value: [])
    private var filteredTasks:[Tasks] = []
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = "Task list"
        self.navigationItem.title = "My Task List"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addTaskVC = navC.viewControllers.first as? AddTaskViewController else {
                  return
              }
        addTaskVC.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
            
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            
            var temp = self.tasks.value
            temp.append(task)
            
            self.tasks.accept(temp)
            
            self.filterTask(priority: priority)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func priorityChanged(segmentedControl: UISegmentedControl) {
        
    }
    
    private func filterTask(priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
        } else {
            self.tasks.map { tasks in
                return tasks.filter { task in return task.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
            }).disposed(by: disposeBag)
        }
    }

}

extension TaskListViewController: UITableViewDelegate {
    
}

extension TaskListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        return cell
    }
}
