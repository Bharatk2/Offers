//
//  OffersCollectionViewCell.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/18/21.
//

import UIKit

class OffersCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    var offerCollectionViewController: OffersCollectionViewController?
    private var backgroundCellView = UIView()
    var nameLabel = UILabel()
    var cashBackLabel = UILabel()
    var productImage = UIImageView()
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        handleConstraints()
    }
    
    //MARK: Methods
    func handleConstraints() {
        //Content View Constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        // Background Setup
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemGroupedBackground
        backgroundView.layer.cornerRadius = 5
        backgroundView.contentMode = .left
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)

        //Background Constraints
        backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 1).isActive = true
        
        //Product Image Setup
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.contentMode = .scaleAspectFit
        addSubview(productImage)
        
        //Product Image Constraints
        productImage.widthAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 1).isActive = true
        productImage.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        productImage.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        productImage.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5).isActive = true
        productImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5).isActive = true
        
        // Cashback label Setup
        cashBackLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        cashBackLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cashBackLabel)
        
        // Cashback label Constraints
        cashBackLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 10).isActive = true
        cashBackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        cashBackLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        
        // Product name setup
        nameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        nameLabel.textColor = .lightGray
        addSubview(nameLabel)
        
        // Product name constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
      
    }
    
}
