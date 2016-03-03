//
//  InfiniteScrollView.swift
//  InfiniteScroll
//
//  Created by OrbisTeam on 2/03/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

import UIKit

enum InfiniteScrollViewViewPosition:Int {
    case InfiniteScrollViewViewPositionHiddenLeft = 0
    case InfiniteScrollViewViewPositionVisible = 1
    case InfiniteScrollViewViewPositionHiddenRight = 2
}

// MARK: - Protocol

protocol InfiniteScrollViewDelegate: class {
    
    /**
        Number of views in the scroll.
        - returns: (Int) number of view to show in the scroll
     */
    func numberOfElementsInInfiniteScrollView() -> Int
    
    /**
        InfiniteScroll Component
        - parameter infiniteScrollView: infiniteScrollView to implement
        - parameter index: position of view
     */
    func infiniteScrollView(infiniteScrollView:InfiniteScrollView, forIndex index:Int) -> UIView
}

class InfiniteScrollView: UIScrollView {
    
// MARK: - Properties
    weak var _delegateISV:InfiniteScrollViewDelegate?
    var view1:UIView!
    var view2:UIView!
    var view3:UIView!
    var viewsArray:[UIView]!
    var numberOfElements:Int!
    var currentItemIndex:Int!

// MARK: - Int

    required init(coder : NSCoder) {
        super.init(coder: coder)!
        self.configScrollViewViews()
    }

// MARK: - Functions

    /**
        Apply the delegate and set the value default
    */
    func configScrollViewViews() {
        self.delegate = self
        self.viewsArray = []
        self.pagingEnabled = true
        self.currentItemIndex = 0
    }
    
    weak var delegateISV:InfiniteScrollViewDelegate? {
        get {
            return self._delegateISV
        }
        set (delegatetmp){
            self._delegateISV = delegatetmp
            self.callFirstInitDelegateMethod()
        }
    }
    
    /** 
        Append the three main views for star
     */
    func callFirstInitDelegateMethod() {
        self.numberOfElements = self.delegateISV!.numberOfElementsInInfiniteScrollView()
        
        for index in 0..<3 {
            var view:UIView? = nil
            switch index {
            case 0:
                view = self.delegateISV?.infiniteScrollView(self, forIndex: self.numberOfElements-1)
            case 1:
                view = self.delegateISV?.infiniteScrollView(self, forIndex: 0)
            case 2:
                view = self.delegateISV?.infiniteScrollView(self, forIndex: 1)
            default:
                break
            }
            
            self.addSubview(view!)
            self.viewsArray.append(view!)
        }
    }
    
    /** 
        
     */
    func updateLayoutFrames() {
        let scrollViewSize = self.frame.size
        self.contentSize = CGSizeMake((scrollViewSize.width*3), self.contentSize.height)
        //print("viewsArray \(self.viewsArray!)")
        self.viewsArray![0].frame = CGRectMake(0,0,scrollViewSize.width,scrollViewSize.height)
        self.viewsArray![1].frame = CGRectMake(scrollViewSize.width,0,scrollViewSize.width,scrollViewSize.height)
        self.viewsArray![2].frame = CGRectMake(scrollViewSize.width*2,0,scrollViewSize.width,scrollViewSize.height)
        self.contentOffset = CGPointMake(self.frame.size.width, 0)
    }
    

}

// MARK: - ScrollViewDelegate

extension InfiniteScrollView: UIScrollViewDelegate {
   
    func scrollViewDidScroll(scrollView:UIScrollView) {
        let scrollViewSize:CGSize = self.frame.size
        print("content offset \(scrollView.contentOffset.x)")
        
        if scrollView.contentOffset.x >= scrollViewSize.width*2 {
            if self.currentItemIndex >= self.numberOfElements-1 {
                self.currentItemIndex = 0
            } else {
                self.currentItemIndex!++
            }
            
            self.contentOffset = CGPointMake(scrollViewSize.width, 0)
            
            self.viewsArray[0].frame = CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)
            self.viewsArray[1].frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)
            self.viewsArray[2].frame = CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)
            
            var tempView:UIView = self.viewsArray![0]
            
            var newIndex = 0
            if self.currentItemIndex == self.numberOfElements-1 {
                newIndex = 0
            } else {
                newIndex = self.currentItemIndex+1
            }
            
            let newTempView:UIView = self.delegateISV!.infiniteScrollView(self, forIndex: newIndex)
            newTempView.frame = tempView.frame
            tempView.removeFromSuperview()
            //tempView = nil
            self.addSubview(newTempView)
            tempView = newTempView
            
            self.viewsArray![0] = self.viewsArray![1]
            self.viewsArray![1] = self.viewsArray![2]
            self.viewsArray![2] = tempView
            
        } else if scrollView.contentOffset.x <= 0{
            
            if self.currentItemIndex <= 0 {
                self.currentItemIndex = self.numberOfElements-1
            } else {
                self.currentItemIndex!--
            }
            
            self.contentOffset = CGPointMake(scrollViewSize.width, 0)
            
            self.viewsArray![2].frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)
            self.viewsArray![0].frame = CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)
            self.viewsArray![1].frame = CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)
            
            var tempView:UIView = self.viewsArray![2]
            
            var newIndex = 0
            if self.currentItemIndex == 0 {
                newIndex = self.numberOfElements-1
            } else {
                newIndex = self.currentItemIndex-1
            }
            
            let newTempView:UIView = self.delegateISV!.infiniteScrollView(self, forIndex: newIndex)
            newTempView.frame = tempView.frame
            tempView.removeFromSuperview()
            //tempView = nil
            self.addSubview(newTempView)
            tempView = newTempView
            
            self.viewsArray[2] = self.viewsArray[1]
            self.viewsArray[1] = self.viewsArray[0]
            self.viewsArray[0] = tempView
        }
        
        
    }

}
