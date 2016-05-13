//
//  Senior+CoreDataProperties.swift
//  avo
//
//  Created by Helen Li, Ryan Huber, and Tiffany Wang on 5/11/16.
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
