//
//  UserResponseDataModel.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import Foundation



struct UserResponseDataModel: Decodable {
    
    let user: [UserDataModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode([UserDataModel].self, forKey: .results)
    }
}
