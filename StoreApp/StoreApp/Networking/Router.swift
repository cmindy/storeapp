//
//  Router.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/22.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

final class Router<EndPoint: EndPointType> {
    private let decoder = JSONDecoder()

    func request<T: Codable>(_ urlRequest: URLRequestConvertible, completion: @escaping (Result<T, StoreError>) -> Void) {
        let session = URLSession.shared
        
        guard let request = try? urlRequest.asURLRequest() else {
            return completion(.failure(.unknown))
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return completion(.failure(.requestFailed))
            }
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(.decodeFailed))
            }
            completion(.success(model))
        }.resume()
    }
}

    
