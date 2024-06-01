import Realm
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    var db: Realm!
    
    func createCar(brand: String, color: String, type: String, isFavorite: Bool) {
        db = try! Realm()
        let car = RealmCar()
        car.id = UUID()
        car.brand = brand
        car.color = color
        car.type = type
        car.isFavorite = isFavorite
        
        
        try! db.write {
            db.add(car)
            print(car)
        }
    }
    
    func getCars() -> [RealmCar] {
        db = try! Realm()
        
        var finalResult = [RealmCar]()
        
        let cars = db.objects(RealmCar.self)
        
        finalResult = cars.map({ car in
            car
        })
        return finalResult
    }
    
    func updateCar(car: RealmCar, brand: String? = nil, color: String? = nil, type: String? = nil, isFavorite: Bool? = nil) {
        
        db = try! Realm()
        
        let dbCar = db.objects(RealmCar.self).where { $0.id == car.id }.first
        
        
        try! db.write {
            if let isFavorite = isFavorite {
                dbCar?.isFavorite = isFavorite
            }
        }
        
    }
    
    
    func deleteCars(car: RealmCar) {
        db = try! Realm()
        
        let dbCar = db.objects(RealmCar.self).where { $0.id == car.id }.first
        
        try! db.write {
            if let car = dbCar {
                db.delete(car)
            }
        }
    }
}
