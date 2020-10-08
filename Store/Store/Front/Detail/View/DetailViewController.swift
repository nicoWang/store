//
//  DetailViewController.swift
//  Store
//
//  Created by Nicolas Wang on 08/10/2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
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
        if let desc = item.itemDetailDescription {
            descLabelHeight.constant = desc.height(constraintedWidth: self.view.frame.width-30, font: UIFont.systemFont(ofSize: 15))
            descLabel.text = desc
        }
        if let old = item.price?.old {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: old)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            oldPriceLabel.attributedText = attributeString
        }
        newPriceLabel.text = item.price?.new
        dateLabel.text = item.expiration
        footLabel.text = item.redemptionsCap
        scrollView.isScrollEnabled = true
        navigationButtons()
        setScrollContentSize()
    }
    
    func navigationButtons() {
        let likeButton = UIButton()
        likeButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 60)
        likeButton.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = .black
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)

        let likeBarButton = UIBarButtonItem(customView: likeButton)

        let shareButton = UIButton()
        shareButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 60)
        shareButton.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.tintColor = .black
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)

        let shareBarButton = UIBarButtonItem(customView: shareButton)

        let backButton = UIButton()
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: 15, height: 60)
        backButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        
        navigationItem.rightBarButtonItems = [likeBarButton, shareBarButton]
        navigationItem.leftBarButtonItem = backBarButton
        navigationController?.navigationBar.isTranslucent = false
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
    
    func setScrollContentSize() {
        let imageH = imageView.frame.height
        let spaceImage: CGFloat = 15
        let brandHeight = brandLabel.frame.height
        let spaceBrand: CGFloat = 15
        let titleH = titleLabel.frame.height
        let titleSpace: CGFloat = 15
        let descHeight = descLabel.frame.height
        let descSpace: CGFloat = 10
        let priceH = priceTitleLabel.frame.height
        let priceSpace: CGFloat = 10
        let newPriceH = newPriceLabel.frame.height
        let newPriceSpace: CGFloat = 10
        let footLabelH = footLabel.frame.height
        let total = imageH + spaceImage + brandHeight + spaceBrand + titleH + titleSpace + descHeight + descSpace + priceH + priceSpace + newPriceH + newPriceSpace + footLabelH + 10
        contentViewHeight.constant = total
        scrollView.contentSize = CGSize(width: view.frame.width, height: total)
    }
}
