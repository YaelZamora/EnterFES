//
//  ScanCodeView.swift
//  EnterFES
//
//  Created by Yael Javier Zamora Moreno on 29/05/23.
//

import CodeScanner
import SwiftUI

struct ScanCodeView: View {
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack{
            Button{
                isShowingScanner = true
            } label: {
                Label("Scan", systemImage: "qrcode.viewfinder")
            }
        }
        .sheet(isPresented: $isShowingScanner){
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\najedrezkasparov@gmail.com", completion: handleScan)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let nombre = details[0]
            print("Nombre: \(nombre)")
            
        case .failure(let error):
            print("Scannig failed: \(error.localizedDescription)")
        }
    }
}

struct ScanCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCodeView()
    }
}
