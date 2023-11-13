//
//  CharacterService.swift
//  xcode_ios_home
//
//  Created by Rezo on 13.11.2023.
//

import Foundation

final class CharacterService {
    let decoder = JSONDecoder()
    let session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        return session
    }()
    func fetchCharacter(completionHandler: @escaping ([CharacterDTO]) -> Void) {
        //ЗАПРОС ДАННЫХ
        let url: URL = URL(string: "https://gravity-falls-api.vercel.app/api/characters")!
        session.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            //Обработка данных
            let characterData = try! decoder.decode([CharacterDTO].self, from: data)
            completionHandler(characterData)
        }).resume()
    }
    
}
