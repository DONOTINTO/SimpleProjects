//
//  GooglePlaceVC.swift
//  PieceOfCake
//
//  Created by 이중엽 on 3/5/24.
//

import UIKit
import SnapKit
import MapKit

class GooglePlaceVC: UIViewController {
    
    let mapView = MKMapView()
    let searchController = UISearchController(searchResultsController: SearchResultsVC())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
        
        self.view.backgroundColor = .white
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.barStyle = .default
        searchController.searchBar.searchBarStyle = .default
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

}

extension GooglePlaceVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? SearchResultsVC  else {
            return
        }
        
        GooglePlaceManager.shared.findPlace(query: query) { result in
            
            switch result {
            case .success(let places):
                
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension GooglePlaceVC {
    
    func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    func configureLayout() {
        
        mapView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        
    }
}
