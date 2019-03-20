//
//  ViewController.swift
//  CentredCollectionViewCell
//
//  Created by yassine sbyi on 24/05/2018.
//  Copyright © 2018 yassine sbyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    lazy var centeredCollectionViewCellHandler: CenteredCollectionViewCellHandler
        = CenteredCollectionViewCellHandler(collectionViewDelegateFlowLayout: self)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            UINib(nibName: "CollectionViewCell", bundle: Bundle.main),
            forCellWithReuseIdentifier: CollectionViewCell.kReuseIdentifier
        )
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        centeredCollectionViewCellHandler.scrollViewWillEndDragging(
            scrollView,
            withVelocity: velocity,
            targetContentOffset: targetContentOffset
        )
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return centeredCollectionViewCellHandler.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.85, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.kReuseIdentifier,
            for: indexPath
            ) as? CollectionViewCell
            else { return UICollectionViewCell() }
        return cell
        
    }
}
