//
//  ServiceManager.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import Foundation

public enum ServiceResult<T> {
    case failure(Error)
    case success(T)
}



fileprivate enum ServiceParamType{
    case photo(String)
    
    var path:String{
        switch self {
        case .photo(_): return "photos"
        }
    }
    
    var url:URL?{
        switch self {
        case .photo(let base): return URL(string: base + self.path)    
        }
    }
    
}

class ServiceManager {
    
    private let baseUrl = "http://jsonplaceholder.typicode.com/"
    
    static let sharedInstance = ServiceManager()
    
    private init() {
    }
    
    func getPhotos(callback: @escaping (ServiceResult<[Photo]>) -> Void){
        guard let url = ServiceParamType.photo(baseUrl).url else {
            return
        }
        let task = URLSession.shared.dataTask(with: url ) { (data, response, error) in
            if let error = error{
                callback(.failure(error))
                return
            }
            guard let responseData = data else{
                return
            }
            do {
                let decoder = JSONDecoder()
                let photos = try decoder.decode([Photo].self, from: responseData)
                callback(.success(photos))
            } catch {
                callback(.failure(error))
            }
        }
        task.resume()
        
    }
    
}

