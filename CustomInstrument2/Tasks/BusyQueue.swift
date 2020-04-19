//
//  BusyQueue.swift
//  CustomInstrument2
//
//  Created by Marin Todorov on 4/19/20.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import Foundation
import TimelaneCore

@propertyWrapper public class BusyQueue {
    @Published private var value: [Task]
    private let threshold: Int
    
    let subscription: Timelane.Subscription
    
    // Wrap the original queue
    public var wrappedValue: [Task] {
        get { self.value }
        set {
            if newValue.count >= threshold && self.value.count < threshold {
                subscription.begin()
            } else if newValue.count < threshold && self.value.count >= threshold {
                subscription.end(state: .completed)
            }
            if newValue.count >= threshold {
                subscription.event(value: .value("\(newValue.count)"))
            }
            self.value = newValue
        }
    }
    
    public init(wrappedValue: [Task], threshold: Int, name: String) {
        self.value = wrappedValue
        self.threshold = threshold
        self.subscription = Timelane.Subscription(name: name)
    }
}
