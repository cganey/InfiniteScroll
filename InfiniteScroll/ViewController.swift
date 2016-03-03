//
//  ViewController.swift
//  InfiniteScroll
//
//  Created by Werik on 2/03/16.
//  Copyright © 2016 InfiniteScroll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dummy:[AnyObject]!
    @IBOutlet weak var infiniteScroll: InfiniteScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dummy = [UIColor.redColor(),UIColor.blackColor(),UIColor.blueColor(),UIColor.greenColor(),UIColor.yellowColor()]
        self.infiniteScroll.delegateISV = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        self.infiniteScroll.updateLayoutFrames()
    }


}

extension ViewController:InfiniteScrollViewDelegate {
    
    func numberOfElementsInInfiniteScrollView() -> Int {
        return self.dummy.count
    }
    
    func infiniteScrollView(infiniteScrollView: InfiniteScrollView, forIndex index: Int) -> UIView {
        let uiView = UIView()
        uiView.backgroundColor = self.dummy![index] as? UIColor
        return uiView
    }
    
    

}

