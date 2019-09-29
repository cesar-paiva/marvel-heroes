//
//  MarvelApi.swift
//  MarvelHeroes
//
//  Created by Cesar Paiva on 29/09/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    
    static private let basePath = "https://gateway.marvel.com/v1/public/characters"
    static private let privateKey = "38f6bdb4f6d65ecec73bd6521d536bd552e51cef"
    static private let publicKey = "a8c2fd11f340bacf49b2d0a19d4510a0"
    static private let limit = 50
    
    class func loadHeroes(name: String?, page: Int = 0, onComplete: @escaping(MarvelInfo?) -> Void) {
        let offSet = page * limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startsWith = ""
        }
        
        let url = basePath + "?offset=\(offSet)&limit=\(limit)&" + startsWith + getCredentials()
        
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                onComplete(marvelInfo)
            } catch {
                onComplete(nil)
            }
        }
    }
    
    private class func getCredentials() -> String {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(timestamp+privateKey+publicKey).lowercased()
        return "ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
    }
}
