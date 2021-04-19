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
                                        description: String,
                                        terms: String,
                                        cashback: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.url = url
        self.name = name
        self.descriptions = description
        self.terms = terms
        self.cashback = cashback
    
    }
    
    @discardableResult convenience init?(representation: OfferRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(id: representation.id,
                  url: representation.imageURL ?? "",
                  name: representation.name,
                  description: representation.description,
                  terms: representation.terms,
                  cashback: representation.current_value ?? "")
    }
}


