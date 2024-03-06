//
//  GooglePlaceManager.swift
//  PieceOfCake
//
//  Created by 이중엽 on 3/5/24.
//

import Foundation
import GooglePlaces

struct Place {
    let name: String
    let identifier: String
}

class GooglePlaceManager {
    
    static let shared: GooglePlaceManager = GooglePlaceManager()
    
    private let client = GMSPlacesClient.shared()
    
    enum PlaceError: Error {
        case failedToFind
    }
    
    private init() { }
    
    func findPlace(query: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        let filter = GMSAutocompleteFilter()
        filter.types = ["establishment"]
        
        
        
        client.findAutocompletePredictions(fromQuery: query,
                                           filter: filter,
                                           sessionToken: nil) { results, error in
            // results가 있거나 error가 없으면 패스
            guard let results, error == nil else {
                completion(.failure(PlaceError.failedToFind))
                return
            }
             
            let places: [Place] = results.compactMap {
                Place(name: $0.attributedFullText.string, identifier: $0.placeID)
            }
            
            completion(.success(places))
        }
    }
}
