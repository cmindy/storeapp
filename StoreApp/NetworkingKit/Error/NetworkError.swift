//
//  NetworkError.swift
//  Networking
//
//  Created by CHOMINJI on 2020/01/14.
//  Copyright © 2020 cmindy. All rights reserved.
//

import Foundation

public enum NetworkError: LocalizedError {
    case parametersNil
    case headersNil
    case encodingFailed
    case decodingFailed
    case missingURL
    case couldNotParse
    case missingData
    case unwrappingError
    case dataTaskFailed
    case serverSideError
    case unknown
}

extension NetworkError {
    var errorDescription: String {
        switch self {
        case .parametersNil:
            return "Parameters are nil."
        case .headersNil:
            return "Headers are nil."
        case .encodingFailed:
            return "Parameter encoding failed."
        case .decodingFailed:
            return "Unable to decode the data."
        case .missingURL:
            return "URL is nil."
        case .couldNotParse:
            return "Unable to parse JSON response."
        case .missingData:
            return "The data from API is nil."
        case .unwrappingError:
            return "Unable to unwrap the data."
        case .dataTaskFailed:
            return "The Data task object failed."
        case .serverSideError:
            return "Server error"
        case .unknown:
            return "Unknown error has occured."
        }
    }
}
