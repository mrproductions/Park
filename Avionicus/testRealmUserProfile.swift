import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class DatabaseManager {
    static let realm = try! Realm()
}


class testRealmUserProfile:Object, Mappable{
    

    
    dynamic var id: Int = 0
    dynamic var login: String? = ""
    dynamic var name: String? = ""
    dynamic var avatar_url: String? = ""
    dynamic var email: String? = nil
    
    dynamic var birthday: Date?
    dynamic var height: Int = 0
    dynamic var max_hr: String? = ""
    dynamic var weight: Int = 0
    dynamic var sex: String?
    dynamic var sport_club: String?
   
    var bib: String?

    override class func primaryKey() -> String?{
        return "id"
    }
    
    func mapping(map: Map) {
        avatar_url                  <- map ["avatar_url"]
        bib                         <- map ["bib"]
        birthday                    <- (map ["birthday"], DateTransform())
        email                       <- map ["email"]
        height                      <- map ["height"]
        id                          <- map ["id"]
        login                       <- map ["login"]
        max_hr                      <- map ["max_hr"]
        name                        <- map ["name"]
        sex                         <- map ["sex"]
        sport_club                  <- map ["sport_club"]
        weight                      <- map ["weight"]
        
    }
    
//    
//    func writeToBD(){
//        let realm = DatabaseManager.realm
//        try! realm.write {
//            realm.add(self)
//        }
//    }
//    
//    func readFromBD() -> UserProfile{
//        let realm = DatabaseManager.realm
//        let user = realm.objects(UserProfile.self)
//        return user[0]
//    }
    
    required convenience init?(map: Map) {
        self.init()
        
    }
}
