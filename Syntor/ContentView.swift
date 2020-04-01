//
//  ContentView.swift
//  Syntor
//
//  Created by Евгений Плюснин on 30.03.2020.
//  Copyright © 2020 Evgenii Pliusnin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var station: Station
    
    var body: some View {
        List {
            ForEach(station.tasks) { task in
                TaskView(task: task)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        station.tasks.remove(atOffsets: offsets)
    }
}

struct TaskView: View {
    var task: Task
    var body: some View {
        HStack {
            Circle()
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading) {
                Text(task.name)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                
                Text("Параметры")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(station: testStation)
    }
}
