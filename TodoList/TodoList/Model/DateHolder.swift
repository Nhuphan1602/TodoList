//
//  DateHelper.swift
//  TodoList
//
//  Created by Phan Tam Nhu on 14/6/24.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject {
    
    @Published var date = Date()
    @Published var taskItems: [TaskItem] = []
    
    let calendar: Calendar = Calendar.current
    
    init(_ context: NSManagedObjectContext) {
        refreshTaskItems(context)
    }
    
    func refreshTaskItems(_ context: NSManagedObjectContext) {
        taskItems = fetchTaskItem(context)
    }
    
    func moveDate(_ days: Int, _ context: NSManagedObjectContext) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refreshTaskItems(context)
    }
    
    func fetchTaskItem(_ context: NSManagedObjectContext) -> [TaskItem] {
        do {
            return try context.fetch(dailyTasksFetch()) as [TaskItem]
        } catch let error {
            fatalError("Unresolved error \(error)")
        }
    }

    func dailyTasksFetch() -> NSFetchRequest<TaskItem> {
        let request = TaskItem.fetchRequest()
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    
    private func sortOrder() -> [NSSortDescriptor] {
        let completedDateSort = NSSortDescriptor(keyPath: \TaskItem.completedDate, ascending: true)
        let timeShort = NSSortDescriptor(keyPath: \TaskItem.scheduleTime, ascending: true)
        let dueDateShort = NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)
        return [completedDateSort, timeShort, dueDateShort]
    }
    
    private func predicate() -> NSPredicate {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        return NSPredicate(format: "dueDate >= %@ AND dueDate <= %@ ", start as NSDate, end! as NSDate)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
            refreshTaskItems(context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
