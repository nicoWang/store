//
//  Error.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation

class BaseErrorApp: Error {
    var error: NSError?
    var baseError: BaseError
    
    init(error: NSError, baseError: BaseError) {
        self.error = error
        self.baseError = baseError
    }
}

enum BaseError: String, Error {
    case undefined = "Se ha producido un error inesperado. Por favor, inténtelo nuevamente más tarde"
}

extension BaseError: LocalizedError {
    
    var errorDescription: String? {
        return self.rawValue
    }
}
