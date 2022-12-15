//
//  SplashScreenView.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var degree = 0.0
    
    var body: some View {
        ZStack {
            Color(UIColor.darkGray)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Image("anonymous")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                        .font(.system(size: 80))
                    Text("Random User")
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .rotationEffect(Angle.degrees(degree))
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                        self.degree = 360
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
    

