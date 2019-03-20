//
//  CentredCollectionViewhandler.swift
//  CentredCollectionViewCell
//
//  Created by yassine sbyi on 24/05/2018.
//  Copyright © 2018 yassine sbyi. All rights reserved.
//

import UIKit
import Foundation

class CenteredCollectionViewCellHandler {
    
    weak var collectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout?
    
    init(collectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout) {
        self.collectionViewDelegateFlowLayout = collectionViewDelegateFlowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let cellSize = collectionViewDelegateFlowLayout?.collectionView?(
            collectionView,
            layout: collectionViewLayout,
            sizeForItemAt: IndexPath(item: 0, section: section)
            ) else {
                return UIEdgeInsets()
        }
        let margin = (collectionView.bounds.size.width - cellSize.width) / 2
        return UIEdgeInsets(
            top: 0,
            left: margin,
            bottom: 0,
            right: margin
        )
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        let pageWidth = self.pageWidth(for: collectionView)
        
        let itemToSnapIdx = round(targetContentOffset.pointee.x / pageWidth)
        
        if Int(itemToSnapIdx + 1) == collectionView.numberOfItems(inSection: 0) {
            targetContentOffset.pointee = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
        } else {
            targetContentOffset.pointee = CGPoint(x: itemToSnapIdx * pageWidth, y: 0)
        }
    }
    
    fileprivate func pageWidth(for collectionView: UICollectionView) -> CGFloat {
        guard   let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let cellSize = collectionViewDelegateFlowLayout?.collectionView?(
                collectionView,
                layout: flowLayout,
                sizeForItemAt: IndexPath(item: 0, section: 0)
            ) else { return 0 }
        
        return cellSize.width + flowLayout.minimumInteritemSpacing
    }
}
