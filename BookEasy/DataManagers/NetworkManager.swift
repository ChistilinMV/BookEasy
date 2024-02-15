//
//  NetworkManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class NetworkManager {
    
    // MARK: - Properties
    
    // Singleton is an instance of a class to avoid multiple instances of this class in different parts of the application
    static let shared = NetworkManager()
    
    // MARK: - Init
    
    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension NetworkManager {
    
    // Method for receiving data from a remote server. Accepts a UITableView and UIViewController for subsequent data processing and interface updates
    func getDataFromRemoteServer<T: Decodable>(urlString: String, from viewController: UIViewController, tableView: UITableView? = nil, completion: @escaping (T) -> Void
    ) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                Logger.logErrorDescription(error)
                return
            }
            
            if let response = response {
                Logger.logResponse(response)
            }
            
            guard let remoteData = data else { return }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: remoteData)
                DispatchQueue.main.async {
                    completion(dataModel)
                    tableView?.reloadData()
                }
            } catch let error {
                Logger.logErrorDescription(error)
            }
        }.resume()
    }
    
}
