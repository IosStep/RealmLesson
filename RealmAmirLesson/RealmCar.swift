import RealmSwift
import Foundation

class RealmCar: Object, Identifiable {
    @Persisted var id: UUID
    @Persisted var brand: String
    @Persisted var color: String
    @Persisted var type: String
    @Persisted var isFavorite: Bool
}
