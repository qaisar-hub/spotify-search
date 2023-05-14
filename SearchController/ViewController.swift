//
//  ViewController.swift
//  SearchController
//
//  Created by qaisar.raza on 13/05/23.
//

import UIKit

class ViewController: UIViewController {
    
//    fileprivate lazy var textLabel: UILabel = {
//        let textLabel = UILabel()
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.numberOfLines = 0
//        textLabel.text = "Choose 3 or more artists you like"
//        textLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        return textLabel
//    }()
    
    @objc lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 120, height: 180)
        return layout
    }()

    @objc lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
 //   lazy var searchBar: UISearchBar = UISearchBar(frame: CGRectMake(0, 0, view.frame.size.width, 200))
    
    var itemsArray = ["Davido", "Drake", "Asake", "Rema", "Burna Boy", "Wizkid", "Davido", "Drake", "Asake", "Rema", "Burna Boy", "Wizkid", "Davido", "Drake", "Asake", "Rema", "Burna Boy", "Wizkid"]
    var filteredArr = Array<String>()
    var selectedCellIndex = Array<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        filteredArr  = itemsArray
        
//        searchBar.placeholder = "Search"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
//        searchBar.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        let navigationItem = navigationItem
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.title = "Choose 3 or more artists you like"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reusueIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArr = []
        filteredArr = searchText.isEmpty ? itemsArray : itemsArray.filter{$0.contains(searchText)}
        collectionView.reloadData()
        print("button clicked 1")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked 2")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredArr = itemsArray
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reusueIdentifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(filteredArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        if(selectedCellIndex.contains(indexPath.row)) {
            guard let index = selectedCellIndex.firstIndex(of: indexPath.row) else { return }
            selectedCellIndex.remove(at: index)
            cell?.isSelected = false
            cell?.updateSelection()
        } else {
            selectedCellIndex.append(indexPath.row)
            cell?.isSelected = true
            cell?.updateSelection()
        }
    }
    
}

