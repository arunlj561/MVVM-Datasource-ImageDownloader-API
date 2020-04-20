//
//  PhotoViewModel.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class PhotoViewModel {
    
    
    var photoData :Box<[Photo]> = Box([])
    var error : Box<Error?> = Box(nil)
    
    init() {
        self.getPhotosDataSource()
    }
    
    // get image url
    func getImageUrl(_ indexPath:IndexPath) -> URL?{
        if indexPath.row < self.photoData.value.count{
            return URL(string: self.photoData.value[indexPath.row].thumbnailUrl)
        }
        return nil
    }
    
    // fetch Phots from API
    func getPhotosDataSource() {
        ServiceManager.sharedInstance.getPhotos { (result) in
            switch result {
            case .success(let photos):
                self.photoData.value = photos                
            case .failure(let error): self.error.value = error
            }
        }
    }
}


