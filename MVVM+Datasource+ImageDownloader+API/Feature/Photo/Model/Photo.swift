//
//  Photo.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

struct Photo :Codable{
    
    let albumId:Int
    let id:Int
    let title:String
    let url :String
    let thumbnailUrl:String

    
}
