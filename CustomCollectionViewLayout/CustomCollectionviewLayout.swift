//
//  CustomCollectionViewLayout.swift
//  CustomCollectionViewLayout
//
//  Created by Donny Wals on 07-07-15.
//  Copyright (c) 2015 Donny Wals. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    let itemWidth: CGFloat = 80
    let itemSpacing: CGFloat = 15
    var layoutInfo: [NSIndexPath:UICollectionViewLayoutAttributes] = [NSIndexPath:UICollectionViewLayoutAttributes]()
    var maxXPos: CGFloat = 0
    
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // setting up some inherited values
        self.itemSize = CGSizeMake(itemWidth, itemWidth)
        self.minimumInteritemSpacing = itemSpacing
        self.minimumLineSpacing = itemSpacing
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
    }
    
    override func prepareLayout() {
        layoutInfo = [NSIndexPath:UICollectionViewLayoutAttributes]()
        for var i = 0; i < self.collectionView?.numberOfItemsInSection(0); i++ {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            let itemAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            itemAttributes.frame = frameForItemAtIndexPath(indexPath)
            if itemAttributes.frame.origin.x > maxXPos {
                maxXPos = itemAttributes.frame.origin.x
            }
            layoutInfo[indexPath] = itemAttributes
        }
    }
    
    func frameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        let maxHeight = self.collectionView!.frame.height - 20
        let numRows = floor((maxHeight+self.minimumLineSpacing)/(itemWidth+self.minimumLineSpacing))
        
        let currentColumn = floor(CGFloat(indexPath.row)/numRows)
        let currentRow = (CGFloat(indexPath.row) % numRows)
        
        let xPos = currentRow % 2 == 0 ? currentColumn*(itemWidth+self.minimumInteritemSpacing) : currentColumn*(itemWidth+self.minimumInteritemSpacing)+itemWidth*0.25
        let yPos = currentRow*(itemWidth+self.minimumLineSpacing)+10
        
        var rect: CGRect = CGRectMake(xPos, yPos, itemWidth, itemWidth)
        return rect
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return layoutInfo[indexPath]
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        
        for (indexPath, attributes) in layoutInfo {
            if CGRectIntersectsRect(rect, attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        
        return allAttributes
    }
    
    override func collectionViewContentSize() -> CGSize {
        let collectionViewHeight = self.collectionView!.frame.height
        let contentWidth: CGFloat = maxXPos + itemWidth
        
        return CGSizeMake(contentWidth, collectionViewHeight)
    }
}

