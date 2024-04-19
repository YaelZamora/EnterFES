//
//  QRGenerateView.swift
//  EnterFES
//
//  Created by Yael Javier Zamora Moreno on 29/05/23.
//

import SwiftUI
import CodeScanner

struct QRGenerateView: View {
    @State private var numeroCuenta = ""
    @State private var isShowingScanner = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(hex: 0xff202c56, alpha: 1).ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("Ingresa tu número de cuenta").foregroundColor(.white).font(.title)
                    TextField("", text: $numeroCuenta).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 200)
                    Button{
                        //
                    } label: {
                        Text("Generar Código").padding()
                            .background(Color(hex: 0xffac965a, alpha: 1))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Image(uiImage: UIImage(data: getQRCodeDate(text: numeroCuenta)!)!)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer()
                    HStack {
                        Image("blanco").resizable().frame(width: 80, height: 80)
                        Spacer()
                        Button{
                            isShowingScanner = true
                        } label: {
                            Text("Scan code").padding().background(.ultraThinMaterial).cornerRadius(10).foregroundColor(.white)
                        }
                    }.padding(.horizontal, 40)
                }
            }
        }
        .sheet(isPresented: $isShowingScanner){
            CodeScannerView(codeTypes: [.qr], simulatedData: numeroCuenta, completion: handleScan)
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
    
    func getQRCodeDate(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        
        return uiimage.pngData()!
    }
}

struct QRGenerateView_Previews: PreviewProvider {
    static var previews: some View {
        QRGenerateView()
    }
}
