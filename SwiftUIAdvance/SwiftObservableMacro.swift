//
//  SwiftObservableMacro.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 17/8/25.
//

import SwiftUI

@Observable
class CounterModel {
    var count = 0
}

struct SwiftObservableMacro: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink("Go to Counter (with @State)") {
                    CounterWithStateView(model: CounterModel()) // 👈 fresh instance
                }
                
            }
            .navigationTitle("Home")
            .padding()
        }
    }
}

// MARK: - Counter View (using @State)
struct CounterWithStateView: View {
    @State private var model: CounterModel
    
    init(model: CounterModel) {
        _model = State(initialValue: model)
    } // not reset data when goback and navigate again
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Counter with @State")
                .font(.headline)
            
            Text("Count: \(model.count)")
                .font(.largeTitle)
            
            Button("Increment") {
                model.count += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

//// MARK: - Counter View (using @StateObject)
//struct CounterWithStateObjectView: View {
//    @StateObject private var model = CounterModel()   // 👈 persists across recreations
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Counter with @StateObject")
//                .font(.headline)
//            
//            Text("Count: \(model.count)")
//                .font(.largeTitle)
//            
//            Button("Increment") {
//                model.count += 1
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .padding()
//    }
//}

#Preview {
    SwiftObservableMacro()
}
