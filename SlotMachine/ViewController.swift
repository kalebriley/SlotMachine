//
//  ViewController.swift
//  SlotMachine
//
//  Created by User on 5/25/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel: UILabel!
    
    let kMarginOfVIew: CGFloat = 10.0
    let kSixth: CGFloat = 1.0/6.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpViewContainers()
        self.setupFirstContainer(firstContainer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViewContainers(){
        self.firstContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginOfVIew, self.view.bounds.origin.y, self.view.bounds.width - (2 * kMarginOfVIew), self.view.bounds.height * kSixth))
        
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(firstContainer)
        
        self.secondContainer = UIView(frame: CGRectMake(self.view.frame.origin.x + kMarginOfVIew,
            self.view.frame.origin.y + self.firstContainer.frame.size.height, self.view.bounds.width - (2 * kMarginOfVIew), self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(secondContainer)
        
        self.thirdContainer = UIView(frame: CGRectMake(self.view.frame.origin.x + kMarginOfVIew, firstContainer.bounds.height + secondContainer.bounds.height, self.view.bounds.width - (2 * kMarginOfVIew), self.view.frame.height * kSixth))
        thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRectMake(self.view.frame.origin.x + kMarginOfVIew, firstContainer.bounds.height + secondContainer.bounds.height + thirdContainer.bounds.height, self.view.bounds.width - (2 * kMarginOfVIew), self.view.frame.height * kSixth))
        fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(fourthContainer)
        
    }
    
    func setupFirstContainer(containerView: UIView){
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(titleLabel)
        
    }


}
