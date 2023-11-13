//
//  CharacterDTO.swift
//  xcode_ios_home
//
//  Created by Rezo on 13.11.2023.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
//    let imageUrl: URL
    let quote: String
}
