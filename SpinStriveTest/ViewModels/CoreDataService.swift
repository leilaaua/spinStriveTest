import Foundation
import CoreData

protocol CoreDataServiceProtocol: ObservableObject {
    var savedEntities: [FilterEntity] { get set }
    func fetchFilters()
    func addFilters(id: UUID, rover: String, camera: String, date: Date)
    func saveData()
}

class CoreDataService: CoreDataServiceProtocol {
    @Published var selectedFilter: FilterEntity?
    @Published var savedEntities: [FilterEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FiltersContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        fetchFilters()
    }
    
    func fetchFilters() {
        let request = NSFetchRequest<FilterEntity>(entityName: "FilterEntity")
        
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error featching \(error)")
        }
    }
    
    func addFilters(id: UUID, rover: String, camera: String, date: Date) {
        guard !savedEntities.contains(where: {
            $0.rover == rover && $0.camera == camera && $0.date == date
        })  else { return }
        
        let newFilters = FilterEntity(context: container.viewContext)
        
        newFilters.id = id
        newFilters.rover = rover
        newFilters.camera = camera
        newFilters.date = date
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFilters()
        } catch let error {
            print("Error saving \(error)")
        }
     
    }
    
    func deleteFilter(id: UUID) {
        guard let entity = savedEntities.first(where: { $0.id == id }) else { return }
        container.viewContext.delete(entity)
        saveData()
    }
}
