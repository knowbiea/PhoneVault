//
//  Configurations.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI

struct Configuration {
    
    enum Environment: String {
        case staging = "staging"
        case production = "production"
        
        var baseURL: String {
            switch self {
            case .staging: return "https://api.restful-api.dev/"
            case .production: return "https://api.restful-api.dev/"
            }
        }
    }
    
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            print("Configuration: \(configuration)")
            
            if configuration.contains("Dev") {
                return Environment.staging
            }
        }
        
        return Environment.production
    }()
}

