//
//  PhotosTableViewCell.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImage.image = nil
    }
    
    let containerView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let photoImage:UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            return img
        }()
        
        let photoTitle:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false            
            return label
        }()
                

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(containerView)
            self.contentView.addSubview(photoImage)
            self.contentView.addSubview(photoTitle)
            
            photoImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            photoImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:16).isActive = true
            photoImage.widthAnchor.constraint(equalToConstant:150).isActive = true
            photoImage.heightAnchor.constraint(equalToConstant:150).isActive = true
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.photoImage.trailingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
            
            photoTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
            photoTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            photoTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }
    
    
    func configureCell(_ indexPath:IndexPath, photo:Photo){
        photoTitle.text = "\(indexPath.row) - " + photo.title
    }
    
    var photo:Photo!{
        didSet{
            photoTitle.text = photo.title
        }
    }

}

