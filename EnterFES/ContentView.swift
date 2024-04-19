//
//  ContentView.swift
//  EnterFES
//
//  Created by Yael Javier Zamora Moreno on 29/05/23.
//

import SwiftUI

extension Color{
    init(hex: UInt, alpha: Double = 1){
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha

        )
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                Color(hex: 0xffac965a, alpha: 1).ignoresSafeArea()
                VStack{
                    HStack{
                        Image("unam").resizable().frame(width: 150, height: 150)
                        Text("Universidad Nacional Autónoma de México").bold()
                    }
                    Spacer()
                    Text("Bienvenido!").font(.largeTitle).bold()
                    NavigationLink{
                        QRGenerateView()
                    } label: {
                        Text("Continuar").padding().background(.ultraThinMaterial).cornerRadius(10)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Image("swift").resizable().frame(width: 80, height: 80)
                    }
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
