//
//  StoreAPI.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/21.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

enum StoreAPI: String, CaseIterable {
    case main
    case soup
    case side
}

extension StoreAPI: EndPointType {
    var baseURLString: String {
        return "http://public.codesquad.kr/jk/storeapp"
    }
    
    var method: HTTP.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .main:
            return "/main.json"
        case .soup:
            return "/soup.json"
        case .side:
            return "/side.json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: baseURLString) else {
            throw StoreError.invalidURL(url: baseURLString)
        }
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        return request
    }
}
