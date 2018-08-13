//
//  UICollectionViewExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 13.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension UICollectionView {
    func scrollToButton() {
        guard numberOfSections > 0 else {
            return
        }

        let lastSection = numberOfSections - 1
        let numberOfItems = self.numberOfItems(inSection: lastSection)

        guard numberOfItems > 0 else {
            return
        }

        let lastItemIndexPath = IndexPath(item: numberOfItems - 1,
                                          section: lastSection)
        scrollToSupplementaryView(ofKind: UICollectionElementKindSectionFooter, at: lastItemIndexPath, at: .bottom, animated: true)
    }
    
    func scrollToSupplementaryView(ofKind kind: String,
                                   at indexPath: IndexPath,
                                   at scrollPosition: UICollectionViewScrollPosition,
                                   animated: Bool) {
        self.layoutIfNeeded();
        if let layoutAttributes =  self.layoutAttributesForSupplementaryElement(ofKind: kind, at: indexPath) {
            let viewOrigin = CGPoint(x: layoutAttributes.frame.origin.x, y: layoutAttributes.frame.origin.y);
            var resultOffset : CGPoint = self.contentOffset;
            
            switch(scrollPosition) {
            case UICollectionViewScrollPosition.top:
                resultOffset.y = viewOrigin.y - self.contentInset.top
                
            case UICollectionViewScrollPosition.left:
                resultOffset.x = viewOrigin.x - self.contentInset.left
                
            case UICollectionViewScrollPosition.right:
                resultOffset.x = (viewOrigin.x - self.contentInset.left) - (self.frame.size.width - layoutAttributes.frame.size.width)
                
            case UICollectionViewScrollPosition.bottom:
                resultOffset.y = (viewOrigin.y - self.contentInset.top) - (self.frame.size.height - layoutAttributes.frame.size.height)
                
            case UICollectionViewScrollPosition.centeredVertically:
                resultOffset.y = (viewOrigin.y - self.contentInset.top) - (self.frame.size.height / 2 - layoutAttributes.frame.size.height / 2)
                
            case UICollectionViewScrollPosition.centeredHorizontally:
                resultOffset.x = (viewOrigin.x - self.contentInset.left) - (self.frame.size.width / 2 - layoutAttributes.frame.size.width / 2)
            default:
                break;
            }
            self.scrollRectToVisible(CGRect(origin: resultOffset, size: self.frame.size), animated: animated)
        }
    }
}
