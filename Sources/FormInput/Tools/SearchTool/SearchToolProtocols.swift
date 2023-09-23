//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

// SearchToolDataSource, tablo verilerini sağlamak için kullanılacak.
protocol SearchToolDataSource: AnyObject {
    func numberOfSections(inResult resultTableView: UITableView) -> Int
    func resultTableView(_ resultTableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func resultTableView(_ resultTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func resultTableView(_ resultTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

// SearchToolDelegate, arama sonuçlarını güncellemek ve kullanıcı etkileşimlerini ele almak için kullanılacak.
protocol SearchToolDelegate: AnyObject {
    func updateSearchResults(for searchController: UISearchController)
    func searchTool(_ searchBar: UISearchBar, textDidChange searchText: String)
    func searchTool(SearchButtonClickedFor searchBar: UISearchBar)
    func searchTool(CancelButtonClickedFor searchBar: UISearchBar)
    func resultTableView(_ resultTableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

extension SearchToolDataSource {
    func numberOfSections(inResult resultTableView: UITableView) -> Int {
        return 1
    }

    func resultTableView(_ resultTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchToolDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }

    func searchTool(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func searchTool(SearchButtonClickedFor searchBar: UISearchBar) {
    }

    func searchTool(CancelButtonClickedFor searchBar: UISearchBar) {
    }
    
    func resultTableView(_ resultTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
