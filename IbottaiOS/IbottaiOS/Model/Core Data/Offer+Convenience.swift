//
//  Offer+Convenience.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/18/21.
//

import Foundation
import CoreData

extension Offer {
    @discardableResult convenience init(id: String,
                                        url: String,
                                        name: String,
                                        descriptions: String,
                                        terms: String,
                                        cashback: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.url = url
        self.name = name
        self.descriptions = descriptions
        self.terms = terms
        self.cashback = cashback
    
    }
    
    @discardableResult convenience init?(representation: OffersRep.OfferRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(id: representation.id,
                  url: representation.imageURL ?? "",
                  name: representation.name,
                  descriptions: representation.description,
                  terms: representation.terms,
                  cashback: representation.cashBack ?? "")
    }
}


