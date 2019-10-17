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
  var layoutInfo = [IndexPath: UICollectionViewLayoutAttributes]()
  var maxXPos: CGFloat = 0
  
  override init() {
    super.init()
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    // setting up some inherited values
    self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    self.minimumInteritemSpacing = itemSpacing
    self.minimumLineSpacing = itemSpacing
    self.scrollDirection = .horizontal
  }
  
  override func prepare() {
    layoutInfo = [IndexPath: UICollectionViewLayoutAttributes]()
    for i in (0..<(self.collectionView?.numberOfItems(inSection: 0) ?? 0)) {
      let indexPath = IndexPath(row: i, section: 0)
      let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      itemAttributes.frame = frameForItemAtIndexPath(indexPath)
      if itemAttributes.frame.origin.x > maxXPos {
        maxXPos = itemAttributes.frame.origin.x
      }
      layoutInfo[indexPath] = itemAttributes
    }
  }
  
  func frameForItemAtIndexPath(_ indexPath: IndexPath) -> CGRect {
    let maxHeight = self.collectionView!.frame.height - 20
    let numRows = floor((maxHeight+self.minimumLineSpacing)/(itemWidth+self.minimumLineSpacing))
    
    let currentColumn = floor(CGFloat(indexPath.row)/numRows)
    let currentRow = CGFloat(indexPath.row).truncatingRemainder(dividingBy: numRows)
    
    let xPos = currentRow.truncatingRemainder(dividingBy: 2) == 0 ? currentColumn*(itemWidth+self.minimumInteritemSpacing) : currentColumn*(itemWidth+self.minimumInteritemSpacing)+itemWidth*0.25
    let yPos = currentRow*(itemWidth+self.minimumLineSpacing)+10

    return CGRect(x: xPos, y: yPos, width: itemWidth, height: itemWidth)
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return layoutInfo[indexPath]
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    for (_, attributes) in layoutInfo {
      if rect.intersects(attributes.frame) {
        allAttributes.append(attributes)
      }
    }
    
    return allAttributes
  }
  
  override var collectionViewContentSize: CGSize {
    let collectionViewHeight = self.collectionView!.frame.height
    let contentWidth: CGFloat = maxXPos + itemWidth
    
    return CGSize(width: contentWidth, height: collectionViewHeight)
  }
}

