//
//  ErrorType.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/22/22.
//

import Foundation

// MARK: - Error Type
enum ErrorType: Error {
    case unknown
    case parsing(description: String)
    case network(description: String)
}
