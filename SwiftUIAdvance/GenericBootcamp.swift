//
//  GenericBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 5/7/25.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    func removeInfor() -> GenericModel {
        GenericModel(info: nil)
    }
}

struct GenericView<T: View>: View {
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

class GenericViewModel: ObservableObject {
    @Published var genericModel = GenericModel(info: "khanh")
    @Published var genericModelBool = GenericModel(info: false)
    
    
    func removeData() {
        genericModel = genericModel.removeInfor()
        genericModelBool = genericModelBool.removeInfor()
    }
}



struct GenericBootcamp: View {
    @StateObject private var viewModel = GenericViewModel()
    var body: some View {
        VStack {
            GenericView(content: Text("Khanh new"), title: "Generic view")
            Text(viewModel.genericModel.info ?? "no data")
            Text(viewModel.genericModelBool.info?.description ?? "no data")
        }.onTapGesture {
            viewModel.removeData()
        }
    }
        
}

#Preview {
    GenericBootcamp()
}
