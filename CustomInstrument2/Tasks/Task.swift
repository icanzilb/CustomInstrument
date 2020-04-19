//
//  Task.swift
//  CustomInstrument2
//
//  Created by Marin Todorov on 4/19/20.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import Foundation

public class Task: Equatable {
    public static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id: String
    
    public init(completion: @escaping (String)->Void) {
        self.id = UUID().uuidString
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            completion(self.id)
        }
    }
}
