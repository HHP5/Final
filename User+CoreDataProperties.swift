//
//  User+CoreDataProperties.swift
//  
//
//  Created by Екатерина Григорьева on 18.06.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var company: NSSet?

}

// MARK: Generated accessors for company
extension User {

    @objc(addCompanyObject:)
    @NSManaged public func addToCompany(_ value: Company)

    @objc(removeCompanyObject:)
    @NSManaged public func removeFromCompany(_ value: Company)

    @objc(addCompany:)
    @NSManaged public func addToCompany(_ values: NSSet)

    @objc(removeCompany:)
    @NSManaged public func removeFromCompany(_ values: NSSet)

}
