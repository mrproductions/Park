import Foundation
import ObjectMapper

class UserProfile: Mappable{
    
    enum Sex: String {
        case Male = "man"
        case Female = "woman"
    }
    
    public required init?(map: Map) {}
    
    var avatar_url: String?
    var bib: String?
    var birthday: String?
    var email: String?
    var height: Int?
    var id: Int?
    var login: String?
    var max_hr: String?
    var name: String?
    var photo_url: String?
    var sex: Sex?
    var sport_club: String?
    var weight: Int?
    
    
    convenience init?(json: JSON) {
        self.init(JSON: json)
    }
    
    func mapping(map: Map) {
        
        avatar_url                  <- map ["avatar_url"]
        bib                         <- map ["bib"]
        birthday                    <- map ["birthday"]
        email                       <- map ["email"]
        height                      <- map ["height"]
        id                          <- map ["id"]
        login                       <- map ["login"]
        max_hr                      <- map ["max_hr"]
        name                        <- map ["name"]
        photo_url                   <- map ["photo_url"]
        sex                         <- map ["sex"]
        sport_club                  <- map ["sport_club"]
        weight                      <- map ["weight"]
        
    }
    
}
