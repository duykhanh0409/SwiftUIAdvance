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
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            self.image = UIImage(data: data)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcamp: View {
    @State private var viewModel = TaskBootcampViewModel()
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

#Preview {
    TaskBootcamp()
}
