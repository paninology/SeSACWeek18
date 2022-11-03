//
//  network.swift
//  SeSACWeek18
//
//  Created by yongseok lee on 2022/11/03.
//

import Foundation
import Alamofire


final class Network {
    
    static let shared = Network()
    
    private init() { }
    
    
    //Result : 성공, 실패 둘중 하나만 배타적으로 쓰일때.
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod, parameters: [String:String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
       
        AF.request(url, method: method, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            
            switch response.result {
                
            case .success(let data):
                completion(.success(data)) //탈출 클로저, Result, Enum, 연관값....
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(error))
               
            }
        }
    }
    
}
