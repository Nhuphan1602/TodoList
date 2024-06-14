//
//  ContentView.swift
//  TodoList
//
//  Created by Phan Tam Nhu on 14/6/24.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @State var selectedFilter = TaskFilter.NonCompleted
    
    var body: some View {
        NavigationView {
            VStack {
                DateScroller()
                    .padding()
                    .environmentObject(dateHolder)

                ZStack {
                    List {
                        ForEach(filteredTaskItem()) { taskItem in
                            NavigationLink(destination: TaskEditView(passedTaskItem: taskItem,
                                                                     initialDate: Date()).environmentObject(dateHolder)) {
                                TaskCellView(passedTaskItem: taskItem)
                                    .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Picker("", selection: $selectedFilter.animation()) {
                                ForEach(TaskFilter.allFilters, id: \.self) { filter in
                                    Text(filter.rawValue)
                                }
                            }
                        }
                    }
                    FloatingButtonView()
                        .environmentObject(dateHolder)
                }
            }
            .navigationTitle("To Do List")
        }
    }
    
    private func filteredTaskItem() -> [TaskItem] {
        if selectedFilter == TaskFilter.Completed {
            return dateHolder.taskItems.filter{ $0.isCompleted() }
        }
        if selectedFilter == TaskFilter.NonCompleted {
            return dateHolder.taskItems.filter{ !$0.isCompleted() }
        }
        if selectedFilter == TaskFilter.Overdue {
            return dateHolder.taskItems.filter{ $0.isOverdue() }
        }
        return dateHolder.taskItems
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredTaskItem()[$0] }.forEach(viewContext.delete)
            dateHolder.saveContext(viewContext)
        }
    }
}

#Preview {
    TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
