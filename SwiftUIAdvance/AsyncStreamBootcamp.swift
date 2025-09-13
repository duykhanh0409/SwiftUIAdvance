//
//  AsyncStreamBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 24/8/25.
//

import SwiftUI

class AsyncStreamDataManager {
    
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream { [weak self] continuation in
            self?.getFakeData { value in
                continuation.yield(value)
            } onFinished: { error in
                continuation.finish(throwing: error)
            }
        }
    }
        
    func getFakeData(newValue: @escaping(_ value:Int) -> Void, onFinished: @escaping(_ error: Error?)-> Void) {
        let items:[Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item)) {
                newValue(item)
                if item == items.last! {
                    onFinished(nil)
                }
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
            do {
                for try await value in manager.getAsyncStream() {
                    currentNumber = value
                }
            }catch {
                print(error)
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
