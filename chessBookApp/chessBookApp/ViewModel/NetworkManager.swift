//
//  NetworkManager.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 29.07.2022.
//

import Foundation

class NetworkManager {
    
    func parse(completion: @escaping (APIResult) -> ()) {
        guard let url = URL(string: "https://my-json-server.typicode.com/FR3NK1/jsonServer/db") else { return }
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(APIResult.self, from: data)
                completion(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
