//
//  NetworkingClient.swift
//  SwiftUI_ScrollableList
//
//  Created by Emre Dogan on 25/07/2022.
//

import Foundation
import FirebaseStorage
import SwiftUI
import Kingfisher
import UIKit

class NetworkingClient {
    private var imageSizeString = "test"
    let numberOfPicturesToDownload = 4

    var urlArray = [URL]()
    var images = [UIImage]()

    
    typealias CompletionHandlerURL = (Result<[URL], Error>) -> Void
    typealias CompletionHandlerImage = (Result<[UIImage], Error>) -> Void


    func execute(completionHandler: @escaping CompletionHandlerURL){
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to download
        let imagesRef = storageRef.child(imageSizeString)
        imagesRef.listAll(completion: { result, error in
            if error != nil {
                print(error ?? "Error while getting the reference")
                return
            }
            let referenceURI = result!.items
            
            for reference in referenceURI {
                // Fetch the download URL
                print(reference)

               reference.downloadURL { url, error in
                    if let error = error {
                        // Handle any errors
                        print(error)
                    } else {
                        if let url = url {
                            self.urlArray.append(url)
                            if(self.urlArray.count == self.numberOfPicturesToDownload) {
                                completionHandler(.success(self.urlArray))
                                return
                            }
                        }
                    }
                }
            }
            
        })
    }
    
    func retrieveImage(element: URL, currentSize: Int, completionHandler: @escaping CompletionHandlerImage) {
        let resource = ImageResource(downloadURL:element)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { [weak self] result in
            switch result {
            case .success(let value):
                self?.images.append(value.image)
                completionHandler(.success(self!.images))
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
}
