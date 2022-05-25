//
//  ContentView.swift
//  GorselYuklemee
//
//  Created by omer sanli on 25.05.2022.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ContentView: View {
    @State var butonaTiklandi: Bool = false
    @State var image: UIImage?
    
    var body: some View {
        VStack{
            Button {
                butonaTiklandi.toggle()
            } label: {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                }else{
                    Image(systemName: "person.circle")
                        .font(.system(size: 100))
                }
                
                
                
            }
            
            Button {
                if let image = image{
                    let data = image.jpegData(compressionQuality: 0.5)
                    let reference = Storage.storage().reference().child("\(UUID().uuidString).jpeg")
                    reference.putData(data!) { metadata, error in
                        if error == nil {
                            print("Başarılı bir şekilde Firestore Storage'a görseliniz yüklendi")
                            
                            reference.downloadURL { url, error in
                                print("Yükleme adresiniz \(url!)")
                            }
                            
                        }
                    }
                }
    
                
                
                
            } label: {
                Text("Fotoğrafı Firebase Storage'a aktar")
                    .font(.system(size: 25))
                    .padding()
            }

            

        }
        .fullScreenCover(isPresented: $butonaTiklandi) {
            ImagePicker(image: $image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
