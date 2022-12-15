//
//  UserConectionController.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import Foundation

enum Errors: Error {
    case invalidServerResponse
}

class RandomUserAPIConection {
    
    private var users: [UserDataModel] = []
    let url: String = "https://randomuser.me/api/"
    
    func getData()  -> [UserDataModel] {
        
        guard let url = URL(string: url) else {return []}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let userDataModel = try JSONDecoder().decode(UserResponseDataModel.self, from: data)
                self.users = userDataModel.user
            } catch {
                print("Error trying to get JSON data from API \(error)")
            }
        }.resume()
        
        return self.users
    }
}

