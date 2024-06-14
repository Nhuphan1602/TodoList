//
//  TaskFilterView.swift
//  TodoList
//
//  Created by Phan Tam Nhu on 14/6/24.
//

import SwiftUI

enum TaskFilter: String {
    static var allFilters: [TaskFilter] {
        return [.NonCompleted, .Completed, .Overdue, .All]
    }
    
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case Overdue = "Overdue"
}
