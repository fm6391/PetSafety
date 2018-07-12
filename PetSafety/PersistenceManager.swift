//
//  PersistenceManager.swift
//  PetSafety
//
//  Created by Lambiase Salvatore on 12/07/18.
//  Copyright © 2018 De Cristofaro Paolo. All rights reserved.
//

import UIKit
import CoreData

class PersistenceManager {
    static let name = "PPet"
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func newEmptyPet () -> PPet {
        let context = getContext()
        let pPet = NSEntityDescription.insertNewObject(forEntityName: name, into: context) as! PPet
        
        pPet.name = "new name"
        pPet.birthdate = Date() as NSDate?
        pPet.race = "razza"
        pPet.order = 1
        
        return pPet
    }
    
    static func fetchData () -> [PPet]{
        var pets = [PPet] ()
        let context = getContext()
        let fetchRequest = NSFetchRequest<PPet>(entityName: name)
        do {
            try pets = context.fetch(fetchRequest)
        } catch let error as NSError{
            print("Errore in fetch \(error.code)")
        }
        return pets
    }
    
    static func saveContext() {
        let context = getContext()
        do {
            try context.save()
        } catch let error as NSError {
            print("Errore in salvataggio \(error.code)")

        }
    }
    
    static func deletePet(pet: PPet) {
        let context = getContext()
        context.delete(pet)
    }
}
