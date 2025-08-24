//
//  AsyncStreamBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 24/8/25.
//

import SwiftUI

class AsyncStreamDataManager {
    
    func getAsyncStream() -> AsyncStream<Int> {
        AsyncStream { continuation in
            self.getFakeData { value in
                continuation.yield(value)
            }
        }
    }
    
    func getFakeData(completion: @escaping(_ value:Int) -> Void) {
        let items:[Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item)) {
                completion(item)
            }
        }
    }
}

@MainActor
final class AsyncStreamViewModel: ObservableObject {
   let manager = AsyncStreamDataManager()
    @Published private(set) var currentNumber:Int = 0
    
    func onViewAppear() {
        Task {
            for await value in manager.getAsyncStream() {
                currentNumber = value
            }
        }
    }
}

struct AsyncStreamBootcamp: View {
    @StateObject private var viewModel = AsyncStreamViewModel()
    
    var body: some View {
        Text("\(viewModel.currentNumber)")
            .onAppear() {
                viewModel.onViewAppear()
            }
    }
}

#Preview {
    AsyncStreamBootcamp()
}
