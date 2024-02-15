//
//  Logger.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation

enum Logger {
    
    // MARK: - Properties
    
    // Flag to enable/disable logging
    static var isLoggingEnabled = true
    
}

// MARK: - Methods

extension Logger {
    
    // Method for logging information about the response from the server
    static func logResponse(_ response: URLResponse) {
        guard isLoggingEnabled else { return }
        
        // We check if response is an instance of HTTPURLResponse to get the HTTP status code. Otherwise, just log the response itself
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            log("HTTP Status Code: \(statusCode)")
        } else {
            log("URL Response: \(response)")
        }
    }
    
    // Method for logging URLSession errors with their description
    static func logErrorDescription(_ error: Error) {
        guard isLoggingEnabled else { return }
        
        print(error.localizedDescription)
    }
    
    // General method for logging messages
    static func log(_ message: String) {
        guard isLoggingEnabled else { return }
        
        print(message)
    }
    
}
