//
//  APImanager.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 05.03.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper
import KeychainSwift


let keyChain = KeychainSwift()
typealias JSON = [String: Any]
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
    case getTrack(Int, Int)
    
    
    var baseURL: String {
        return "http://api.avionicus.com/"
    }
    
    var avkey: String {     return "1M1TE9oeWTDK6gFME9JYWXqpAGc" }
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
        
    }
    
    var path: String {
        switch self {
        case .auth: return "/2.0/user/login/"
        case .registration: return "/2.0/user/registration/"
        case .getProfile: return "/2.0/user/profile"
        case .setProfile: return "/2.0/"
        case .getTrack: return "/2.0/tracks/user/"
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
        case .getTrack (let page, let perPage):
            return [
                ParameterKeys.token: token ?? "",
                ParameterKeys.userId: id!,
                ParameterKeys.perPage: perPage,
                ParameterKeys.page: page
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
    
    
    func fetch<T>(request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (APIResult<T>) -> Void ) {
        
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
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! JSON {
                    // тут проверка
                    
                    if let errorCode = json["error"] as? Int {
                        let error = NSError(domain: "Avionicus API Error", code: errorCode, userInfo: nil)
                        
                        completion(.failure(error))
                    }
                    
                    if let result = parse(json) {
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
        print(request)
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
    
    func getTracks(page: Int, perPage: Int, completion: @escaping(APIResult<TrackList>) -> Void) {
        let request = Avionicus.getTrack(page, perPage).request
        
        fetch(request: request, parse: { (json) -> TrackList? in
            return TrackList(JSON: json)
        }, completion: completion)
                
    }
    
    func getProfile(completion: @escaping(APIResult<UserProfile>)-> Void){
        let request = Avionicus.getProfile.request
        
        fetch(request: request, parse: {(json) -> UserProfile? in
            let user = UserProfile(JSON: json)
    
            //user?.writeToBD()
            return user
        }, completion: completion)
    }
    
//    func getProfile(completion: @escaping(APIResult<UserProfile>)-> Void){
//        let request = Avionicus.getProfile.request
//        
//        fetch(request: request, parse: {(json) -> UserProfile? in
//            return UserProfile(json: json)
//        }, completion: completion)
//    }

    
}

















