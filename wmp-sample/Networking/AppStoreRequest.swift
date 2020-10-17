//
//  AppStoreRequest.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation

class AppStoreRequest: APIRequest {
    var method = RequestType.GET
    var path = "search"
    var parameters = [String: String]()
    
    var country: String {
        
        if let country = Locale.current.regionCode {
            return country
        }
            
        return "KR"
    }
    
    var lang: String {
        
        if let lang = Locale.preferredLanguages.first {
            let langArr = lang.split(separator: "-")
            if langArr.count > 1, let prefix = langArr.first, let suffix = langArr.last {
                return "\(prefix.lowercased())_\(suffix.lowercased())"
            }
        }
        
        return "ko_kr"
    }

    init(term: String) {
        parameters["media"] = "software"
        parameters["term"] = term
        parameters["country"] = country
        parameters["lang"] = lang
    }
}
