//
//  APImanager.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 05.03.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import ObjectMapper
import KeychainSwift


let keyChain = KeychainSwift()
typealias JSON = [String: Any]
typealias JSONArray = [JSON]
typealias parametr = [String: Any]
typealias error = [String: Int]

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

enum APIError<T>{
    case fail(T)
}

enum Avionicus {
    
    case auth(String, String)
    case registration(String, String, String)
    case getProfile
    case setProfile(parametr)
    case getTracksList(Int, Int)
    case getTrack(Int)
    case getFriends
    case postTrack()
    
    var baseURL: String {
        return "http://api.avionicus.com/"
    }
    
    
    var avkey: String {     return "1M1TE9oeWTDK6gFME9JYWXqpAGc" }
    var hash: String  {     return "870eda99a1084d3b8f6a17f6d6fdfb40e8a5636377"}
    var token: String? {    return keyChain.get("token") }
    var id: Int? {          return UserDefaults.standard.value(forKey: "id") as? Int }
    var deviceId: String {  return UIDevice.current.identifierForVendor?.uuidString ?? "_" }
    
    private struct ParameterKeys {
        
        static let loginOrEmail = "loginoremail"
        static let login = "login"
        static let pass = "password"
        static let avkey = "avkey"
        static let responseType = "response_type"
        static let token = "token"
        static let mail = "email"
        static let action = "action"
        static let userId = "user_id"
        static let perPage = "per_page"
        static let page = "page"
        static let startingDate = "date_last"
        static let startingTrack = "track_id"
        static let deviceId = "device_id"
        static let trackID = "track_id"
        static let hash = "hash"
    }
    
    var path: String {
        switch self {
        case .auth: return "/2.0/user/login/"
        case .registration: return "/2.0/user/registration/"
        case .getProfile: return "/2.0/user/profile/"
        case .setProfile: return "/2.0/"
        case .getTracksList: return "/2.0/tracks/user/"
        case .getTrack: return "/2.0/track/"
        case .getFriends: return "/2.0/friends/"
        case .postTrack: return "/android/upload_v0660.php"
        }
    }
    
    
    var parameters: JSON {
        switch self {
        case .auth(let loginOrEmail, let pass):
            return [
                ParameterKeys.loginOrEmail: loginOrEmail,
                ParameterKeys.pass: pass,
                ParameterKeys.deviceId : deviceId
            ]
        case .registration(let login, let pass, let mail ):
            return[
                ParameterKeys.login: login,
                ParameterKeys.pass: pass,
                ParameterKeys.mail: mail,
                ParameterKeys.deviceId : deviceId
            ]
            
        case .getProfile:
            return[
                ParameterKeys.token: token ?? "",
                ParameterKeys.userId: id!
            ]
        case .setProfile:
            return[
                ParameterKeys.token: token ?? "",
                //ParameterKeys.hash: hash!,
                ParameterKeys.responseType: "json",
                ParameterKeys.action: "set_profile",
            ]
        case .getTracksList (let page, let perPage):
            return [
                ParameterKeys.token: token ?? "",
                ParameterKeys.userId: id!,
                ParameterKeys.perPage: perPage,
                ParameterKeys.page: page
            ]
        case .getTrack (let trackID):
            return [
                ParameterKeys.token: token ?? "",
                ParameterKeys.trackID: trackID
            ]
        case .getFriends:
            return [
                ParameterKeys.token: token ?? "",
                ParameterKeys.userId: id!
            ]
        case .postTrack:
            return [
                ParameterKeys.avkey: avkey,
                ParameterKeys.hash: hash,
                ParameterKeys.userId: id!
            ]
        }
        
    }
    
    var queryComponents: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            items.append(item)
        }
        
        return items
    }
    
    var components: URLComponents {
        var componentsLocal = URLComponents(string: baseURL)!
        componentsLocal.path = path
        componentsLocal.queryItems = queryComponents
        return componentsLocal
    }
    
    var url: URL {
        return components.url!
    }
    
    var postRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
        
    }
    
    var request: URLRequest {
        return URLRequest(url: url)
    }
    
    
}

class APIManager {
    
    var configuration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    init(config: URLSessionConfiguration) {
        self.configuration = config
    }
    
    convenience init() {
        self.init(config: URLSessionConfiguration.default)
    }
    
    func fetchArray<T>(request: URLRequest, parse: @escaping (JSONArray) -> [T]?, key: String? = nil, completion: @escaping (APIResult<[T]>) -> Void ){
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "com.avionicus.famil", code: 20, userInfo: [:])
                completion(.failure(error))
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(.failure(error))
                }
            }
            
            
            
            switch response.statusCode {
                
            case 200:
                
                var rawJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                if key != nil {
                    
                    if let dictJSON = rawJSON as? JSON {
                        rawJSON = dictJSON[key!]
                    }
                    
                }
                
                if let json = rawJSON as? JSONArray {
    
                    if let result = parse(json){
                        completion(.success(result))
                    }
                } else if let json = rawJSON as? JSON {
                    if let errorCode = json["error"] as? Int {
                        let error = NSError(domain: "Avionicus API Error", code: errorCode, userInfo: nil)
                        
                        completion(.failure(error))
                    }
                }
                
            default:
                let error = NSError(domain: "", code: 40, userInfo: [:])
                completion(.failure(error))
            }
        }
        task.resume()

        
    }
    
    func fetch<T>(request: URLRequest, parse: @escaping (JSON) -> T?,  completion: @escaping (APIResult<T>) -> Void ) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "com.avionicus.famil", code: 20, userInfo: [:])
                completion(.failure(error))
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(.failure(error))
                }
            }
            
            switch response.statusCode {
                
            case 200:

                let rawJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                if let json = rawJSON as? JSON {
                    if let errorCode = json["error"] as? Int {
                        let error = NSError(domain: "Avionicus API Error", code: errorCode, userInfo: nil)
                        
                        completion(.failure(error))
                    }
                    
                    if let result = parse(json)  {
                        completion(.success(result))
                    } else {
                        let error = NSError(domain: "Parsing error", code: 30, userInfo: nil)
                        completion(.failure(error))
                    }
                }
                
            default:
                let error = NSError(domain: "", code: 40, userInfo: [:])
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func auth(login: String, pass: String, completion: @escaping (APIResult<UserData>) -> Void) {
        let request = Avionicus.auth(login, pass).request
        
        fetch(request: request, parse: { (json) -> UserData? in
            return UserData(json: json)
        }, completion: completion)
    }
    
    
    func registration(login: String, pass: String, mail: String, completion: @escaping(APIResult<UserRegistration>)-> Void) {
        let request = Avionicus.registration(login, pass, mail).request
        
        fetch(request: request, parse: { (json) -> UserRegistration? in
            return UserRegistration(json: json)
        }, completion: completion)
    }
    
    func getTracks(page: Int, perPage: Int, completion: @escaping(APIResult<[TrackListItem]>) -> Void) {
        let request = Avionicus.getTracksList(page, perPage).request
        
        fetchArray(request: request, parse: { (json) -> [TrackListItem]? in
            return [TrackListItem](JSONArray: json)
        }, key: "tracks", completion: completion)
        
    }
    
    func getTrack(trackID: Int, completion: @escaping(APIResult<TrackDetails>) -> Void) {
        let request = Avionicus.getTrack(trackID).request
        
        fetch(request: request, parse: { (json) -> TrackDetails? in
            return TrackDetails(JSON: json)
        }, completion: completion)
        
    }
    
    func getProfile(completion: @escaping(APIResult<UserProfile>)-> Void){
        let request = Avionicus.getProfile.request
        
        fetch(request: request, parse: {(json) -> UserProfile? in
            return UserProfile(JSON: json)
        }, completion: completion)
    }
    
    func getFriends(completion: @escaping(APIResult<[UserFriend]>)-> Void){
        let request = Avionicus.getFriends.request
        
        fetchArray(request: request, parse: {(json) -> [UserFriend]? in
            return [UserFriend](JSONArray: json)
        }, completion: completion)
        
    }
    
    
}

