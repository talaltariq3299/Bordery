//
//  CustomPhotoAlbum.swift
//  Bordery
//
//  Created by Kevin Laminto on 18/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Photos
import UIKit

// from https://stackoverflow.com/questions/28708846/how-to-save-image-to-custom-album
class CustomPhotoAlbum: NSObject {
    static let albumName = "Bordery"
    static let shared = CustomPhotoAlbum()
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    private var assetCollection: PHAssetCollection!
    
    private override init() {
        super.init()
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
    }
    
    private func checkAuthorizationWithHandler(completion: @escaping ((_ success: Bool) -> Void)) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.checkAuthorizationWithHandler(completion: completion)
            })
        }
        else if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.createAlbumIfNeeded { (success) in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
                
            }
            
        }
        else {
            completion(false)
        }
    }
    
    private func createAlbumIfNeeded(completion: @escaping ((_ success: Bool) -> Void)) {
        if let assetCollection = fetchAssetCollectionForAlbum() {
            // Album already exists
            self.assetCollection = assetCollection
            completion(true)
        } else {
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)   // create an asset collection with the album name
            }) { success, error in
                if success {
                    self.assetCollection = self.fetchAssetCollectionForAlbum()
                    completion(true)
                } else {
                    // Unable to create album
                    completion(false)
                }
            }
        }
    }
    
    private func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }
    
    func save(image: UIImage, completion: @escaping (Bool) -> Void) {
        self.checkAuthorizationWithHandler { (success) in
            if success, self.assetCollection != nil {
                PHPhotoLibrary.shared().performChanges({
                    let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                    if let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection) {
                        let enumeration: NSArray = [assetPlaceHolder!]
                        albumChangeRequest.addAssets(enumeration)
                    }

                }, completionHandler: { (success, error) in
                    if success {
                        print("Successfully saved image to Camera Roll.")

                    }
                    else {
                        print("Error writing to image library: \(error!.localizedDescription)")
                    }
                    completion(success) // here!
                })

            } else {
                completion(false) // and here!
            }
        }
    }

    
    func saveMovieToLibrary(movieURL: URL) {
        
        self.checkAuthorizationWithHandler { (success) in
            if success, self.assetCollection != nil {
                
                PHPhotoLibrary.shared().performChanges({
                    
                    if let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: movieURL) {
                        let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                        if let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection) {
                            let enumeration: NSArray = [assetPlaceHolder!]
                            albumChangeRequest.addAssets(enumeration)
                        }
                        
                    }
                    
                }, completionHandler:  { (success, error) in
                    if success {
                        print("Successfully saved video to Camera Roll.")
                    } else {
                        print("Error writing to movie library: \(error!.localizedDescription)")
                    }
                })
                
                
            }
        }
        
    }
}
