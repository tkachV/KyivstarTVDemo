//
//  HomeLiveChannelCell.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import SkeletonView

final class HomeLiveChannelCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeLiveChannelCell"
    
    // MARK: - Views
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .titleText
        return label
    }()
    
    let lockedImageView: UIImageView = {
        let lockView = UIImageView(image: UIImage(named: "home.video_locked"))
        lockView.translatesAutoresizingMaskIntoConstraints = false
        lockView.contentMode = .scaleAspectFit
        return lockView
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = contentView.bounds.height / 2.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        imageView.image = nil
        lockedImageView.isHidden = true
    }
    
    // MARK: - Setup
    private func setupViews() {
        isSkeletonable = true
//        imageView.isSkeletonable = true
//        titleLabel.isSkeletonable = true
        
        imageView.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(lockedImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            lockedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lockedImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lockedImageView.widthAnchor.constraint(equalToConstant: 32),
            lockedImageView.heightAnchor.constraint(equalToConstant: 32),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Public configuration
    func configure(with model: ContentGroup.Asset) {
        guard let url = URL(string: model.image) else {
            return
        }
        imageView.sd_setImage(with: url)
        
        lockedImageView.isHidden = model.purchased
    }
}

