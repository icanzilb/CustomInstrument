//
//  ViewController.swift
//  CustomInstrument2
//
//  Created by Marin Todorov on 4/19/20.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    // This is the task queue we'll profile in Timelane
    @BusyQueue(threshold: 18, name: "ViewController.taskQueue")
    var taskQueue = [Task]() {
        didSet {
            self.label.text = "Tasks \(self.taskQueue.count)"
            self.label.textColor = self.taskQueue.count >= 18 ? .red : .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Schedule some random tasks on the task queue to demonstrate
        // profiling the queue.
        for i in 0...24 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/3) {
                self.taskQueue.append(Task(completion: { id in
                    self.taskQueue.removeAll(where: { $0.id == id })
                }))
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/3 + 10) {
                self.taskQueue.append(Task(completion: { id in
                    self.taskQueue.removeAll(where: { $0.id == id })
                }))
            }
        }
    }
}
