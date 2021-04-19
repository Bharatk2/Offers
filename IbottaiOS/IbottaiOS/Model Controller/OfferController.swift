//
//  OfferController.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/17/21.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case  noData(String), badData(String)
    case failedFetch(String), badURL(String)
    case badError(String)
}

public class OfferController {
    var offers: [OfferRepresentation] = []
    let bgContext = CoreDataStack.shared.container.newBackgroundContext()
    var imageCache = Cache<NSString, AnyObject>()
    var newCache = Cache<String, Offer>()
    var dataLoader: DataLoader?
    let operationQueue = OperationQueue()
    static var shared = OfferController()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(dataLoader: DataLoader = URLSession.shared) {
        self.dataLoader = dataLoader
        
    }
    
    func fetchOffers(completion: @escaping ([OfferRepresentation]?, Error?) -> Void) throws {
        if let fileLocation = Bundle.main.url(forResource: "Offers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                print(try decoder.decode([OfferRepresentation].self, from: data))
                let dataFromJson = try decoder.decode([OfferRepresentation].self, from: data)
                
                self.offers = dataFromJson
                return completion(dataFromJson, nil)
            } catch {
                return completion(nil, NetworkError.badData("There was an error decoding data"))
            }
        
        }
    }
    func syncOffers(completion: @escaping (Error?) -> Void) {
        var representations: [OfferRepresentation] = []
        do {
            try fetchOffers { offers, error in
                if let error = error {
                    NSLog("Error fetching all offers to sync : \(error)")
                    completion(error)
                    return
                }

                guard let fetchOffers = offers else {
                    completion(NetworkError.badData("offers array couldn't be unwrapped"))
                    return
                }
                representations = fetchOffers

                // Use this context to initialize new events into core data.
                self.bgContext.perform {
                    for offer in representations {
                        // First if it's in the cache
                        print(offer)
                        if self.newCache.value(for: offer.id) != nil {
                            let cachedOffer = self.newCache.value(for: offer.id)!
                          
                            self.update(offer: cachedOffer, with: offer)
                            if cachedOffer.id == offer.id {
                                CoreDataStack.shared.mainContext.delete(cachedOffer)
                            }
                        } else {
                            do {
                                try self.saveOperation(by: offer.id, from: offer)
                               
                            } catch {
                                completion(error)
                                return
                            }
                        }
                       
                    }
                }// context.perform
                completion(nil)
            }// Fetch closure

        } catch {
            completion(error)
        }
    }
    
    func saveOperation(by userID: String, from representation: OfferRepresentation) throws {
        if let newEvent = Offer(representation: representation, context: bgContext) {
       
            let handleSaving = BlockOperation {
                do {
                    // After going through the entire array, try to save context.
                    // Make sure to do this in a separate do try catch so we know where things fail
                    try CoreDataStack.shared.save(context: self.bgContext)
                } catch {
                    NSLog("Error saving context.\(error)")
                }
            }
            operationQueue.addOperations([handleSaving], waitUntilFinished: false)
            newCache.cache(value: newEvent, for: userID)
        }
    }
    private func update(offer: Offer, with rep: OfferRepresentation) {
    
        offer.id = rep.id
        offer.url = rep.imageURL
        offer.name = rep.name
        offer.descriptions = rep.description
        offer.terms = rep.terms
        offer.cashback = rep.current_value
       
    }
    
    func getImages(imageURL: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let imageString = NSString(string: imageURL)
        if let imageFromCache = imageCache.value(for: imageString) as? UIImage {
            completion(imageFromCache, nil)
            return
        }
        guard let imageURL = URL(string: imageURL) else {
            return completion(nil, NetworkError.badURL("The url for image was incorrect"))
        }
        
        dataLoader?.loadData(from: imageURL, completion: { data, _, error in
            if let error = error {
                NSLog("error in fetching image :\(error)")
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil, NetworkError.badData("there was an error in image data"))
                return
            }
            
            self.imageCache.cache(value: image, for: imageString)
            completion(image, nil)
            
        })
        
    }
}
class Cache<Key: Hashable, Value> {
    private var cache: [Key: Value] = [ : ]
    private var queue = DispatchQueue(label: "Cache serial queue")

    func cache(value: Value, for key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }

    func value(for key: Key) -> Value? {
        queue.sync {
            return self.cache[key]
            
        }
    }
}
