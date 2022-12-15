//
//  ImageGeneratorView.swift
//  ImageGenerator
//
//  Created by Gokul Nair on 15/12/22.
//

import SwiftUI

struct ImageGeneratorView: View {
    
    @ObservedObject var viewModel = ImageGeneratorViewModel()
    @State var text = ""
    @State var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .cornerRadius(10)
                }else {
                   Text("Sorry we couldn't generate the image!")
                }
                
                Spacer()
                
                TextField("Enter param", text: $text)
                    .padding()
                
                Button {
                   generateImage()
                }label: {
                    Text("Generate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 60)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
            }.onAppear{
                viewModel.setup()
            }
            
            .navigationTitle(Text("Omega"))
        }
    }
    
    func generateImage() {
        if !text.trimmingCharacters(in: .whitespaces).isEmpty {
            Task {
                let result = await viewModel.generateImage(prompt: text)
                self.image = result
            }
        }
    }
}

struct ImageGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGeneratorView()
    }
}
