//
//  Kotoba+CoreDataProperties.swift
//  Kioku
//
//  Created by Yuhao on 2017/06/01.
//  Copyright © 2017年 Yuhao. All rights reserved.
//

import Foundation
import CoreData


extension Kotoba {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kotoba> {
        return NSFetchRequest<Kotoba>(entityName: "Kotoba");
    }

    @NSManaged public var id: String?
    @NSManaged public var imi: String?
    @NSManaged public var kaisu: Int16
    @NSManaged public var kana: String?
    @NSManaged public var rei: String?
    @NSManaged public var tag: String?
    @NSManaged public var tango: String?

}
