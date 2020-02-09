//
//  DataTableViewCell.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    var image_Data : UIImageView!
    var title_Data : UILabel!
    var desc_Data : UILabel!
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let imageName = UIImage(named: "default")
        image_Data = UIImageView(image: imageName)
        image_Data.contentMode = .scaleToFill
        image_Data.translatesAutoresizingMaskIntoConstraints = false
        
        title_Data = UILabel()
        title_Data.font = UIFont.boldSystemFont(ofSize: 16)
        title_Data.numberOfLines = 0
        title_Data.sizeToFit()
        title_Data.textColor = UIColor.darkGray
        title_Data.translatesAutoresizingMaskIntoConstraints = false
           
        desc_Data = UILabel()
        desc_Data.numberOfLines = 0
        desc_Data.sizeToFit()
        desc_Data.textColor = UIColor.lightGray
        desc_Data.translatesAutoresizingMaskIntoConstraints = false
           
        contentView.addSubview(image_Data)
        contentView.addSubview(title_Data)
        contentView.addSubview(desc_Data)
           
            //Sett Constraints
        title_Data.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        title_Data.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        title_Data.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        desc_Data.topAnchor.constraint(equalTo: image_Data.topAnchor).isActive = true
        desc_Data.leadingAnchor.constraint(equalTo: image_Data.trailingAnchor, constant: 5).isActive = true
        desc_Data.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
        desc_Data.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5).isActive = true
    
        image_Data.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        image_Data.topAnchor.constraint(equalTo: title_Data.bottomAnchor, constant: 5).isActive = true
        image_Data.heightAnchor.constraint(equalToConstant: 90).isActive = true
        image_Data.widthAnchor.constraint(equalToConstant: 90).isActive = true
        image_Data.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
