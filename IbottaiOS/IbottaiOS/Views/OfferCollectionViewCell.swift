//
//  OffersCollectionViewCell.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/18/21.
//

import UIKit

class OffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentViewBackground: UIView!
    private var backgroundCellView = UIView()
    var nameLabel = UILabel()
    var cashBackLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        handleConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        handleConstraints()
    }
    
   
    func handleConstraints() {
        // Background view constraints of cell
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 5
        backgroundView.contentMode = .left
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)

        backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 1).isActive = true 
        
        // Cashback label constraints
        cashBackLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        cashBackLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cashBackLabel)
        cashBackLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 10).isActive = true
        cashBackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        cashBackLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        
        nameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        nameLabel.textColor = .lightGray
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
      
    }
    
}
