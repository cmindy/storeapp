//
//  Router.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/22.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

public class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    private var session = URLSession.shared
    
    public init(task: URLSessionTask? = nil) {
        self.task = task
    }
    
    public func request<ResponseType: Decodable>(_ route: EndPoint, _ completion: @escaping (Result<ResponseType, Error>) -> Void) {
        requestData(route) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func requestData(_ route: EndPoint, completion: @escaping (Result<Data, Error>) -> Void) {
            let urlRequest = buildRequest(from: route)
            task = session.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(error ?? NetworkError.missingData))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        task?.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.method.rawValue
        return request
    }
}
