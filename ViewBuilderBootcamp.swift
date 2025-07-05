//
//  ViewBuilderBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 5/7/25.
//

import SwiftUI

struct CustomeHStach<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: ()->Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}
// actually all the component we already using in SwiftUI that is viewBuilder
// Viewbuilder will help you can basiclly create clouse in initialer of any view of your views, super powerfully for you to start customize
struct ViewBuilderBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        CustomeHStach {
            Text("Custome HS tack with viewBuilder")
        }
    }
}

#Preview {
    ViewBuilderBootcamp()
}
