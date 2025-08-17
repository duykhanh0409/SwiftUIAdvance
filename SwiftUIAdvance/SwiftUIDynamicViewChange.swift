//
//  SwiftUIDynamicViewChange.swift
//  BitMEXOrderBook
//
//  Created by Khanh Nguyen on 17/8/25.
//

import SwiftUI

struct SwiftUIDynamicViewChange: View {
    @State var count = 0
    @State var animateButton = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // because A SwiftUI view with many redraw triggers can be a pain. timer trigger UI update every second it will make the animation of button work not as expected
    var body: some View {
        VStack {
            Text("Count is now: \(count)!")
                .onReceive(timer) { input in
                    count += 1
                }
            AnimatedButton()
        }
    }
}

// we can resolve this to follow this one https://www.avanderlee.com/swiftui/debugging-swiftui-views/

// The timer no longer changes the rotation effect random value since SwiftUI is smart enough not to redraw our button for a count change.
struct AnimatedButton: View {
    @State var animateButton = true
    
    var body: some View {
        Button {
            
        } label: {
            Text("SAVE")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 80)
                .background(.red)
                .cornerRadius(50)
                .shadow(color: .secondary, radius: 1, x: 0, y: 5)
        }.rotationEffect(Angle(degrees: animateButton ? Double.random(in: -8.0...1.5) : Double.random(in: 0.5...16))).onAppear {
            withAnimation(.easeInOut(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                animateButton.toggle()
            }
        }
    }
}

#Preview {
    SwiftUIDynamicViewChange()
}
