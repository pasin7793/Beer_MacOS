//
//  WebService.swift
//  Beer_MacOS
//
//  Created by 임준화 on 2022/11/02.
//

import Foundation
import Alamofire

final class WebService{
    
    private let urlString = "https://api.punkapi.com/v2/beers/random"
    var beer: Observable<Beer?> = Observable(nil)

    private let decoder = JSONDecoder()
    
    func fetchData(){
        
        AF.request(urlString).responseData { response in
            switch response.result{
            case .success(let res):
                guard let json = try? self.decoder.decode([Beer].self, from: res).first else { return }
                self.beer.value = json
                print(json)
            
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
