//
//  CollectionViewController.swift
//  InstagramScrollingLayout
//
//  Created by KhuongPham on 11/22/19.
//  Copyright © 2019 KhuongPham. All rights reserved.
//

import UIKit

final class CollectionViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  let numbers = Array(0...99)
  
  var didScrollToTop: ((Bool) -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension CollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numbers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let number = CGFloat(numbers[indexPath.row])
    cell.backgroundColor = UIColor(red: 0.0, green: number/100.0, blue: 0.0, alpha: 1.0)
    return cell
  }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width - 16) / 3
    return CGSize(width: width, height: width)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let yOffset = scrollView.contentOffset.y
    
    if yOffset <= 0.0 {
      didScrollToTop?(true)
      scrollView.isScrollEnabled = false
    } else {
      didScrollToTop?(false)
    }
  }
}
