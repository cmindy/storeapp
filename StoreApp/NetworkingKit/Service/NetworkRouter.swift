//
//  NetworkRouter.swift
//  NetworkingKit
//
//  Created by CHOMINJI on 2020/01/14.
//  Copyright © 2020 cmindy. All rights reserved.
//

import Foundation

public protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<ResponseType: Decodable>(_ route: EndPoint, _ completion: @escaping (Result<ResponseType, Error>) -> Void)
    func cancel()
}
