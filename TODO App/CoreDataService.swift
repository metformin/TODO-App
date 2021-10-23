//
//  CoreDataService.swift
//  TODO App
//
//  Created by Darek on 16/10/2021.
//

import CoreData
import UIKit

enum CoreDataError: Error{
    case savingError
}

final class CoreDataService: NSObject{
    
    static let shared = CoreDataService()
    
    private func getContest() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    public func saveData(taskTitle: String, taskAddedDate: Date, taskFinishDate: Date, taskCategory: Category, completion: @escaping(Error?) -> Void)  {
        let context = getContest()
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        
        guard let entity = entity else {
            completion(CoreDataError.savingError)
            return
        }
        
        let newTask = NSManagedObject(entity: entity, insertInto: context)
        newTask.setValue(taskTitle, forKey: "title")
        newTask.setValue(taskAddedDate, forKey: "addedDate")
        newTask.setValue(taskFinishDate, forKey: "finishDate")
        newTask.setValue(taskCategory.rawValue, forKey: "category")
        
        do {
            try context.save()
            print("DEBUG: New task saved")
            completion(nil)
        } catch(let err) {
            print("DEBUG: Error during add new task")
            completion(err)
        }
    }
    
    func fetchTask() -> [Task]?{
        let context = getContest()
        var tasks: [Task]? =  nil
         let fetchRequestParcel = NSFetchRequest<Task>(entityName: "Task")

        do {
            tasks = try context.fetch(fetchRequestParcel)
            print("DEBUG: Data fetched from DB")
            return tasks
        } catch {
            return nil
        }
    }
    
    func deleteSpecyficTask(task: Task, completion: @escaping() -> Void){
        let context = getContest()
        let fetchRequestParcel = NSFetchRequest<Task>(entityName: "Task")
        fetchRequestParcel.predicate = NSPredicate(format: "addedDate == %@ ", task.addedDate! as NSDate)

        do {
            let requestParcel = try context.fetch(fetchRequestParcel)
            
            if requestParcel.count > 0 {
                for object in requestParcel {
                    context.delete(object)
                }
            }
            try context.save()
            completion()
        }catch(let err){
            print(err)
        }
    }
}
