//
//  BackgroundThreadBootcamp.swift
//  Multi-Threading-SwiftfulThinking
//
//  Created by Brian McIntosh on 1/28/23.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async { //userInitiated sparingly, utility most common
            let newData = self.downloadData()
            
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
        // Useful for testing:
        // Thread.isMainThread
        // Thread.current
    }
    
    // this is where you'd normally make a network request
    // but just create some fake data for now
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        print(data)
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject private var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        print("hello")
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
