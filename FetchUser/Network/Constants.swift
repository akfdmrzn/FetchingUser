//
//  Constants.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import Foundation

struct Constants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
}


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded; charset=utf-8"
}
