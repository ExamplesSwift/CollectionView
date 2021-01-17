//
//  ViewController.swift
//  CollectionView
//
//  Created by Henry AT on 16-01-21.
//

import UIKit

class ViewController: UIViewController {

  enum Section {
    case main
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    collectionView.collectionViewLayout = configureLayout()
    configureDataSource()
  }
  
  func configureLayout() -> UICollectionViewCompositionalLayout {
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView) {
      (collectionView, IndexPath, number) -> UICollectionViewCell? in
    
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: IndexPath) as? NumberCell else {
        fatalError("Cannot create new cell")
      }
      
      cell.label.text = number.description
      return cell
    }
    
  var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Int>()
    initialSnapShot.appendSections([.main])
    initialSnapShot.appendItems(Array(1...100))
    dataSource.apply(initialSnapShot, animatingDifferences: false  )
  }
  
}

