//
//  NetworkClient.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkClient {
    
    typealias onSuccess<T> = ((T) -> ())
    typealias onFailure = ( (_ error: Error) -> ())
   
    static func performRequest<T>(_ object: T.Type, router: APIRouter, success: @escaping onSuccess<T>, failure: @escaping onFailure) where T: Decodable{
            let viewController = UIApplication.getTopViewController()
            viewController!.showIndicator(tag: String(describing: request.self))
            Alamofire.request(router).responseJSON { (response) in
                do {
                    viewController!.hideIndicator(tag: String(describing: request.self))
                    let Lists = try JSONDecoder().decode(T.self, from: response.data!)
                    success(Lists)
                } catch let error{
                    viewController!.hideIndicator(tag: String(describing: request.self))
                    failure(error)
                }
        }
    }
}
