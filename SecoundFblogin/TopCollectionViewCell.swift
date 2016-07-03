//
//  TopCollectionViewCell.swift
//  SecoundFblogin
//
//  Created by Kyle on 7/1/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cellpageControl: UIPageControl!
 
    let headerPictureArray = ["1","2","3","4"]
    
    var timer : NSTimer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 250)
        
        let nibName = UINib(nibName: "CollectionViewCellinTopcell", bundle:nil)
        collectionView.registerNib(nibName, forCellWithReuseIdentifier: "inTopCell")
        
        cellpageControl.numberOfPages = headerPictureArray.count
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(counterTimer), userInfo: nil, repeats: true)
        
    }
    
//    func setup() {
//        if timer != nil {
//            timer?.invalidate()
//            timer = nil
//        }
//    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("inTopCell", forIndexPath: indexPath) as! CollectionViewCellinTopcell
     
        cell.topImageView.image = UIImage(named: headerPictureArray[indexPath.item])
        
        return cell
    }
    
    func counterTimer() {
       
        let nextIndex = self.cellpageControl!.currentPage + 1 < self.headerPictureArray.count ? self.cellpageControl!.currentPage + 1 : 0
        
        self.cellpageControl!.currentPage = nextIndex
        
        let x = self.collectionView!.frame.size.width * CGFloat(nextIndex)
        self.collectionView!.setContentOffset(CGPointMake(x, 0), animated: true)
    }

    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNum = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.cellpageControl.currentPage = Int(pageNum)
    }
    
    @IBAction func cellPageControlAction(sender: AnyObject) {
        
        let x = CGFloat(cellpageControl.currentPage) * self.collectionView.frame.size.width
        self.collectionView.setContentOffset(CGPointMake(x, 0), animated: true)
        
    }

}
