//
//  NetworkError.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation
enum NetworkError: Error {
    case apiError
    case decodingError
    case badRequest
}

