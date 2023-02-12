//
//  OverLappingCollectionViewController.swift
//  Animation
//
//  Created by sangmin han on 2023/02/01.
//

import Foundation
import UIKit
import CommonUI

class OverLappingCollectionViewController : UIViewController {
    
    
    private var dataList : [OverLappingCardViewModel] = [.init(image:
                                                                CommonUIAsset.backgroundImage2.image,
                                                               titleLabel: "Cell One",
                                                               subTitleLabel: "this is Cell One"),
                                                        .init(image:
                                                                CommonUIAsset.backgroundImage3.image,
                                                              titleLabel: "Cell Two",
                                                              subTitleLabel: "this is Cell Two"),
                                                         .init(image:
                                                                CommonUIAsset.backgroundImage4.image,
                                                               titleLabel: "Cell Three",
                                                               subTitleLabel: "this is Cell Three")]
    
    
    lazy private var collectionViewBackgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    lazy private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 300)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.register(OverLappingCollectionViewCell.self, forCellWithReuseIdentifier: OverLappingCollectionViewCell.cellId)
        return cv
    }()
    
    private var oldOffset : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "클론 앱 : 29CM "
        makecollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = collectionView.indexPathsForVisibleItems.first,
           let cell = collectionView.cellForItem(at: indexPath) as? OverLappingCollectionViewCell {
            cell.cardView.hideImage()
            collectionViewBackgroundImage.image = dataList[indexPath.row].image
        }
    }

}
extension OverLappingCollectionViewController {
    private func makecollectionView(){
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -150).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = collectionViewBackgroundImage
        
    }
    
}
extension OverLappingCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverLappingCollectionViewCell.cellId, for: indexPath) as! OverLappingCollectionViewCell
        cell.cardView.setViewModel(viewModel: dataList[indexPath.row])
        return cell
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translations = oldOffset - scrollView.contentOffset.x
        oldOffset = scrollView.contentOffset.x
        for cell in collectionView.visibleCells as! [OverLappingCollectionViewCell] {
            cell.cardView.animateOnScroll(scrollOffset: -translations)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPath = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        if indexPath - 1 >= 0 {
            let left = collectionView.cellForItem(at: IndexPath(row: indexPath - 1, section: 0)) as! OverLappingCollectionViewCell
            left.cardView.showImage()
            left.cardView.animateOnScroll(scrollOffset: 0)
        }
        let middle = collectionView.cellForItem(at: IndexPath(row: indexPath, section: 0)) as! OverLappingCollectionViewCell
        middle.cardView.hideImage()
        middle.cardView.animateOnScroll(scrollOffset: 0)
        collectionViewBackgroundImage.image = dataList[indexPath].image
            
        if indexPath + 1 < dataList.count {
            let right = collectionView.cellForItem(at: IndexPath(row: indexPath + 1, section: 0)) as! OverLappingCollectionViewCell
            right.cardView.showImage()
            right.cardView.animateOnScroll(scrollOffset: 0)
        }
        
    }
    
}
