//
//  OfferDetailViewController.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/19/21.
//

import UIKit

class OfferDetailViewController: UIViewController {
    
    var offer: Offer? {
        didSet {
            updateViews()
        }
    }
    var delegate: OffersCollectionViewController?
    var offerImageView = UIImageView()
    var productNameLabel = UILabel()
    var favoriteButton = UIButton()
    var productDescription = UILabel()
    private let offerId = "offerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
        updateViews()
    }
    
    private func setUpSubviews() {
        offerImageView.contentMode = .scaleToFill
        offerImageView.translatesAutoresizingMaskIntoConstraints = false
        offerImageView.backgroundColor = .gray
        view.addSubview(offerImageView)
        
        offerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        offerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        offerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        offerImageView.heightAnchor.constraint(equalTo: offerImageView.widthAnchor, constant: 1.0).isActive = true
        
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productNameLabel)
        productNameLabel.topAnchor.constraint(equalTo: offerImageView.bottomAnchor, constant: 20).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productDescription)
        productDescription.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10).isActive = true
        productDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        productDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
    }
    
    private func updateViews() {
        guard let offer = offer,
              let offerImage = offer.url else { return }
        
        self.productNameLabel.text = offer.name
        self.productDescription.text = offer.descriptions
        OfferController.shared.getImages(imageURL: offerImage) { image, _ in
            DispatchQueue.main.async {
                self.offerImageView.image = image
            }
        }

    }



}
