//
//  Company+CoreDataProperties.swift
//  
//
//  Created by Екатерина Григорьева on 18.06.2021.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var change: Double
    @NSManaged public var changePercent: Double
    @NSManaged public var companyName: String?
    @NSManaged public var latestPrice: Double
    @NSManaged public var logo: Data?
    @NSManaged public var symbol: String?
    @NSManaged public var user: User?

}
