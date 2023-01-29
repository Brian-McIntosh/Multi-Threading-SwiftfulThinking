# Multi-Threading-SwiftfulThinking

### Open Debug Navigator > CPU while running in Simulator to view threads

<img src="https://github.com/Brian-McIntosh/Multi-Threading-SwiftfulThinking/blob/main/images/Screen%20Shot%202023-01-28%20at%207.19.57%20PM.png" width="500"/>

<img src="https://github.com/Brian-McIntosh/Multi-Threading-SwiftfulThinking/blob/main/images/Screen%20Shot%202023-01-28%20at%207.27.21%20PM.png" width="900"/>

### Other thread options (author uses utility most often)

<img src="https://github.com/Brian-McIntosh/Multi-Threading-SwiftfulThinking/blob/main/images/Screen%20Shot%202023-01-28%20at%207.50.09%20PM.png" width="700"/>

Misc. notes:
* class ViewModel
* ObservableObject
* @Published
* @StateObject
```swift
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
```
