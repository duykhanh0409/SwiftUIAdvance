//
//  ViewModifierBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 13/9/25.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    // we need to thinking which property we actually need to put to viewModifier, example with padding maybe it different for each view, so we can remove it, and also for font
    
    var backgroundColor: Color
    func body(content: Content) -> some View {
        content
//            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
//            .padding()
    }
    
}

extension View {
    func withDefaultButtonStyle(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing:10) {
            Text("Hello, World!")
                .font(.headline)
                .withDefaultButtonStyle(backgroundColor: .blue)
            
            Text("Hello, khanh!")
                .font(.largeTitle)
                .modifier(DefaultButtonViewModifier(backgroundColor: .red))
            
            Text("Hello, xin chao!")
                .modifier(DefaultButtonViewModifier(backgroundColor: .gray))
            
            Text("Hello, xin chao!")
                .withDefaultButtonStyle()
        }
        .padding()
           
    }
}

#Preview {
    ViewModifierBootcamp() 
}
