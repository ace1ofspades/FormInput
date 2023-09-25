//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit


public typealias PickerItemsCallback = (_ items: [PickerItem], _ selectedItems: [PickerItem]) -> Void
public typealias SearchItemsCallback = (_ items: [PickerItem]) -> Void
public typealias ItemSortingCallback = (_ item1: PickerItem, _ item2: PickerItem) throws -> Bool

public class PickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchToolDataSource, SearchToolDelegate {
    var tableView: UITableView?

    public var fetchPickerItems: (_ callback: @escaping PickerItemsCallback) -> Void = { _ in }
    public var searchPickerItems: (_ searchText: String?, _ items: [PickerItem], _ callback: @escaping SearchItemsCallback) -> Void = { _, _, _ in }
    public var itemSortingCallback: ItemSortingCallback = { ($0.title?.localizedLowercase ?? "") < ($1.title?.localizedLowercase ?? "") }
    
    var selectionDoneCallback: (_ selectedItems: [PickerItem]) -> Void = { _ in }

    var pickerTableViewCell: (_ item: PickerItem) -> UITableViewCell? = { _ in nil }
    var searchResultCell: (_ item: PickerItem) -> UITableViewCell? = { _ in nil }
    public var fetchFilterArray: (_ item1: PickerItem, _ item2:PickerItem) -> Bool = {  $0.id == $1.id }

    var items: [PickerItem] = [] {
        didSet {
            try? items.sort(by: itemSortingCallback)
        }
    }

    var filteredItems: [PickerItem] {
        return items.compactMap { item1 in
            if selectedItems.contains(where: { fetchFilterArray(item1, $0) }) {
                return nil
            }
            return item1
        }
    }
    
    public var itemCount:Int? = nil
    
    var selectedItems: [PickerItem] = []
    var searchItems: [PickerItem] = []

    var isMultiSelection: Bool = false
    var isSearchable: Bool = false
    var selectionStyle: PickerViewStyle = .section

    var sectionTitle1 = "Seçilenler"
    var sectionTitle2 = "Aşağıdakilerden seçiminizi yapınız"

    private var searchTool: SearchTool!

    public override func viewDidLoad() {
        super.viewDidLoad()
        if let tableView = tableView {
            view.addSubview(tableView, WithConstraints: .zero)
            tableView.delegate = self
            tableView.dataSource = self

            fetchPickerItems { items, selectedItems in
                self.items = items
                self.selectedItems = selectedItems
                tableView.reloadData()
            }
        }
        configureSearchTool()
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    private func configureSearchTool() {
        searchTool = SearchTool(parentViewController: self, dataSource: self, delegate: self)
        searchTool.configure(in: navigationItem, placement: .stacked)
        definesPresentationContext = true
    }

    @objc func doneButtonTapped() {
        selectionDoneCallback(selectedItems)
        if let navigationController = navigationController {
            if navigationController.viewControllers.first == self {
                navigationController.dismiss(animated: true) { self.selectionDoneCallback(self.selectedItems) }
            } else {
                selectionDoneCallback(selectedItems)
                navigationController.popViewController(animated: true)
            }
        } else {
            dismiss(animated: true) { self.selectionDoneCallback(self.selectedItems) }
        }
    }

    convenience init(style: UITableView.Style, isSearchEnabled: Bool, isMultiSelection: Bool, selectionStyle: PickerViewStyle) {
        self.init()
        tableView = UITableView(frame: .zero, style: style)
        self.selectionStyle = selectionStyle
        isSearchable = isSearchEnabled
        self.isMultiSelection = isMultiSelection
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        switch selectionStyle {
        case .section:
            return 2
        default:
            return 1
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectionStyle == .section && section == 0 {
            return selectedItems.count
        }
        return filteredItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isSelected = selectionStyle == .section && indexPath.section == 0
        let item = isSelected ? selectedItems[indexPath.row] : filteredItems[indexPath.row]
        guard let cell = pickerTableViewCell(item) else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subtitle

            cell.accessoryType = isSelected ? .checkmark : .none

            return cell
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectionStyle == .section {
            return section == 0 ? sectionTitle1 : sectionTitle2
        }
        return nil
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let isSelected = selectionStyle == .section && indexPath.section == 0
        let item = isSelected ? selectedItems[indexPath.row] : filteredItems[indexPath.row]
        if selectionStyle == .section {
            if indexPath.section == 0 {
                selectedItems.remove(at: indexPath.row)
            } else {
                if let itemCount = itemCount, selectedItems.count >= itemCount {
                    return
                }
                selectedItems.append(item)
            }
            tableView.reloadData()
        }
    }

    func resultTableView(_ resultTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let searchItems = searchItems
        return searchItems.count
    }

    func resultTableView(_ resultTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchItems[indexPath.row]
        guard let cell = searchResultCell(item) else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subtitle

            return cell
        }
        return cell
    }

    func resultTableView(_ resultTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemCount = itemCount, selectedItems.count >= itemCount {
            return
        }
        let item = searchItems[indexPath.row]
        selectedItems.append(item)
        searchTool.searchController.dismiss(animated: true)
        tableView?.reloadData()
    }

    func searchTool(SearchButtonClickedFor searchBar: UISearchBar) {
        searchTool.searchController.view.startLoader()
        searchPickerItems(searchBar.text, items) { searchItems in
            self.searchItems = searchItems
            self.searchTool.resultTableView.reloadData()
            self.searchTool.searchController.view.stopLoader()
        }
    }
}

