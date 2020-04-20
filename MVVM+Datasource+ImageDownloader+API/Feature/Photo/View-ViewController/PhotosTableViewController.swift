//
//  PhotosTableViewController.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {

    
    let photoViewModel = PhotoViewModel()
    let photoDatasource = PhotosDatasource()
    var imageDownloaders = Set<ImageDownloader>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        self.tableView.dataSource = photoDatasource
        self.bindViewModel()
    }
    
    // binding data source
    func bindViewModel() {        
        self.photoViewModel.photoData.bind { [weak self] (photos) in
            DispatchQueue.main.async {
                self?.photoDatasource.datasource = photos
                self?.tableView.reloadData()
            }
        }
        
        self.photoViewModel.error.bind { [weak self] (error) in
            if let error = error{
                self?.showAlert(forError: error)
            }
        }
    }
    
    func retryClicked(){
        photoViewModel.getPhotosDataSource()
    }
    
    // show alert for error
    func showAlert(forError error:Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { (action) in
            self.retryClicked()
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PhotosTableViewCell else { return }
        cell.photoImage.image = UIImage(named: "placeholder")
        if let url = photoViewModel.getImageUrl(indexPath){
            if let imageDownloader = imageDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first{
                OperationQueue.main.addOperation {
                    cell.photoImage.image = imageDownloader.imageCache
                }
            }else{
                let downloader = ImageDownloader.init(url) { (image) in
                    OperationQueue.main.addOperation {
                        cell.photoImage.image = image
                    }
                }
                imageDownloaders.insert(downloader)
            }
        }
        
        
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}
