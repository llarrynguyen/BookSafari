
import Foundation
import CoreData

struct ProductService {
    
    static var managedObjectContext = CoreDataStack().persistentContainer.viewContext
    
    internal static func products(category type: String) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "type == %@", type)
        
        do {
            let products = try self.managedObjectContext.fetch(request)
            return products
        }
        catch let error as NSError {
            fatalError("Error is getting product list: \(error.localizedDescription)")
        }
    }
    
    internal static func products(with itemIds: [String]) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "id IN %@", itemIds)
        
        do {
            let products = try self.managedObjectContext.fetch(request)
            return products
        }
        catch let error as NSError {
            fatalError("Error is getting product list: \(error.localizedDescription)")
        }
    }
    
    
    internal static func browse() -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let products = try self.managedObjectContext.fetch(request)
            return products
        }
        catch let error as NSError {
            fatalError("Error in getting all products: \(error.localizedDescription)")
        }
    }
}
