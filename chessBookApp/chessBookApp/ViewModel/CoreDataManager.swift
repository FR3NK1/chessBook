//
//  saveGame.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    
    func saveTask(withMoves moves: [String], withTitle title: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Game", in: context) else { return }
        
        let taskObject = Game(entity: entity, insertInto: context)
        taskObject.title = title
        taskObject.movesArray = moves
        
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
}
