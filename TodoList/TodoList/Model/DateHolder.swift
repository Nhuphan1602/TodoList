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
    
    let calendar: Calendar = Calendar.current
    
    func moveDate(_ days: Int, _ context: NSManagedObjectContext) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    init(_ context: NSManagedObjectContext) {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
