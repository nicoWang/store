//
//  ListCell.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .gray
        }
    }
    @IBOutlet private weak var likeLabel: UILabel! {
        didSet {
            likeLabel.textColor = .gray
        }
    }
    @IBOutlet private weak var descLabel: UILabel! {
        didSet {
            descLabel.textColor = .black
            descLabel.numberOfLines = 0
        }
    }
    @IBOutlet private weak var footLabel: UILabel! {
        didSet {
            footLabel.textColor = .gray
        }
    }
    
    func update(with item: Any?) {
        guard let item = item as? Item else { return }
        titleLabel.text = item.brand
        likeLabel.text = item.favoriteCountFormatted
        descLabel.text = item.title
        footLabel.text = item.tags
        
        if let imageURL = item.imageURL {
            iconImageView.imageFromURLWithCache(url: imageURL)
        }
    }
}
