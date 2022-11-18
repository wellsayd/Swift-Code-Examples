//
//  ApiCall.swift
//
//  Created by bwells on 11/3/22.
//

import UIKit


/// Handles success or errors for api calls
///
/// - success: api success
/// - noConnection: api no connection
/// - error: api error
/// - noResults: api no results
public enum ApiStatus {
    case success
    case noConnection
    case error
    case noResults
}

/**
*  A generic api call that all classes can use, seems this should stay consistent
*/
class ApiCall {

    /**
    Call the api
    
    - parameter apiUrl: api url to call
    */
    func makeCall(_ apiUrl: String) async -> (status: ApiStatus,  data: Any) {
        
        guard let url = URL(string: apiUrl) else {
            fatalError("Missing URL")
        }

        do {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return (status: ApiStatus.error,  data: "")
                
            }
            
        
            return (status: ApiStatus.success,  data: data)
            
        } catch {
            return (status: ApiStatus.error,  data: "")
        }

    }
    
}
