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
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 5
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        
        backgroundView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        self.backgroundCellView = backgroundView
        
        // Cashback label constraints
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.tintColor = .black
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        self.cashBackLabel = label
    }
}
