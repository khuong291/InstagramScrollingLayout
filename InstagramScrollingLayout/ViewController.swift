//
//  ViewController.swift
//  InstagramScrollingLayout
//
//  Created by KhuongPham on 11/21/19.
//  Copyright © 2019 KhuongPham. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  @IBOutlet weak var verticalScrollView: UIScrollView!
  @IBOutlet weak var basicInfoView: UIView!
  @IBOutlet weak var pagerView: UIView!
  @IBOutlet weak var horizontalScrollView: UIScrollView!
  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var pagerViewHeightConstraint: NSLayoutConstraint!
  
  private var collectionViewController: CollectionViewController?
  private var lastContentOffset: CGFloat = 0.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    verticalScrollView.delegate = self
    verticalScrollView.contentSize.height = basicInfoView.frame.height + view.frame.height
    view.layoutIfNeeded()
    
    if let child = children.first as? CollectionViewController {
      collectionViewController = child
      collectionViewController?.didScrollToTop = { [weak self] isOnTop in
        guard let self = self, let collectionViewController = self.collectionViewController, isOnTop else {
          return
        }
        self.verticalScrollView.isScrollEnabled = true
        collectionViewController.collectionView.isScrollEnabled = false
      }
    }
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let collectionViewController = collectionViewController else {
      return
    }
    let yOffset = scrollView.contentOffset.y
    let verticalScrollViewContentHeight = verticalScrollView.contentSize.height
    let pagerViewHeight = view.frame.height
    
    if scrollView == verticalScrollView, yOffset >= verticalScrollViewContentHeight - pagerViewHeight, lastContentOffset < scrollView.contentOffset.y, scrollView.contentOffset.y > 0 {
      verticalScrollView.isScrollEnabled = false
      collectionViewController.collectionView.isScrollEnabled = true
    }
    
    if scrollView == collectionViewController.collectionView, yOffset <= 0.0, lastContentOffset > scrollView.contentOffset.y, lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
      verticalScrollView.isScrollEnabled = true
      collectionViewController.collectionView.isScrollEnabled = false
    }
    
    lastContentOffset = scrollView.contentOffset.y
  }
}

