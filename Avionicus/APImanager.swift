//
//  APImanager.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 05.03.17.
//  Copyright © 2017 Фамил Гаджиев. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import KeychainSwift

let keyChain = KeychainSwift()
typealias JSON = [String: Any]
typealias parametr = [String: Any]

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

enum Avionicus {
    case auth(String, String)
    case registration(String, String, String)
    case getProfile
    case setProfile(parametr)
    case getTrack
    
    
    var baseURL: String { return "http://avionicus.com" }
    var avkey: String { return "1M1TE9oeWTDK6gFME9JYWXqpAGc" }
    var hash: String? { return keyChain.get("hash") }
    var userId: String? { return UserDefaults.standard.value(forKey: "id") as? String }
    
    
    private struct ParameterKeys {
        
        static let login = "login"
        static let pass = "password"
        static let avkey = "avkey"
        static let responseType = "response_type"
        static let hash = "hash"
        static let mail = "mail"
        static let action = "action"
        static let userId = "user_id"
        
        
    }
    
    var path: String {
        switch self {
        case .auth: return "/api/common/login/"
        case .registration: return "/api/common/registration/"
        case .getProfile: return "/api/avtrack/user/"
        case .setProfile: return "/api/avtrack/user/"
        case .getTrack: return "/android/tracks_v0648.php"
        }
    }
    
    
    var parameters: JSON {
        switch self {
        case .auth(let login, let pass):
            return [
                ParameterKeys.login: login,
                ParameterKeys.pass: pass,
                ParameterKeys.avkey: avkey,
                ParameterKeys.responseType: "json",
            ]
        case .registration(let login, let pass, let mail ):
            return[
                ParameterKeys.login: login,
                ParameterKeys.pass: pass,
                ParameterKeys.mail: mail,
                ParameterKeys.responseType: "json",
            ]
        
        case .getProfile:
            return[
                ParameterKeys.avkey: avkey + "=",
                ParameterKeys.hash: hash!,
                ParameterKeys.responseType: "json",
                ParameterKeys.action: "get_profile",
            ]
        case .setProfile:
            return[
                ParameterKeys.avkey: avkey + "=",
                ParameterKeys.hash: hash!,
                ParameterKeys.responseType: "json",
                ParameterKeys.action: "set_profile",
            ]
        case .getTrack:
            return[
                ParameterKeys.avkey: avkey + "=",
                ParameterKeys.hash: hash!,
                ParameterKeys.responseType: "json",
                ParameterKeys.userId: userId!,
                
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
                    if let result = parse(json) {
                        completion(.success(result))
                    } else {
                        let error = NSError(domain: "Error parsing", code: 30, userInfo: [:])
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
    
    
    func registration(login: String, pass: String, mail: String, completion: @escaping(APIResult<UserData>)-> Void) {
        let requset = Avionicus.registration(login, mail,pass ).request
        
        fetch(request: requset, parse: { (json) -> UserData? in
            return UserData(json: json)
        }, completion: completion)
    }
    
    
    func getProfile(completion: @escaping(APIResult<UserProfile>)-> Void){
        let request = Avionicus.getProfile.request
        
        fetch(request: request, parse: {(json) -> UserProfile? in
            return UserProfile(json: json)
        }, completion: completion)
    }
//    func getTrack(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
}









































