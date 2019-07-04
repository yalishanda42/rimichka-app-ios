//
//  RhymeEntity+CoreDataProperties.swift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 4.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//
//

import Foundation
import CoreData


extension RhymeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RhymeEntity> {
        return NSFetchRequest<RhymeEntity>(entityName: "RhymeEntity")
    }

    @NSManaged public var strength: Int32
    @NSManaged public var word: String?
    @NSManaged public var parentWord: String?

}
