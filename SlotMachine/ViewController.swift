//
//  ViewController.swift
//  SlotMachine
//
//  Created by User on 5/25/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Contianer Views
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    // Slot Machine title
    var titleLabel: UILabel!
    
    // Information labels
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    
    // Starting values
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    // Buttons for 
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    // slots
    var slots : [[Slot]] = []
    
    // Margins
    let kMarginForView: CGFloat = 10.0
    let kMarginForSlot: CGFloat = 2.0
    
    // fractions of the Screen
    let kSixth: CGFloat = 1.0/6.0
    let kThird: CGFloat = 1.0/3.0
    let kHalf: CGFloat = 1.0/2.0
    let kEigth: CGFloat = 1.0/8.0
    
    // Slot Machine Components
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpViewContainers()
        self.setupFirstContainer(self.firstContainer)
        self.setupThirdContainer(self.thirdContainer)
        self.setupFourthContainer(self.fourthContainer)
       
        self.hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark- Button Functions
    
    func resetButtonPressed(sender: UIButton){
        println("reset button pressed")
        self.hardReset()
    }
    
    func betOneButtonPressed(sender: UIButton){
        println("bet one button pressed")
        
        if credits <= 0 {
            self.showAlertWithText(header: "No more Credits", message: "Reset Game")
        }else{
            if currentBet >= 5 {
                self.showAlertWithText(message: "You can only bet 5 credits at a time")
            }else{
                self.currentBet += 1
                self.credits -= 1
                
                self.updateMainView()
            }
        }
    }
    
    func betMaxButtonPressed(sender: UIButton){
        println("bet Max button pressed")
        if credits < 5 {
            self.showAlertWithText(message: "You don't have enough credits")
        }else{
            if currentBet >= 5 {
                self.showAlertWithText(message: "Max Bet reached")
            }else{
                let betThis = 5 - currentBet
                currentBet += betThis
                credits -= betThis
                
                updateMainView()
            }
        
        }
    }
    
    func spinButtonPressed(sender: UIButton){
        if currentBet != 0 {
            self.removeSlotImageViews()
            println("spin button pressed") // Debugging purposes
            slots = Factory.createSlots()
            self.setupSecondContainer(secondContainer)
            
            var winningsMuliplier = SlotBrain.computeWinnings(self.slots)
            winnings = currentBet * winningsMuliplier
            credits += winnings
            currentBet = 0
            
            updateMainView()
        }else{
            self.showAlertWithText(message: "You must bet something.")
        }
        
    }
    
    // Mark - Setup Containers
    
    func setUpViewContainers(){
        // Initialize and draw containers
        
        self.firstContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.view.bounds.origin.y, self.view.bounds.width - (2 * kMarginForView), self.view.bounds.height * kSixth))
        
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(firstContainer)
        
        self.secondContainer = UIView(frame: CGRectMake(self.view.frame.origin.x + kMarginForView,
            self.view.frame.origin.y + self.firstContainer.frame.size.height, self.view.bounds.width - (2 * kMarginForView), self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(secondContainer)
        
        self.thirdContainer = UIView(frame: CGRectMake(self.view.frame.origin.x + kMarginForView, firstContainer.bounds.height + secondContainer.bounds.height, self.view.bounds.width - (2 * kMarginForView), self.view.frame.height * kSixth))
        thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRectMake(self.view.frame.origin.x + kMarginForView, firstContainer.bounds.height + secondContainer.bounds.height + thirdContainer.bounds.height, self.view.bounds.width - (2 * kMarginForView), self.view.frame.height * kSixth))
        fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(fourthContainer)
        
    }
    
    func setupFirstContainer(containerView: UIView){
        // Add componnets to first container
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(titleLabel)
        
    }
    
    
    func setupSecondContainer(containerView: UIView){
        // Add components to second container
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++ {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++ {
                
                var slot: Slot
                var slotImageView = UIImageView()
                
                if self.slots.count != 0 {
                    let slotContainer = self.slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }else{
                
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupThirdContainer(containerView: UIView){
        // Add componets to third container
        
        // Setup credits label
        self.creditsLabel = UILabel()
        creditsLabel.text = "000000"
        creditsLabel.textColor =  UIColor.redColor()
        creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth * 0.5, y: containerView.frame.height * kThird)
        creditsLabel.sizeToFit()
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menolo-Bold", size: 16)
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 2.6, y: containerView.frame.height * kThird)
        self.betLabel.sizeToFit()
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        self.betLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 4.5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * 2 * kThird)
        containerView.addSubview(self.winnerPaidTitleLabel)
        
        
    }
    
    func setupFourthContainer(containerView: UIView){
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEigth, y: containerView.frame.height * kHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * kEigth * 3, y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * kEigth * 5, y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * kEigth * 7, y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
        
        
    }
    
    // Mark - Helper functions
    
    func removeSlotImageViews(){
        if self.secondContainer != nil {
            var container: UIView? = self.secondContainer
            var subViewArray: Array? = container!.subviews
            for subview in subViewArray! {
                subview.removeFromSuperview()
            }
        }
    }
    
    func hardReset(){
        self.removeSlotImageViews()
        self.slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        self.credits = 50
        self.winnings = 0
        self.currentBet = 0
        self.updateMainView()
        
    }
    
    func updateMainView(){
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText(header: String = "Warning", message: String){
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
