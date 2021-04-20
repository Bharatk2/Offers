//
//  OfferDetailViewController.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/19/21.
//

import UIKit

class OfferDetailViewController: UIViewController {
    
    var offer: Offer?
    var delegate: OffersCollectionViewController?
    var offerImageView = UIImageView()
    var productNameLabel = UILabel()
    var termsLabel = UILabel()
    var productDescription = UILabel()
    let favoriteButton = UIButton()
    var barButton = UIBarButtonItem()
    
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
        offerImageView.layer.cornerRadius = 5
        view.addSubview(offerImageView)
   
        offerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        offerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        offerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        offerImageView.heightAnchor.constraint(equalTo: offerImageView.widthAnchor, constant: 1.0).isActive = true
        
        productNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productNameLabel)
        productNameLabel.topAnchor.constraint(equalTo: offerImageView.bottomAnchor, constant: 20).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        productDescription.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        productDescription.lineBreakMode = .byWordWrapping
        productDescription.numberOfLines = 0
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productDescription)
        productDescription.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10).isActive = true
        productDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        productDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        termsLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        termsLabel.textColor = .lightGray
        termsLabel.lineBreakMode = .byWordWrapping
        termsLabel.numberOfLines = 0
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(termsLabel)
        
        termsLabel.topAnchor.constraint(equalTo: productDescription.bottomAnchor, constant: 10).isActive = true
        termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        termsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        
        favoriteButton.addTarget(self, action: #selector(setFavoriteTarget), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favoriteButton)
        favoriteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
       
    }
    
    @objc func setFavoriteTarget() {
        guard let offer = offer else { return }
        offer.isFavorited.toggle()
      
        favoriteButton.setImage(offer.isFavorited ? UIImage(named: "iconLike") : UIImage(named: "Like"), for: .normal)
       
    }

    private func updateViews() {
        guard let offer = offer,
              let offerImage = offer.url else { return }
       
        self.productNameLabel.text = offer.name
        favoriteButton.setImage(offer.isFavorited ? UIImage(named: "iconLike") : UIImage(named: "Like"), for: .normal)
        self.productDescription.text = offer.descriptions
        self.termsLabel.text = offer.terms
        OfferController.shared.getImages(imageURL: offerImage) { image, _ in
            DispatchQueue.main.async {
                self.offerImageView.image = image
            }
        }

    }



}
