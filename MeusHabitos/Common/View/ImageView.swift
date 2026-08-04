//
//  ImageView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 04/08/26.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @State private var image: UIImage = UIImage()
    @ObservedObject var imageLoader = ImageLoader()
    
    let url: String
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
            .onAppear {
                if image.cgImage == nil {
                    imageLoader.load(url: url)
                }
            }
    }
}

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject< Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init() { }
    
    func load(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                
                self.data = data
                
            }
            
        }
        
        task.resume()
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "http://google.com")
    }
}

