//
//  PhotosDatasource.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class PhotosDatasource: NSObject, UITableViewDataSource {
    
    var datasource : [Photo] = []
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell        
        cell.configureCell(indexPath, photo: datasource[indexPath.row])
        return cell
    }    
}
