//
//  OffersCollectionViewController.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/18/21.
//

import UIKit
import CoreData

class OffersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let customCellIdentifier = "customCellIdentifier"
    var datasource: UICollectionViewDiffableDataSource<Int, Offer>!
    
    var ops: [BlockOperation] = []
    lazy var fetchedResultsController: NSFetchedResultsController<Offer> = {
        let fetchRequest: NSFetchRequest<Offer> = Offer.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do {
            
            try frc.performFetch()
        } catch {
            print("Error performing initial fetch inside fetchedResultsController: \(error)")
        }
        return frc
    }()
    
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
        

    }
    
    deinit {
        for o in ops { o.cancel() }
        ops.removeAll()
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as? OffersCollectionViewCell else { return UICollectionViewCell() }
        if fetchedResultsController.object(at: indexPath).isFavorited {
            cell.favoriteButton.isHidden = false
        } else {
            cell.favoriteButton.isHidden = true 
        }
        
        cell.nameLabel.text = fetchedResultsController.object(at: indexPath).name
        guard let imageURL = fetchedResultsController.object(at: indexPath).url else { return cell }
        OfferController.shared.getImages(imageURL: imageURL) { image, _ in
            DispatchQueue.main.async {
                cell.productImage.image = image
            }
        }
        cell.offerCollectionViewController = self
        
        print(OfferController.shared.offers[indexPath.row].current_value ?? "")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let offersDetailViewController = OfferDetailViewController()
        let collectionOffer = fetchedResultsController.object(at: indexPath)
        offersDetailViewController.offer = collectionOffer
         navigationController?.pushViewController(offersDetailViewController, animated: true)
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
extension OffersCollectionViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                ops.append(BlockOperation(block: { [weak self] in
                    self?.collectionView.insertItems(at: [newIndexPath!])
                }))
            case .delete:
                ops.append(BlockOperation(block: { [weak self] in
                    self?.collectionView.deleteItems(at: [indexPath!])
                }))
            case .update:
                ops.append(BlockOperation(block: { [weak self] in
                    self?.collectionView.reloadItems(at: [indexPath!])
                }))
            case .move:
                ops.append(BlockOperation(block: { [weak self] in
                    self?.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
                }))
            @unknown default:
                break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({ () -> Void in
            for op: BlockOperation in self.ops { op.start() }
        }, completion: { (finished) -> Void in self.ops.removeAll() })
    }

    
}
