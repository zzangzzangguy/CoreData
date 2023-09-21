//
//  ProfileViewCell.swift
//  ToDO
//
//  Created by t2023-m0096 on 2023/09/18.
//

import UIKit
import SnapKit

class ProfileViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileViewCell"
    
    let ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.ProfileImageView)
        
        ProfileImageView.snp.makeConstraints{
            $0.width.height.equalTo(136)
            $0.edges.equalToSuperview().inset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

