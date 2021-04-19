//
//  OffersCollectionViewController.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/18/21.
//

import UIKit
import CoreData

class OffersCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout  {
    
    let customCellIdentifier = "customCellIdentifier"
    var datasource: UICollectionViewDiffableDataSource<Int, Offer>!
    var fetchedResultsController: NSFetchedResultsController<Offer>!
//    lazy var fetchedResultsController: NSFetchedResultsController<Offer> = {
//        let fetchRequest: NSFetchRequest<Offer> = Offer.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "terms", ascending: true),
//                                        NSSortDescriptor(key: "name", ascending: true)]
//        let context = CoreDataStack.shared.mainContext
//        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
//        frc.delegate = self
//        try! frc.performFetch()
//        return frc
//    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        collectionView.delegate = self
        collectionView.dataSource = self
        OfferController.shared.syncOffers { error in
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("Error trying to fetch offers: \(error)")
                } else {
                
                    self.collectionView.reloadData()
                }
            }
        }
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        navigationItem.title = "Home"
        collectionView.backgroundColor = UIColor.white
      
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 250)
                layout.itemSize = size
        }
//        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//
//        self.collectionView.collectionViewLayout = layout
//        self.collectionView?.backgroundColor = .white
//        let flowlayout = UICollectionViewFlowLayout()
//        collectionView.accessibilityScroll(.left)
//
//        flowlayout.scrollDirection = .vertical
    
    }
    
    private func configureCollectionView() {
            let layout = UICollectionViewFlowLayout()
            // this is how far it should be from the view
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 160, height: 190)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            
            // frame is what is the position and size of the view
            let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
            view.addSubview(collectionView)
            
            collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
            
            collectionView.dataSource = self
            collectionView.backgroundColor = .white
            
            self.collectionView = collectionView
        }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return OfferController.shared.offers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OfferController.shared.offers.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as? OffersCollectionViewCell else { return UICollectionViewCell() }
    
        cell.nameLabel.text = OfferController.shared.offers[indexPath.row].name


        print(OfferController.shared.offers[indexPath.row].current_value ?? "")
        return cell
    }
    

   
 
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
