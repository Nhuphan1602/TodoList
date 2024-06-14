//
//  DateScroller.swift
//  TodoList
//
//  Created by Phan Tam Nhu on 14/6/24.
//

import SwiftUI

struct DateScroller: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: moveBack) {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .font(Font.title.weight(.medium))
            }
            
            Text(dateFormatter())
                .font(.title)
                .bold()
                .animation(.none)
                .frame(maxWidth: .infinity)
            
            Button(action: moveForward) {
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .font(Font.title.weight(.medium))
            }
        }
    }
    
    func dateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL yy"
        return dateFormatter.string(from: dateHolder.date)
    }
    
    func moveBack() {
        withAnimation {
            dateHolder.moveDate(-1, viewContext)
        }
    }
    
    func moveForward() {
        withAnimation {
            dateHolder.moveDate(1, viewContext)
        }
    }
}

#Preview {
    DateScroller()
}
