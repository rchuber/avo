//
//  Senior+CoreDataProperties.swift
//  avo
//
//  Created by Ryan Huber on 5/13/16.
//  Copyright © 2016 MHCI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Senior {

    @NSManaged var activity: String?
    @NSManaged var medication: String?
    @NSManaged var mental: String?
    @NSManaged var sleep: String?
    @NSManaged var name: String?
    @NSManaged var photo: String?
    @NSManaged var vitals: String?
    @NSManaged var messages: NSOrderedSet?

}
