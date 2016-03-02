//
//  InfiniteScrollView.swift
//  InfiniteScroll
//
//  Created by Werik on 2/03/16.
//  Copyright © 2016 InfiniteScroll. All rights reserved.
//

import UIKit

enum InfiniteScrollViewViewPosition:Int {
    case InfiniteScrollViewViewPositionHiddenLeft = 0
    case InfiniteScrollViewViewPositionVisible = 1
    case InfiniteScrollViewViewPositionHiddenRight = 2
}

protocol InfiniteScrollViewDelegate: class {
    func numberOfElementsInInfiniteScrollView() -> Int
    func infiniteScrollView(infiniteScrollView:InfiniteScrollView, forIndex index:Int) -> UIView
}

class InfiniteScrollView: UIScrollView {
    weak var delegateISV:InfiniteScrollViewDelegate?
    var view1:UIView!
    var view2:UIView!
    var view3:UIView!
    var viewsArray:[AnyObject]!
    var numberOfElements:Int!
    var currentItemIndex:Int!
    
    //public
    class func updateLayoutFrames() {

    }
    
    func configScrollViewViews() {
        self.viewsArray = []
        self.pagingEnabled = true
        self.currentItemIndex = 0
    }
    
    func setDelegateISV(delegate:InfiniteScrollViewDelegate) {
        self.delegateISV = delegate
        self.callFirstInitDelegateMethod()
    }
    
    func callFirstInitDelegateMethod() {
        self.numberOfElements = self.delegateISV!.numberOfElementsInInfiniteScrollView()
        
        var view:UIView? = nil
        for index in 0..<3 {
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
        }
        
        self.addSubview(view!)
        self.viewsArray.append(view!)
    }
    
    func updateLayoutFrames() {
        let scrollViewSize = self.frame.size
        self.contentSize = CGSizeMake((scrollViewSize.width*3), self.contentSize.height)
        
    }
    
    
    
    
    
    
    /*
    - (void) updateLayoutFrames {
    CGSize scrollViewSize = self.frame.size;
    self.contentSize = CGSizeMake((scrollViewSize.width*3), self.contentSize.height);
    [[self.viewsArray objectAtIndex:0] setFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
    [[self.viewsArray objectAtIndex:1] setFrame:CGRectMake(scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
    [[self.viewsArray objectAtIndex:2] setFrame:CGRectMake(scrollViewSize.width*2, 0, scrollViewSize.width, scrollViewSize.height)];
    self.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    */
    
}

extension InfiniteScrollView: InfiniteScrollViewDelegate {
    
    func numberOfElementsInInfiniteScrollView() -> Int{
        return self.currentItemIndex
    }
    
    
}
