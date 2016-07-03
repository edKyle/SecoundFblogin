//
//  PictureCollectionViewController.swift
//  SecoundFblogin
//
//  Created by Kyle on 7/1/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import GestureRecognizerClosures
import SDWebImage

private let reuseIdentifier = "Cell"

class PictureCollectionViewController: UICollectionViewController {
    
 
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "TopCollectionViewCell", bundle:nil)
        self.collectionView!.registerNib(nibName, forCellWithReuseIdentifier: "TopCell")

      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            return  1
        default:
            return DownLoadData.pictureUrlString.count
        }
    }
    
    
    
    
    
    
    //Mark switch section different collectionView size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.section == 0{
            return CGSize(width: UIScreen.mainScreen().bounds.width, height: 250)
        } else{
            let spacingWidth = Float(10)
            let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
            let width = (Float(UIScreen.mainScreen().bounds.width) - spacingWidth * Float(4+1)) / 2
            layout.itemSize = CGSize(width: CGFloat(width), height: CGFloat(width))
            
            return layout.itemSize
        }
    //Mark switch section different collectionView size
    
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
    case 0:
        let topcell = collectionView.dequeueReusableCellWithReuseIdentifier("TopCell", forIndexPath: indexPath) as! TopCollectionViewCell
        
        return topcell

    default:
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImageViewCollectionViewCell
        
        cell.progressBar.hidden = false
        
        let urlString = DownLoadData.pictureUrlString[indexPath.item]
        let nsurl = NSURL(string: urlString)
        
        
        let manager = SDWebImageManager.sharedManager()
        manager.downloadImageWithURL(NSURL(string:urlString), options: SDWebImageOptions.RefreshCached, progress: { (receivedSize:Int, expectedSize:Int) in
            
            cell.progressBar.setProgress(Float(receivedSize) / Float(expectedSize), animated: true)
            
            }, completed: { (image:UIImage!, error:NSError!, cacheType:SDImageCacheType, finished:Bool, url: NSURL!) in
                
                cell.progressBar.hidden = true
                
                if image != nil {
                   cell.imageViewOfCell.image = image
                }
        })

        
        if let button = cell.shareButton{
            button.onTap({ (UITapGestureRecognizer) in
               
                let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [nsurl!], applicationActivities: nil)
                self.presentViewController(activityVC, animated: true, completion: nil)
            })
        }
        
            
        // Configure the cell
    
        return cell
        }
    }
}






  





























