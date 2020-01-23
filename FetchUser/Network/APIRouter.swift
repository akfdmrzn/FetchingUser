//
//  APIRouter.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getUser
    case posts
    case comments
    case albums
    case photos
    case addToDo(title: String, description: String)
    
    var method: HTTPMethod {
        switch self {
        case .getUser: return .get
        case .posts: return .get
        case .comments: return .get
        case .albums: return .get
        case .photos: return .get
        case .addToDo(_, _):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "users"
        case .posts:
            return "posts"
        case .comments:
            return "comments"
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        case .addToDo(_, _):
            return "add.php"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getUser:
            return nil
        case .posts:
            return nil
        case .comments:
            return nil
        case .albums:
            return nil
        case .photos:
            return nil
        case .addToDo(let title, let description):
            return ["title": title, "desc": description]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL().appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Common Headers
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            return try URLEncoding.default.encode(request, with: parameters)
            
        }
        
        return request
    }
    
    
}
