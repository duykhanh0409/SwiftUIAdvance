 //
//  CustomBindingAdvance.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 13/9/25.
//

import SwiftUI

extension Binding where Value == Bool {

    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }

    }
}

struct CustomBindingAdvance: View {
    @State var title: String = "Khanh"
    
    @State private var errorTitle: String? = nil
    var body: some View {
        VStack {
            Text(title)
            ChildView(title: $title)
            ChildView3(title: $title)
                
            Button("CLICK ME") {
                errorTitle = "New error"
            }

        }
        .alert(
            errorTitle ?? "error",
            isPresented: Binding(value: $errorTitle)) {
                Button("Oke"){
                    
                }
            }
//        .alert(
//            errorTitle ?? "error",
//            isPresented: Binding(get: {
//                errorTitle != nil
//            }, set: { newValue in
//                if !newValue {
//                    errorTitle = nil
//                }
//            })) {
//                Button("Oke"){
//                    
//                }
//            }
        
    }
}

struct ChildView: View {
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onAppear {
//                title = "Hello"
            }
    }
}

struct ChildView3: View {
    
    let title:Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear() {
                title.wrappedValue = "Hello ChildView3"
            }
    }
}

#Preview {
    CustomBindingAdvance()
}
