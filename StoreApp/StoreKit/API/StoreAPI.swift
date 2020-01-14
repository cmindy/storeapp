//
//  StoreAPI.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/21.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation
import NetworkingKit

public enum StoreAPI: String, CaseIterable {
    case main
    case soup
    case side
}

extension StoreAPI: EndPointType {
    public var baseURL: URL {
        guard let url = URL(string: "http://public.codesquad.kr/jk/storeapp") else {
            fatalError("baseURl could not be configured.")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .main:
            return "/main.json"
        case .soup:
            return "/soup.json"
        case .side:
            return "/side.json"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
}
