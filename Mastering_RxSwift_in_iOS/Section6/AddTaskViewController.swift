//
//  AddTaskViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/16.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Task"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
            let textInput = titleTextField.text else {
            return
        }
        
        let task = Tasks(title: textInput, priority: priority)
        
        
    }

}
