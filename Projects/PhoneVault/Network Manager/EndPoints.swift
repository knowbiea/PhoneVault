//
//  EndPoints.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI

enum EndPoints {
    case phone
    case bundle(String)
    
    private var baseURL: String {
        return Configuration.environment.baseURL
    }
    
    var isShowLoader: Bool {
        switch self {
        case .phone, .bundle: true
        }
    }
    
    var url: String {
        switch self {
        case .phone: baseURL + "objects"
        case .bundle(let file): Bundle.main.url(forResource: file, withExtension: "json")?.absoluteString ?? ""
        }
    }
}

enum APIHeader {
    static let contentType = "Content-Type"
    static let Authorization = "Authorization"
    static let applicationFormURLEncoded = "application/x-www-form-urlencoded"
    static let applicationJson = "application/json"
    static let multipartFormData = "multipart/form-data"
}


