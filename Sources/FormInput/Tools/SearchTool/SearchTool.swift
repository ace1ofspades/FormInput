//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

// SearchTool, arama işlevselliği için kullanılacak özelleştirilmiş bir yardımcı sınıf.
class SearchTool: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    let searchController: UISearchController
    let resultTableView: UITableView
    weak var dataSource: SearchToolDataSource?
    weak var delegate: SearchToolDelegate?
    weak var parentViewController: UIViewController?

    init(parentViewController: UIViewController, dataSource: SearchToolDataSource? = nil, delegate: SearchToolDelegate? = nil) {
        self.parentViewController = parentViewController
        self.dataSource = dataSource
        self.delegate = delegate
        searchController = UISearchController(searchResultsController: nil)
        resultTableView = UITableView()
        super.init()
        setup()
    }

    private func setup() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        resultTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupConstraints()
    }
    enum SearchToolPlacement:Int {
        case automatic = 0
        case inline = 1
        case stacked = 2
    }
    func configure(in navigationItem: UINavigationItem, placement: SearchToolPlacement = .inline) {
        navigationItem.searchController = searchController
        if #available(iOS 16.0, *) {
            navigationItem.preferredSearchBarPlacement = UINavigationItem.SearchBarPlacement(rawValue: placement.rawValue) ?? .inline
        }
        navigationItem.hidesSearchBarWhenScrolling = false
        //searchResultsView.addBlur()
        resultTableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
        
    }

    private func setupConstraints() {
        searchController.view.addSubview(resultTableView)
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultTableView.topAnchor.constraint(equalTo: searchController.view.safeAreaLayoutGuide.topAnchor),
            resultTableView.leadingAnchor.constraint(equalTo: searchController.view.leadingAnchor),
            resultTableView.trailingAnchor.constraint(equalTo: searchController.view.trailingAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: searchController.view.bottomAnchor),
        ])
    }

    // UISearchResultsUpdating extensions
    func updateSearchResults(for searchController: UISearchController) {
        delegate?.updateSearchResults(for: searchController)
    }

    // UISearchBarDelegate extensions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchTool(searchBar, textDidChange: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchTool(SearchButtonClickedFor: searchBar)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchTool(CancelButtonClickedFor: searchBar)
    }

    // ResultTableViewDelegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections(inResult: tableView) ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.resultTableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.resultTableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource?.resultTableView(tableView, heightForRowAt: indexPath) ?? 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.resultTableView(tableView, didSelectRowAt: indexPath)
    }
}
