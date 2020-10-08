//
//  DetailViewController.swift
//  Store
//
//  Created by Nicolas Wang on 08/10/2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var descLabelHeight: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!  {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet private weak var brandLabel: UILabel! {
        didSet {
            brandLabel.textColor = .gray
        }
    }
    @IBOutlet private weak var likeLabel: UILabel! {
        didSet {
            likeLabel.textColor = .gray
            likeLabel.textAlignment = .right
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .black
        }
    }
    @IBOutlet private weak var descLabel: UILabel! {
        didSet {
            descLabel.textColor = .black
        }
    }

    @IBOutlet weak var priceTitleLabel: UILabel! {
        didSet {
            priceTitleLabel.textColor = .black
            priceTitleLabel.text = "PRICE"
        }
    }
    @IBOutlet private weak var oldPriceLabel: UILabel! {
        didSet {
            oldPriceLabel.textColor = .gray
        
        }
    }
    @IBOutlet private weak var newPriceLabel: UILabel! {
        didSet {
            newPriceLabel.textColor = .black
        }
    }
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .gray
        }
    }
    @IBOutlet private weak var footLabel: UILabel! {
        didSet {
            footLabel.textColor = .black
        }
    }
    
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

// MARK: - Private
private extension DetailViewController {
    func bind() {
        guard let item = presenter?.item else { return }
        if let image = item.imageURL {
            imageView.imageFromURLWithCache(url: image)
        }
        
        brandLabel.text = item.brand
        likeLabel.text = item.favoriteCountFormatted
        titleLabel.text = item.title
        descLabel.text = item.itemDetailDescription
        if let old = item.price?.old {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: old)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            oldPriceLabel.attributedText = attributeString
        }
        newPriceLabel.text = item.price?.new
        dateLabel.text = item.expiration
        footLabel.text = item.redemptionsCap
        navigationButtons()
    }
    
    func navigationButtons() {
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = .black
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)

        let likeBarButton = UIBarButtonItem(customView: likeButton)

        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.tintColor = .black
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)

        let shareBarButton = UIBarButtonItem(customView: shareButton)

        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        
        navigationItem.rightBarButtonItems = [likeBarButton, shareBarButton]
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func popView() {
        presenter?.popView()
    }
    
    @objc func share() {
        presenter?.share()
    }
    
    @objc func like() {
        presenter?.like()
    }
}
