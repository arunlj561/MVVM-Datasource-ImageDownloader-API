//
//  PhotoViewController.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    let photosTableView = UITableView()
    let photoViewModel = PhotoViewModel()
    let photoDatasource = PhotosDatasource()
    var imageDownloaders = Set<ImageDownloader>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.bindViewModel()
        
    }
    
    func bindViewModel() {
        self.photoViewModel.photoData.bind { [weak self] (photos) in
            DispatchQueue.main.async {
                self?.photoDatasource.datasource = photos
                self?.photosTableView.reloadData()
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
    
    func showAlert(forError error:Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { (action) in
            self.retryClicked()
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setupTableView(){
        view.backgroundColor = .white
                
        view.addSubview(photosTableView)
            
        photosTableView.translatesAutoresizingMaskIntoConstraints = false
                
        photosTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        photosTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        photosTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        photosTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                
        photosTableView.dataSource = photoDatasource
        photosTableView.delegate = self
        // register cell
        photosTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")

        navigationItem.title = "Photos List"
    }
    

    

}

extension PhotoViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PhotosTableViewCell else { return }
        // set placeholder image
        cell.photoImage.image = UIImage(named: "placeholder")
        if let url = photoViewModel.getImageUrl(indexPath){
            // fetch from already cache image
            if let imageDownloader = imageDownloaders.filter({ $0.imageUrl == url && $0.imageCache != nil}).first{
                OperationQueue.main.addOperation {
                    cell.photoImage.image = imageDownloader.imageCache
                }
            }else{
                // fetch new image 
                let downloader = ImageDownloader.init(url) { (image) in
                    OperationQueue.main.addOperation {
                        cell.photoImage.image = image
                    }
                }
                imageDownloaders.insert(downloader)
            }
        }
        
        
    }
}
