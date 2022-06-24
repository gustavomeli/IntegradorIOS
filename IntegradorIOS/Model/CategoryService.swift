//
//  CategoryService.swift
//  IntegradorIOS
//
//  Created by Gustavo Antunes Malheiros on 23/06/22.
//

import Foundation
import Alamofire

struct CategoryService{

    let apiClient: AlamofireAPI
    
    init(apiClient: AlamofireAPI = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getCategories(category: String, participants: Int, random: Bool = false, response: @escaping (Result<Category, AFError>) -> Void){
        let participantsString = String(participants)
        var url = "http://www.boredapi.com/api/activity/"
        if category != "" {
            url += "?type=\(String(describing: category))"
        }
        if participants != 0 {
            url += "&participants=\(participantsString)"
        }
    
        
        AF.request(url).responseDecodable(of: Category.self) {
            dataResponse in
            switch dataResponse.result {
            case .success(let resultDataSuccess):
                return response(.success(resultDataSuccess))
            case .failure(let errorFailure):
                return response(.failure(errorFailure))
            }
        }
    }
}

protocol AlamofireAPI {
    func get(url: String, completion: @escaping ((Result<Data?, AFError>) -> Void))
}

class APIClient: AlamofireAPI {

    func get(url: String, completion: @escaping ((Result<Data?, AFError>) -> Void)){
        AF.request(url).response {
            completion($0.result)
        }
    }
}
