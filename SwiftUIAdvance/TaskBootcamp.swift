//
//  TaskBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 21/9/25.
//

import SwiftUI

@Observable
class TaskBootcampViewModel {
    var image: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.image = UIImage(data: data)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Click me") {
                    TaskBootcamp()
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    @State private var viewModel = TaskBootcampViewModel()
//    @State private var fetchImageTask: Task<(), Never>? = nil
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        //Hiện tại SwiftUI support cách mới hay hơn là dùng task
//        action: A closure that SwiftUI calls as an asynchronous task
        ///     before the view appears. SwiftUI can automatically cancel the task
        ///     after the view disappears before the action completes. If the
        ///     `id` value changes, SwiftUI cancels and restarts the task.
        .task {
            await viewModel.fetchImage()
        }
        // Đây là manual way để handle fetch và cancel task
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            fetchImageTask = Task {
//                await viewModel.fetchImage()
//            }
//        }
    }
}

#Preview {
    TaskBootcampHomeView()
}
