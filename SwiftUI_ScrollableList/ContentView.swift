//
//  ContentView.swift
//  SwiftUI_ScrollableList
//
//  Created by Emre Dogan on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
    let networkingClient = NetworkingClient()
    @State private var images: [UIImage] = []
    var body: some View {
        ScrollView(.vertical){
            LazyVStack(spacing: 0) {
                ForEach(images, id:\.self) {image in
                    HStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    }.listRowInsets(EdgeInsets())
                }
            }.listRowInsets(EdgeInsets())

            .onAppear {
                networkingClient.execute { result in
                    switch result {
                    case .success(let responsePosts):
                        self.networkingClient.urlArray = responsePosts
                        self.startMultipleImageDownload()
                    case .failure(let error):
                        print("ERROR - Getting data from the network client ", error)
                    }
                }
            }
        }
        
    }
    
    func startMultipleImageDownload() {
        print("Start3")

        let currentSize = networkingClient.images.count
        
        for (index, element) in networkingClient.urlArray.enumerated() {
            retrieveImage(element: element, currentSize: currentSize)
        }
    }
    
    func retrieveImage(element: URL, currentSize: Int) {
        networkingClient.retrieveImage(element: element, currentSize: currentSize) { result in
            switch result {
            case .success(let value):
                images = value
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
