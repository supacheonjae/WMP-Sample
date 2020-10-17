//
//  AppInfo.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation

// MARK: - AppInfoResults

struct AppInfoResults: Codable {
    let resultCount: Int
    let results: [AppInfo]
    
    private enum CodingKeys: String, CodingKey {
        case resultCount, results
    }
}


// MARK: - AppInfo

struct AppInfo: Codable {
    let artworkUrl100: String
    let artistViewUrl: String?
    let trackId: Int
    let trackName: String
    let trackViewUrl: String
    let sellerName: String
    let averageUserRating: Double
    let userRatingCount: Int
    let version: String
    let artistName: String
    let description: String

    private enum CodingKeys: String, CodingKey {
        case artworkUrl100
        case artistViewUrl
        case trackId
        case trackName
        case trackViewUrl
        case sellerName
        case averageUserRating
        case userRatingCount
        case version
        case artistName
        case description
    }
}


// MARK: - AppInfo Extension

extension AppInfo {
    var ratingDescription: String {
        
        let ratingStr = String(format: "%.1f", averageUserRating)
        let ratingCountStr: String

        switch userRatingCount {
        case ..<1000:
            ratingCountStr = "\(userRatingCount)"
            
        case ..<10000:
            let temp = Double(userRatingCount) / 1000.0
            ratingCountStr = String(format: "%.2f천", temp)
            
        case ..<100000:
            let temp = Double(userRatingCount) / 10000.0
            ratingCountStr = String(format: "%.1f만", temp)
            
        default:
            ratingCountStr = "\(userRatingCount / 10000)만"
        }
        
        
        return "★\(ratingStr) \(String(format: "(%@개의 평가)", ratingCountStr))"
    }
}
