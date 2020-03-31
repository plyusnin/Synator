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
        .background(Color.gray.opacity(0.5))
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
                .opacity(0.5)
            
            VStack(alignment: .leading) {
                Text(task.name)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                
                Text("Параметры")
                    .font(.caption)
                    .opacity(0.625)
                
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
