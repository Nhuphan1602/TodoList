//
//  FloatingButton.swift
//  TodoList
//
//  Created by Phan Tam Nhu on 14/6/24.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        Spacer()
        HStack {
            NavigationLink(destination: TaskEditView(passedTaskItem: nil, initialDate: Date()).environmentObject(dateHolder)) {
                Text("+ New Task")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
}

#Preview {
    FloatingButtonView()
}
