//
//  SliderDosThumbs.swift
//  CloudView
//
//  Created by Julian Post on 12/26/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

@IBDesignable class UIXRangeSlider: UIControl
{
    override var isEnabled : Bool
        {
        didSet {
            updateAllElements()
        }
    }
    
    var barHeight : CGFloat = 2.0
        {
        didSet {
            self.updateImageForElement(.inactiveBar)
            self.updateImageForElement(.activeBar)
        }
    }
    
    /////////////////////////////////////////////////////
    // Component views
    /////////////////////////////////////////////////////
    var inactiveBarView:UIImageView = UIImageView()
    var activeBarView:UIImageView = UIImageView()
    var leftThumbView:UIImageView = UIImageView()
    var rightThumbView:UIImageView = UIImageView()
    //var middleThumbView:UIImageView = UIImageView()
    
    
    /////////////////////////////////////////////////////
    // Values
    /////////////////////////////////////////////////////
    @IBInspectable var minimumValue:Float = 0.0
        {
        didSet {
            if (minimumValue > maximumValue)
            {
                minimumValue = maximumValue
            }
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var maximumValue:Float = 364.0
        {
        didSet {
            if (maximumValue < minimumValue)
            {
                maximumValue = minimumValue
            }
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var leftValue:Float = 50.0
        {
        didSet {
            if (leftValue <= self.minimumValue)
            {
                leftValue = self.minimumValue
            }
            
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var rightValue:Float = 250.0
        {
        didSet {
            if (rightValue >= self.maximumValue)
            {
                rightValue = self.maximumValue
            }
            
            self.setNeedsLayout()
        }
    }
    
    /////////////////////////////////////////////////////
    // Tracking
    /////////////////////////////////////////////////////
    enum ElementTracked
    {
        case none
        case leftThumb
       // case middleThumb
        case rightThumb
    }
    
    var trackedElement = ElementTracked.none
    
    var movingLeftThumb : Bool = false
    //var movingMiddleThumb : Bool = false
    var movingRightThumb : Bool = false
    
    var previousLocation : CGPoint!
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.commonInit()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    override func awakeFromNib()
    {
        self.commonInit()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func commonInit()
    {
        setTint(UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0), forElement: .activeBar, forControlState: UIControlState())
        self.configureDefaultLeftThumbView(self.leftThumbView)
        self.configureDefaultRightThumbView(self.rightThumbView)
        self.configureDefaultActiveBarView(self.activeBarView)
        self.configureDefaultInactiveBarView(self.inactiveBarView)
        //self.configureDefaultMiddleThumbView(self.middleThumbView)
        self.allocateDefaultViews()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func allocateDefaultViews()
    {
        self.orderSubviews()
        
        self.setNeedsLayout()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func orderSubviews()
    {
        for view in self.subviews as [UIView]
        {
            view.removeFromSuperview()
        }
        
        self.addSubview(self.inactiveBarView)
        self.addSubview(self.activeBarView)
        self.addSubview(self.leftThumbView)
        //self.addSubview(self.middleThumbView)
        self.addSubview(self.rightThumbView)
    }
    
    enum UIXRangeSliderElement : UInt {
        case leftThumb = 0
        case rightThumb
       // case middleThumb
        case activeBar
        case inactiveBar
    }
    
    typealias stateImageDictionary = [UInt : UIImage]
    var elementImages : [UInt : stateImageDictionary] = [:]
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func stateImageDictionaryForElement(_ element : UIXRangeSliderElement) -> stateImageDictionary?
    {
        return elementImages[element.rawValue]
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func setImage(_ image : UIImage?, forElement element : UIXRangeSliderElement, forControlState state :UIControlState)
    {
        var dict = self.stateImageDictionaryForElement(element)
        if (dict == nil)
        {
            dict = stateImageDictionary()
            elementImages[element.rawValue] = dict
        }
        elementImages[element.rawValue]![state.rawValue] = image
        //dict![state.rawValue] = image
        self.updateImageForElement(element)
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func image(forElement element: UIXRangeSliderElement, forState state :UIControlState) -> UIImage?
    {
        var result : UIImage? = nil
        if let imageDict = self.stateImageDictionaryForElement(element)
        {
            result = imageDict[state.rawValue]
        }
        return result
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func imageForCurrentState(_ element : UIXRangeSliderElement) -> UIImage?
    {
        let image : UIImage? = self.image(forElement: element, forState: self.state) ?? self.image(forElement: element, forState: UIControlState())
        return image
    }
    
    typealias stateTintDictionary = [UInt : UIColor]
    var elementTints : [UInt : stateTintDictionary] = [:]
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func stateTintDictionaryForElement(_ element : UIXRangeSliderElement) -> stateTintDictionary?
    {
        return elementTints[element.rawValue]
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func setTint(_ tint : UIColor, forElement element : UIXRangeSliderElement, forControlState state :UIControlState)
    {
        var dict = self.stateTintDictionaryForElement(element)
        if (dict == nil)
        {
            dict = stateTintDictionary()
            elementTints[element.rawValue] = dict
        }
        elementTints[element.rawValue]![state.rawValue] = tint
        self.updateImageForElement(element)
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func tint(forElement element: UIXRangeSliderElement, forState state :UIControlState) -> UIColor?
    {
        var result : UIColor? = nil
        if let tintDict = self.stateTintDictionaryForElement(element)
        {
            result = tintDict[state.rawValue]
        }
        return result
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func tintForCurrentState(_ element : UIXRangeSliderElement) -> UIColor
    {
        let color = self.tint(forElement: element, forState: self.state) ?? self.tint(forElement: element, forState: UIControlState())
        return color ?? UIColor.gray
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func updateAllElements()
    {
        updateImageForElement(.leftThumb)
        updateImageForElement(.rightThumb)
        //updateImageForElement(.middleThumb)
        updateImageForElement(.activeBar)
        updateImageForElement(.inactiveBar)
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func updateImageForElement(_ element : UIXRangeSliderElement)
    {
        let state = self.isEnabled ? UIControlState() : UIControlState.disabled
        
        switch element
        {
        case .leftThumb:
            self.leftThumbView.image = imageForCurrentState(element)
            if self.leftThumbView.image == nil
            {
                self.configureDefaultLeftThumbView(self.leftThumbView)
            }
            else
            {
                if let sublayers = self.leftThumbView.layer.sublayers
                {
                    for layer in sublayers
                    {
                        layer.removeFromSuperlayer()
                    }
                }
            }
            self.leftThumbView.tintColor = tint(forElement: element, forState: state)
            self.setNeedsLayout()
            
        case .rightThumb:
            self.rightThumbView.image = imageForCurrentState(element)
            if self.rightThumbView.image == nil
            {
                self.configureDefaultRightThumbView(self.rightThumbView)
            }
            else
            {
                if let sublayers = self.rightThumbView.layer.sublayers
                {
                    for layer in sublayers
                    {
                        layer.removeFromSuperlayer()
                    }
                }
            }
            self.rightThumbView.tintColor = tint(forElement: element, forState: state)
            self.setNeedsLayout()
            
       /* case .middleThumb:
            self.middleThumbView.image = imageForCurrentState(element)
            if self.middleThumbView.image == nil
            {
                self.configureDefaultMiddleThumbView(self.middleThumbView)
            }
            else
            {
                self.middleThumbView.backgroundColor = UIColor.clear
                self.middleThumbView.frame = CGRect(x: 0,y: 0, width: self.middleThumbView.image!.size.width, height: self.middleThumbView.image!.size.height)
            }
            self.middleThumbView.tintColor = tint(forElement: element, forState: state)
            self.setNeedsLayout()*/
            
        case .activeBar:
            self.activeBarView.image = imageForCurrentState(element)
            if self.activeBarView.image == nil
            {
                self.configureDefaultActiveBarView(self.activeBarView)
            }
            else
            {
                self.activeBarView.backgroundColor = UIColor.clear
                self.activeBarView.frame = CGRect(x: 0,y: 0, width: self.activeBarView.image!.size.width, height: self.activeBarView.image!.size.height)
            }
            self.activeBarView.tintColor = tint(forElement: element, forState: state)
            self.setNeedsLayout()
            
        case .inactiveBar:
            self.inactiveBarView.image = imageForCurrentState(element)
            if self.inactiveBarView.image == nil
            {
                self.configureDefaultInactiveBarView(self.inactiveBarView)
            }
            else
            {
                self.inactiveBarView.backgroundColor = UIColor.clear
                self.inactiveBarView.frame = CGRect(x: 0,y: 0, width: self.inactiveBarView.image!.size.width, height: self.inactiveBarView.image!.size.height)
            }
            self.inactiveBarView.tintColor = tint(forElement: element, forState: state)
            self.setNeedsLayout()
        }
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func currentLeftThumbImage() -> UIImage?
    {
        return leftThumbView.image!;
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func currentRightThumbImage() -> UIImage?
    {
        return rightThumbView.image!;
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    /*func currentMiddleThumbImage() -> UIImage?
    {
        return middleThumbView.image!;
    }*/
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func currentActiveBarImage() -> UIImage?
    {
        return activeBarView.image!;
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func currentInactiveBarImage() -> UIImage?
    {
        return inactiveBarView.image!;
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    override func layoutSubviews()
    {
        let viewCenter = self.convert(self.center, from: self.superview)
        self.inactiveBarView.center.y = viewCenter.y
        var frame = self.inactiveBarView.frame
        frame.origin.x = self.leftThumbView.frame.width
        frame.size.width = self.bounds.width - (self.leftThumbView.bounds.width + self.rightThumbView.bounds.width)
        self.inactiveBarView.frame = frame
        
        self.leftThumbView.center.y = viewCenter.y
        self.positionLeftThumb()
        self.rightThumbView.center.y = viewCenter.y
        self.positionRightThumb()
        
        /*self.middleThumbView.center.y = viewCenter.y
        frame = self.middleThumbView.frame
        frame.origin.x = self.leftThumbView.frame.maxX
        frame.size.width = self.rightThumbView.frame.minX - frame.origin.x
        self.middleThumbView.frame = frame*/
        
        self.activeBarView.center.y = viewCenter.y
        frame = self.activeBarView.frame
        frame.origin.x = self.leftThumbView.frame.maxX
        frame.size.width = self.rightThumbView.frame.minX - frame.origin.x
        self.activeBarView.frame = frame
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func positionLeftThumb()
    {
        let pos = positionForValue(self.leftValue)
        var frame = self.leftThumbView.frame
        frame.origin.x = CGFloat(pos - self.leftThumbView.bounds.width)
        self.leftThumbView.frame = frame;
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func positionRightThumb()
    {
        let pos = CGFloat(positionForValue(self.rightValue))
        var frame = self.rightThumbView.frame
        frame.origin.x = CGFloat(pos)
        self.rightThumbView.frame = frame;
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func positionForValue(_ value:Float) -> CGFloat
    {
        let pos = Float(self.inactiveBarView.frame.width) * (value - self.minimumValue) / (self.maximumValue - self.minimumValue) +  Float(self.inactiveBarView.frame.origin.x)
        return CGFloat(pos)
    }
}

// MARK: -- Tracking --
extension UIXRangeSlider
{
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool
    {
        previousLocation = touch.location(in: self)
        
        // Hit test the thumb layers
        if leftThumbView.frame.contains(previousLocation)
        {
            trackedElement = .leftThumb
        }
        else if rightThumbView.frame.contains(previousLocation)
        {
            trackedElement = .rightThumb
        }
       /* else if middleThumbView.frame.contains(previousLocation)
        {
            trackedElement = .middleThumb
        }*/
        
        return trackedElement != .none
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool
    {
        let location = touch.location(in: self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (Double(maximumValue) - Double(minimumValue)) * deltaLocation / Double(bounds.width /*- thumbWidth*/)
        
        switch trackedElement
        {
        case .leftThumb:
            handleLeftThumbMove(location, delta: deltaValue)
      /*  case .middleThumb:
            handleMiddleThumbMove(location, delta: deltaValue)*/
        case .rightThumb:
            handleRightThumbMove(location, delta: deltaValue)
        default:
            break
        }
        
        previousLocation = location
        
        return true
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func handleLeftThumbMove(_ location:CGPoint, delta:Double)
    {
        let translation = CGPoint(x: location.x - previousLocation.x,y: location.y - previousLocation.y)
        let range = self.maximumValue - self.minimumValue
        let availableWidth = self.inactiveBarView.frame.width
        
        let newValue = self.leftValue + Float(translation.x) / Float(availableWidth) * range
        
        self.leftValue = newValue
        
        if (self.leftValue < minimumValue)
        {
            self.leftValue = minimumValue
        }
        
        if (self.leftValue > self.rightValue)
        {
            self.leftValue = self.rightValue
        }
        self.sendActions(for: UIControlEvents.valueChanged)
        
        self.setNeedsLayout()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    /*func handleMiddleThumbMove(_ location:CGPoint, delta:Double)
    {
        let translation = CGPoint(x: location.x - previousLocation.x,y: location.y - previousLocation.y)
        let range = self.maximumValue - self.minimumValue
        let availableWidth = self.inactiveBarView.frame.width
        let diff = self.rightValue - self.leftValue
        
        let newLeftValue = self.leftValue + Float(translation.x) / Float(availableWidth) * range
        if (newLeftValue < minimumValue)
        {
            self.leftValue = self.minimumValue
            self.rightValue = self.leftValue + diff
        }
        else
        {
            let newRightValue = self.rightValue + Float(translation.x) / Float(availableWidth) * range
            if (newRightValue > self.maximumValue)
            {
                self.rightValue = self.maximumValue
                self.leftValue = self.rightValue - diff
            }
            else
            {
                self.leftValue = newLeftValue
                self.rightValue = self.leftValue + diff
            }
        }
        
        self.sendActions(for: UIControlEvents.valueChanged)
        self.setNeedsLayout()
    }*/
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    func handleRightThumbMove(_ location:CGPoint, delta:Double)
    {
        let translation = CGPoint(x: location.x - previousLocation.x,y: location.y - previousLocation.y)
        let range = self.maximumValue - self.minimumValue
        let availableWidth = self.inactiveBarView.frame.width
        let newValue = self.rightValue + Float(translation.x) / Float(availableWidth) * range
        
        self.rightValue = newValue
        
        if (self.rightValue > self.maximumValue)
        {
            self.rightValue = self.maximumValue
        }
        
        if (self.rightValue < self.leftValue)
        {
            self.rightValue = self.leftValue
        }
        self.sendActions(for: UIControlEvents.valueChanged)
        
        self.setNeedsLayout()
    }
    
    /////////////////////////////////////////////////////
    //
    /////////////////////////////////////////////////////
    override func endTracking(_ touch: UITouch?, with event: UIEvent?)
    {
        trackedElement = .none
    }
    
}

// MARK: -- DefaultViews --
extension UIXRangeSlider
{
    func configureDefaultLeftThumbView(_ view : UIImageView)
    {
        view.image = nil
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let path = UIBezierPath(arcCenter: CGPoint(x: 20, y: 20), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        path.close()
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 0.25
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: -3.0, height: 4.0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 2.0
        view.layer.addSublayer(layer)
        view.isUserInteractionEnabled = false
        view.tintColor = UIColor.gray
    }
    
    func configureDefaultRightThumbView(_ view : UIImageView)
    {
        view.image = nil
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let path = UIBezierPath(arcCenter: CGPoint(x: 20, y: 20), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: false)
        path.close()
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 0.25
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
        layer.shadowColor = UIColor.gray.cgColor
        view.layer.addSublayer(layer)
        view.isUserInteractionEnabled = false
    }
    
   /* func configureDefaultMiddleThumbView(_ view : UIImageView)
    {
        view.image = nil
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 27)
        view.backgroundColor = self.tintForCurrentState(.middleThumb)
        view.layer.opacity = 0.5
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 2.0
        view.isUserInteractionEnabled = false
    }*/
    
    func configureDefaultActiveBarView(_ view : UIImageView)
    {
        view.image = nil
        view.frame = CGRect(x: 0, y: 0, width: 2, height: self.barHeight)
        view.backgroundColor = self.tintForCurrentState(.activeBar)
        view.isUserInteractionEnabled = false
    }
    
    func configureDefaultInactiveBarView(_ view : UIImageView)
    {
        view.image = nil
        view.frame = CGRect(x: 0, y: 0, width: 2, height: self.barHeight)
        view.backgroundColor = self.tintForCurrentState(.inactiveBar)
        view.isUserInteractionEnabled = false
    }
}
