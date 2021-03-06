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
                                        cashBack: String,
                                        isFavorited: Bool = false,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.url = url
        self.name = name
        self.descriptions = description
        self.terms = terms
        self.cashBack = cashBack
        self.isFavorited = isFavorited
    
    }
    
    @discardableResult convenience init?(representation: OfferRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(id: representation.id,
                  url: representation.imageURL ?? "",
                  name: representation.name,
                  description: representation.description,
                  terms: representation.terms,
                  cashBack: representation.current_value ?? "")
    }
    
    
}


