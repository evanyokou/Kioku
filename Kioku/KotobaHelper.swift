//
//  KotobaHelper.swift
//  Kioku
//
//  Created by Yuhao on 2017/05/31.
//  Copyright © 2017年 Yuhao. All rights reserved.
//
import UIKit
import CoreData
import Foundation

class KotobaHelper: NSObject {
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(data: KotobaEntity?) -> Kotoba? {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Kotoba", in: context)
        
        let kotoba = NSManagedObject(entity: entity!, insertInto: context)
        
        if (data == nil){
            return nil
        }else if(data?.tango == nil){
            return nil
        }else{
            
            kotoba.setValue(data?.tango, forKey: "tango")
            kotoba.setValue("\(Date().timeIntervalSince1970)", forKey: "id")
            kotoba.setValue(data?.kana == nil ? "-" : data?.kana, forKey: "kana")
            kotoba.setValue(data?.imi == nil ? "-" : data?.imi, forKey: "imi")
            kotoba.setValue(data?.rei == nil ? "-" : data?.rei, forKey: "rei")
            kotoba.setValue(data?.kaisu == nil ? 0 : data?.kaisu, forKey: "kaisu")
            kotoba.setValue(data?.tag == nil ? "一般" : data?.tag, forKey: "tag")
            
            do {
                try context.save()
                return kotoba as? Kotoba
            } catch {
                return nil
            }
        }
    }
    
    func update(id: String, kaisu: Int16) -> Kotoba? {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Kotoba", in: context)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = entity
        
        let predicate = NSPredicate.init(format: "id='\(id)'", "")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as! [Kotoba]
            for info: Kotoba in fetchedObjects {
                info.setValue(kaisu, forKey: "kaisu")
                try context.save()
                return info
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func update(data: KotobaEntity) -> Kotoba? {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Kotoba", in: context)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = entity
        let id: String = data.id!
        print("id='\(id)'")
        let predicate = NSPredicate.init(format: "id='\(id)'", "")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as! [Kotoba]
            for info: Kotoba in fetchedObjects {
                info.setValue(data.tango, forKey: "tango")
                info.setValue(data.kana, forKey: "kana")
                info.setValue(data.imi, forKey: "imi")
                info.setValue(data.rei, forKey: "rei")
                info.setValue(data.tag, forKey: "tag")
                try context.save()
                return info
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func query(id: String) -> Kotoba? {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Kotoba", in: context)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = entity
        
        let predicate = NSPredicate.init(format: "id='\(id)'", "")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as! [Kotoba]
            for info: Kotoba in fetchedObjects {
                return info
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func query(condition: String) -> [Kotoba]? {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Kotoba", in: context)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.fetchLimit = 10000
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = entity
        
        let predicate = NSPredicate.init(format: condition, "")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as! [Kotoba]
            return fetchedObjects
        } catch {
            return nil
        }
    }
    
    func delete(id: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Kotoba", in: context)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchOffset = 0
        
        fetchRequest.entity = entity
        
        let predicate = NSPredicate.init(format: "id='\(id)'", "")
        fetchRequest.predicate = predicate
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as! [Kotoba]
            for info: Kotoba in fetchedObjects {
                context.delete(info)
                try context.save()
                return true
            }
            return false
        } catch {
            return false
        }
    }
    
    
}
