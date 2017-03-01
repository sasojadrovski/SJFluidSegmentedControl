//
//  SJFluidSegmentedControl.swift
//  SJFluidSegmentedControl
//
//  Created by Sasho Jadrovski on 9/22/16.
//  Copyright © 2016 Sasho Jadrovski. All rights reserved. [http://jadrovski.com]
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation
import UIKit

/// The transition style between the default and selected state of a segment.
///
/// - none:  No transition. This style is preferred if using a custom transition provided by a delegate implementation.
/// - slide: Selected segment view cut by selection is shown on top of the default segment view.
/// - fade:  Selected segment alpha is changing to 1.0 and default segment view alpha to 0.0 based on the current position of the selection.
@objc public enum SJFluidSegmentedControlTransitionStyle: Int {
    case none, slide, fade
}

/// The selection shape style.
///
/// - roundedRect: Rounded rectangle shape.
/// - liquid:      Liquid shape.
@objc public enum SJFluidSegmentedControlShapeStyle: Int {
    case roundedRect, liquid
}

/// The bounce location.
///
/// - left:  Left bounce.
/// - right: Right bounce.
@objc public enum SJFluidSegmentedControlBounce: Int {
    case left, right
}

/// SJFluidSegmentedControl Data Source Protocol
@objc public protocol SJFluidSegmentedControlDataSource: class {
    
    /// **Required.** Tells the data source to return the number of segments in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object requesting this information.
    ///
    /// - returns: The number of segments.
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int
    
    /// Asks the data source for the gradient colors of a selected segment in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the gradient colors.
    /// - parameter index:            An index number identifying a segment of a `segmentedControl`.
    ///
    /// - returns: An array of colors to form a gradient.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor]
    
    /// Asks the data source for the gradient colors for bounce in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the gradient colors.
    /// - parameter bounce:           The bounce type.
    ///
    /// - returns: An array of colors to form a gradient.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor]
    
    /// Asks the data source for the title of a segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the title.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: A string to use as the title of a segment. If you return `nil`, the segment will have no title.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         titleForSegmentAtIndex index: Int) -> String?
    
    /// Asks the data source for an attributed title of a segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the attributed title.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: An attributed string to use as the title of a segment. If you return `nil`, the segment will have no title.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         attributedTitleForSegmentAtIndex index: Int) -> NSAttributedString?
    
    /// Asks the data source for the title of a selected segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the title.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: A string to use as the title of the selected segment. If you return `nil`, the segment will have no title.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         titleForSelectedSegmentAtIndex index: Int) -> String?
    
    /// Asks the data source for the attributed title of a selected segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the attributed title.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: An attributed string to use as the title of the selected segment. If you return `nil`, the segment will have no title.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         attributedTitleForSelectedSegmentAtIndex index: Int) -> NSAttributedString?
    
    /// Asks the data source for a color for the title of a selected segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the selected title color.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: A color to use as a foreground color for the selected segment's title.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         titleColorForSelectedSegmentAtIndex index: Int) -> UIColor
    
    /// Asks the data source for a view of a segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the view.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: A view for the segment.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         viewForSegmentAtIndex index: Int) -> UIView
    
    /// Asks the data source for a view of a selected segment at an index in a segmented control.
    ///
    /// - parameter segmentedControl: The segmented control object asking for the view.
    /// - parameter index:            An index number identifying a segment of `segmentedControl`.
    ///
    /// - returns: A view for the selected segment.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         viewForSelectedSegmentAtIndex index: Int) -> UIView
}

/// SJFluidSegmentedControl Delegate Protocol
@objc public protocol SJFluidSegmentedControlDelegate: class {
    
    /// Tells the delegate that the segmented control's selected segment index changed.
    ///
    /// - parameter segmentedControl: A segmented control object informing the delegate about the new index change.
    /// - parameter fromIndex:        The segment index **from** which the selection changed.
    /// - parameter toIndex:          The segment index **to** which the selection changed.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         didChangeFromSegmentAtIndex fromIndex: Int,
                                         toSegmentAtIndex toIndex:Int)
    
    /// Tells the delegate the the segmented control's selected segment index is about to be changed.
    ///
    /// - parameter segmentedControl: A segmented control object informing the delegate about the impending index change.
    /// - parameter fromSegment:      The segment index **from** which the selection changed.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         willChangeFromSegment fromSegment: Int)
    
    /// Tells the delegate that the segmented control's offset changed.
    ///
    /// - parameter segmentedControl: The segmented control object that performed the scrolling operation.
    /// - parameter offset:           The `x` coordinate of the offset.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         didScrollWithXOffset offset: CGFloat)
    
    /// Asks the delegate to setup a segment with a custom transition style.
    ///
    /// - parameter segmentedControl:      The segmented control object asking for the custom transition.
    /// - parameter segmentIndex:          The index of the segment to setup.
    /// - parameter unselectedSegmentView: The view for the unselected (default) state of the segment.
    /// - parameter selectedSegmentView:   The view for the selected state of the segment.
    /// - parameter percent:               The selection's percentage. This value is in range [-1..1]. The value -1 represents a state in which the selection's right edge is coincident with the left edge of a segment. Values from -1 to 0 represent states in which the selection's right edge is moving from the left edge to the right edge of a segment. The value 0 represents a fully selected state. Values from 0 to 1 represent states in which the selection's left edge is moving from the left edge to the right edge of a segment. Value 1 represents a state in which the selection's left edge is coincident with the right edge of a segment.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         setupSegmentAtIndex segmentIndex: Int,
                                         unselectedView unselectedSegmentView: UIView,
                                         selectedView selectedSegmentView: UIView,
                                         withSelectionPercent percent: CGFloat)
    
    /// Asks the delegate to reset all customization that has been done in segmentedControl(_:setupSegmentAtIndex:unselectedView:selectedView:withSelectionPercent:). This method is intended for handling switching between transition styles.
    ///
    /// - parameter segmentedControl:      The segmented control object asking the reset.
    /// - parameter segmentIndex:          The index of the segment to reset.
    /// - parameter unselectedSegmentView: The view for the unselected (default) state of the segment.
    /// - parameter selectedSegmentView:   The view for the selected state of the segment.
    @objc optional func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         resetSegmentAtIndex segmentIndex: Int,
                                         unselectedView unselectedSegmentView: UIView,
                                         selectedView selectedSegmentView: UIView)
}

/// A segmented control with custom appearance and interactive animations.
public class SJFluidSegmentedControl: UIView, UIGestureRecognizerDelegate {
    
    // MARK: Public properties
    
    /// The object that acts as the data source of the segmented control.
    @IBOutlet weak open var dataSource: AnyObject? {
        didSet {
            if let ds = dataSource {
                if let ds = (ds as? SJFluidSegmentedControlDataSource) {
                    dataSource = ds
                    reloadData()
                } else {
                    assertionFailure("\(ds) does not implement SJFluidSegmentedControlDataSource protocol.")
                }
            }
        }
    }
    
    /// The object that acts as the delegate of the segmented control.
    @IBOutlet weak open var delegate: AnyObject? {
        didSet {
            if let d = delegate {
                if let d = (d as? SJFluidSegmentedControlDelegate) {
                    delegate = d
                } else {
                    assertionFailure("\(d) does not implement SJFluidSegmentedControlDelegate protocol.")
                }
            }
        }
    }
    
    /// The index of the currently selected segment. It ranges from 0 to segmentsCount-1.
    open var currentSegment: Int = 0 {
        didSet {
            if currentSegment != oldValue {
                setCurrentSegmentIndex(currentSegment, animated: false)
            }
        }
    }
    
    /// The number of segments in the segmented control. Default is `1`.
    fileprivate(set) public var segmentsCount: Int = 1
    
    /// The transition style between the default and selected state of the segments. Default is `.fade`.
    open var transitionStyle: SJFluidSegmentedControlTransitionStyle = .fade {
        didSet {
            if segmentsCount > 0 {
                updateTransitionStyle()
            }
        }
    }
    
    /// The style of the selecton shape. Default is `.liquid`.
    open var shapeStyle: SJFluidSegmentedControlShapeStyle = .liquid
    
    /// The corner radius of the segmented control. Default is `0.0`.
    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            scrollView.layer.cornerRadius = cornerRadius
            gradientViewContainer?.layer.cornerRadius = cornerRadius
            selectorView.layer.cornerRadius = applyCornerRadiusToSelectorView ? cornerRadius : 0.0
        }
    }
    
    /// The color of the text for the default state of a segment. Default is `.black`. This property will be overriden if the delegate for attributed titles/views is implemented.
    @IBInspectable open var textColor: UIColor = .black
    
    /// The color of the text for the selected state of a segment. Default is `.white`. This property will be overriden if the delegate for attributed titles for selected state or views for selected state is implemented.
    @IBInspectable open var selectedSegmentTextColor: UIColor = .white
    
    /// The text font for the titles of the segmented control in both states if the data source does not provide attributed titles or views. Default is `.systemFont(ofSize: 14)`.
    open var textFont: UIFont = .systemFont(ofSize: 14) {
        didSet {
            reinstallViews()
        }
    }
    
    /// The color of the selector. Default is `.clear`. **Note:** If set, it is overlayed over the gradient colors.
    @IBInspectable open var selectorViewColor: UIColor = .clear {
        didSet {
            selectorView.backgroundColor = selectorViewColor
        }
    }
    
    /// A boolean value to determine whether the selector should have rounded corners. Default is `false`.
    @IBInspectable open var applyCornerRadiusToSelectorView: Bool = false
    
    /// The color for the bounce if the data source does not provide colors for bounces. Default is `.red`.
    @IBInspectable open var gradientBounceColor: UIColor = .red
    
    /// The duration of the show shadow animation. Default is `0.5`.
    @IBInspectable open var shadowShowDuration: CGFloat = 0.5
    
    /// The duration of the hide shadow animation. Default is `0.8`.
    @IBInspectable open var shadowHideDuration: CGFloat = 0.8
    
    /// A boolean value to determine whether shadows should be applied. Default is `true`.
    @IBInspectable open var shadowsEnabled: Bool = true
    
    // MARK: - Private properties
    
    fileprivate lazy var scrollView: UIScrollView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.layer.masksToBounds = true
        self.addSubview($0)
        self.bringSubview(toFront: $0)
        return $0
    }(UIScrollView(frame: .zero))
    
    fileprivate lazy var leftSpacerView: UIView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview($0)
        return $0
    }(UIView(frame: .zero))
    
    fileprivate lazy var rightSpacerView: UIView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview($0)
        return $0
    }(UIView(frame: .zero))
    
    fileprivate lazy var selectorView: UIView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.mask = CAShapeLayer()
        self.scrollView.addSubview($0)
        $0.backgroundColor = self.selectorViewColor
        return $0
    }(UIView(frame: .zero))
    
    fileprivate lazy var leftLimiterView: UIView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview($0, aboveSubview: self.scrollView)
        let leftConstraint = NSLayoutConstraint(item: $0, attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .left,
                                                multiplier: 1.0,
                                                constant: 0.0)
        leftConstraint.priority = UILayoutPriorityDefaultHigh
        self.addConstraint(leftConstraint)
        self.addConstraint(NSLayoutConstraint(item: $0, attribute: .right,
                                              relatedBy: .equal,
                                              toItem: self.selectorView, attribute: .left,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: $0, attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self, attribute: .top,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: $0, attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self, attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 0.0))
        return $0
    }(UIView(frame: .zero))
    
    fileprivate lazy var rightLimiterView: UIView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview($0, aboveSubview: self.scrollView)
        let rightConstraint = NSLayoutConstraint(item: $0, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self, attribute: .right,
                                                 multiplier: 1.0,
                                                 constant: 0.0)
        rightConstraint.priority = UILayoutPriorityDefaultHigh
        self.addConstraint(rightConstraint)
        self.addConstraint(NSLayoutConstraint(item: $0, attribute: .left,
                                              relatedBy: .equal,
                                              toItem: self.selectorView, attribute: .right,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: $0, attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self, attribute: .top,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: $0, attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self, attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 0.0))
        return $0
    }(UIView(frame: .zero))
    
    fileprivate lazy var shadowView: UIView = {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.masksToBounds = false
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = false
        self.addSubview($0)
        self.setupConstraintsForView($0, withContainer: self)
        var constraint = NSLayoutConstraint(item: self, attribute: .left,
                                            relatedBy: .equal,
                                            toItem: $0, attribute: .left,
                                            multiplier: 1.0,
                                            constant: 0.0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: $0, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .right,
                                        relatedBy: .equal,
                                        toItem: $0, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: $0, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        return $0
    }(UIView(frame: .zero))
    
    fileprivate lazy var gradientView: SJGradientView = {
        [unowned self] in
        let fakeView = UIView(frame: .zero)
        fakeView.clipsToBounds = true
        fakeView.layer.masksToBounds = true
        fakeView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(fakeView, at: 0)
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .left,
                                              relatedBy: .equal,
                                              toItem: fakeView, attribute: .left,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .top,
                                              relatedBy: .equal,
                                              toItem: fakeView, attribute: .top,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .right,
                                              relatedBy: .equal,
                                              toItem: fakeView, attribute: .right,
                                              multiplier: 1.0,
                                              constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom,
                                              relatedBy: .equal, toItem: fakeView,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 0.0))
        let gradientView = SJGradientView(frame: .zero)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        fakeView.addSubview(gradientView)
        self.gradientViewContainer = fakeView
        return gradientView
    }()
    
    fileprivate var gradientViewContainer: UIView?
    fileprivate lazy var segmentViewContainers = [UIView]()
    fileprivate lazy var segmentViews = [UIView]()
    fileprivate lazy var selectedSegmentViewContainers = [UIView]()
    fileprivate lazy var selectedSegmentViews = [UIView]()
    fileprivate lazy var changedViews = Set<Int>()
    fileprivate var selectorViewPath: CGPath? {
        didSet {
            if selectorView.layer.mask == nil {
                selectorView.layer.mask = CAShapeLayer()
            }
            let selectorViewShapeLayer = selectorView.layer.mask as! CAShapeLayer
            selectorViewShapeLayer.path = selectorViewPath
        }
    }
    fileprivate var gradientBackVelocity: CGFloat = 1.0
    fileprivate var gradientViewLeftConstraint: NSLayoutConstraint?
    fileprivate lazy var addedConstraintsToRemove = [NSLayoutConstraint]()
    fileprivate var didViewLayoutSubviews: Bool = false
    fileprivate var wereLayoutDependantValuesUpdated = false
    
    // MARK: - Initialization
    
    /// Initializes the segmented control with a specified frame rectangle.
    ///
    /// - Parameter frame: The frame rectangle for the segmented control view, measured in points.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        initViewsAndGestureRecognizers()
    }
    
    fileprivate func initViewsAndGestureRecognizers() {
        let _ = scrollView
        let _ = leftSpacerView
        let _ = selectorView
        let _ = rightSpacerView
        let _ = leftLimiterView
        let _ = rightLimiterView
        let _ = gradientView
        let _ = shadowView
        setupTapGestureRecogniers()
    }
    
    // MARK: - View Lifecycle
    
    /// Lays out subviews.
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        didViewLayoutSubviews = true
        if !wereLayoutDependantValuesUpdated {
            updateLayoutDependantValues()
        }
    }
    
    // MARK: - Setup Gesture Recognizers
    
    fileprivate func setupTapGestureRecogniers() {
        let leftTapRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(self.tapWasRecognized(_:)))
        leftLimiterView.addGestureRecognizer(leftTapRecognizer)
        let rightTapRecognizer = UITapGestureRecognizer(target: self,
                                                        action: #selector(self.tapWasRecognized(_:)))
        rightLimiterView.addGestureRecognizer(rightTapRecognizer)
    }
    
    @objc fileprivate func tapWasRecognized(_ recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self)
        self.isUserInteractionEnabled = false
        setCurrentSegmentIndex(segmentFromTapPoint(point), animated: true)
    }
    
    // MARK: - Setup Constraints
    
    fileprivate func setupLeftSpacerViewConstraints() {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: leftSpacerView, attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .height,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: leftSpacerView, attribute: .width,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .width,
                                        multiplier: spacerViewWidthMultiplier,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: leftSpacerView, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .left,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: leftSpacerView, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: leftSpacerView, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupSelectorViewConstraints() {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: selectorView, attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .height,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: selectorView, attribute: .width,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .width,
                                        multiplier: selectorViewWidthMultiplier,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: selectorView, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: leftSpacerView, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: selectorView, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: selectorView, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupRightSpacerViewConstraints() {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: rightSpacerView, attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .height,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: rightSpacerView, attribute: .width,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .width,
                                        multiplier: spacerViewWidthMultiplier,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: rightSpacerView, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: selectorView, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: rightSpacerView, attribute: .right,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: rightSpacerView, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: rightSpacerView, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        scrollView.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupScrollViewConstraints() {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: scrollView, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .left,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: scrollView, attribute: .width,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .width,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: self, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: scrollView, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: self, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: scrollView,
                                        attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupGradientViewConstraints() {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: gradientView, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: gradientView, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: gradientView, attribute: .width,
                                        relatedBy: .equal,
                                        toItem: self, attribute: .width,
                                        multiplier: (CGFloat(segmentsCount + 2) +
                                            CGFloat(segmentsCount + 1) * gradientBackVelocity) / CGFloat(segmentsCount),
                                        constant: 0.0)
        self.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        gradientViewLeftConstraint = NSLayoutConstraint(item: gradientView, attribute: .left,
                                                        relatedBy: .equal,
                                                        toItem: self, attribute: .left,
                                                        multiplier: 1.0,
                                                        constant: 0.0)
        self.addConstraint(gradientViewLeftConstraint!)
        addedConstraintsToRemove.append(gradientViewLeftConstraint!)
    }
    
    fileprivate func setupConstraintsForFirstView(_ view: UIView) {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: view, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: view.superview, attribute: .left,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: view.superview, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view.superview, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupConstraintsForView(_ view: UIView, withPreviousView previousView: UIView) {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: view, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: previousView, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: view.superview, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view.superview, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .width,
                                        relatedBy: .equal,
                                        toItem: previousView, attribute: .width,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupConstraintsForView(_ view: UIView, withContainer container: UIView) {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: container, attribute: .left,
                                        relatedBy: .equal,
                                        toItem: view, attribute: .left,
                                        multiplier: 1.0,
                                        constant: 0.0)
        container.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: container, attribute: .top,
                                        relatedBy: .equal,
                                        toItem: view, attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        container.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: container, attribute: .right,
                                        relatedBy: .equal,
                                        toItem: view, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        container.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        constraint = NSLayoutConstraint(item: container, attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view, attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        container.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
    }
    
    fileprivate func setupRightConstraintForLastView(_ view: UIView) {
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: view, attribute: .right,
                                        relatedBy: .equal,
                                        toItem: view.superview, attribute: .right,
                                        multiplier: 1.0,
                                        constant: 0.0)
        view.superview?.addConstraint(constraint)
        addedConstraintsToRemove.append(constraint)
        
        var widthConstraintIsInstalled = false
        if let constraints = view.superview?.constraints {
            for constraint in constraints {
                if constraint.firstAttribute == .width && (constraint.firstItem as? UIView == view ||
                    constraint.secondItem as? UIView == view) {
                    widthConstraintIsInstalled = true
                }
            }
        }
        if !widthConstraintIsInstalled {
            constraint = NSLayoutConstraint(item: view, attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view.superview, attribute: .width,
                                            multiplier: 1.0,
                                            constant: 0.0)
            view.superview?.addConstraint(constraint)
            addedConstraintsToRemove.append(constraint)
        }
        
    }
    
    // MARK: - Gradient Setup
    
    fileprivate func setupGradientWithPercent(_ percent: CGFloat, offsetFactor factor: CGFloat) {
        if (gradientView.layer.mask == nil) {
            gradientView.layer.mask = CAShapeLayer()
        }
        
        let leftSideOfExpression = (-1 - factor * CGFloat(segmentsCount)) * selectorView.bounds.width *
            (1 + gradientBackVelocity)
        let rightSideOfExpression = selectorView.bounds.width * factor * CGFloat(segmentsCount)
        gradientViewLeftConstraint?.constant = leftSideOfExpression + rightSideOfExpression
        
        if let gradientViewLeftConstraint = gradientViewLeftConstraint {
            var transform = CGAffineTransform(translationX: -gradientViewLeftConstraint.constant + selectorView.bounds.width * factor * CGFloat(segmentsCount), y: 0)
            let shapeLayer = gradientView.layer.mask as! CAShapeLayer
            shapeLayer.path = pathForSelectorViewFromPercentage(percent).copy(using: &transform)
        }
    }
    
    fileprivate func setupGradientViewWithCount(_ count: Int) {
        var locations = [CGFloat]()
        var colors = [CGColor]()
        setupColors(&colors, withCount: count)
        setupLocations(&locations, withCount: count)
        let gradientViewGradientLayer = gradientView.layer as! CAGradientLayer
        gradientViewGradientLayer.locations = locations as [NSNumber]?
        gradientViewGradientLayer.colors = colors
        gradientViewGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientViewGradientLayer.endPoint = CGPoint(x: 1, y: 0)
    }
    
    fileprivate func setupColors(_ colors: inout [CGColor], withCount count: Int) {
        for index in -1 ... count {
            var segmentColors = [UIColor]()
            if index == -1 {
                segmentColors = gradientColorForBounce(.left)
            }
            if index >= 0 && index < count {
                segmentColors = gradientColorForSegmentAtIndex(index)
            }
            if index == count {
                segmentColors = gradientColorForBounce(.right)
            }
            if segmentColors.count == 0 {
                continue
            }
            for color in segmentColors {
                colors.append(color.cgColor)
            }
        }
    }
    
    fileprivate func setupLocations(_ locations: inout [CGFloat], withCount count: Int) {
        for index in -1 ... count {
            var segmentColors = [UIColor]()
            if index == -1 {
                segmentColors = gradientColorForBounce(.left)
            }
            if index >= 0 && index < count {
                segmentColors = gradientColorForSegmentAtIndex(index)
            }
            if index == count {
                segmentColors = gradientColorForBounce(.right)
            }
            if segmentColors.count == 0 {
                continue
            }
            for colorIndex in 0 ..< segmentColors.count {
                locations.append(gradientLocationForSegmentAtIndex(index,
                                                                   colorIndex: colorIndex,
                                                                   colorsCount: segmentColors.count,
                                                                   segmentsCount: count))
            }
        }
    }
    
    fileprivate func gradientColorForSegmentAtIndex(_ index: Int) -> [UIColor] {
        if let dataSource = dataSource, let gradientColors = dataSource.segmentedControl?(self, gradientColorsForSelectedSegmentAtIndex: index) {
            var array = gradientColors
            if array.count == 1 {
                array.append(array.first!)
            }
            return array
        }
        return [selectorViewColor, selectorViewColor]
    }
    
    fileprivate func gradientColorForBounce(_ bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        var colors: [UIColor]?
        colors = dataSource?.segmentedControl?(self, gradientColorsForBounce: bounce)
        if colors == nil {
            colors = [gradientBounceColor]
        }
        if colors!.count == 1 {
            colors?.append((colors?.first)!)
        }
        return colors!
    }
    
    // MARK: - Shadow Setup
    
    fileprivate func shadowColorForSegmentAtIndex(_ index: Int) -> UIColor {
        if let gradientColor = dataSource?.segmentedControl?(self, gradientColorsForSelectedSegmentAtIndex: index).first {
            return gradientColor
        }
        return selectorViewColor
    }
    
    fileprivate func setupShadowForSegmentAtIndex(_ index: Int, visible isVisible: Bool, animated shouldAnimate: Bool) {
        shadowView.layer.shadowColor = shadowColorForSegmentAtIndex(index).cgColor
        shadowView.layer.shadowRadius = 7.0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        var transform = CGAffineTransform(translationX: segmentViews[index].bounds.width * percentFromOffset(offsetFromSegment(index)), y: 0)
        shadowView.layer.shadowPath = pathForSelectorViewFromPercentage(0).copy(using: &transform)
        if shouldAnimate {
            let animation = CABasicAnimation(keyPath: "shadowOpacity")
            animation.duration = CFTimeInterval(isVisible ? shadowShowDuration : shadowHideDuration)
            animation.toValue = CFTimeInterval(isVisible ? 0.7 : 0.0)
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            shadowView.layer.add(animation, forKey: nil)
        } else {
            shadowView.layer.shadowOpacity = isVisible ? 0.7 : 0.0
        }
    }
    
    // MARK: - Segments
    
    fileprivate func changeSegmentToSegmentAtIndex(_ index: Int) {
        let fromSegment = currentSegment
        currentSegment = index
        if shadowsEnabled {
            setupShadowForSegmentAtIndex(index, visible: true, animated: true)
        }
        delegate?.segmentedControl?(self, didChangeFromSegmentAtIndex: fromSegment, toSegmentAtIndex: index)
    }
    
    /// Sets the currently selected segment.
    ///
    /// - parameter index:         The index of the currently selected segment.
    /// - parameter shouldAnimate: `true` if the change should be animated, otherwise `false`.
    public func setCurrentSegmentIndex(_ index: Int, animated shouldAnimate: Bool) {
        assert(dataSource != nil,
               "Data source of segmented control: \(self) wasn't set. In order to use segmented control, set its data source.")
        assert(index < segmentsCount && index >= 0,
               "Unable to set segment \(index). Segmented control has only \(segmentsCount) segments, from 0 to \(segmentsCount - 1)")
        
        if !shouldAnimate {
            currentSegment = index
            if shadowsEnabled {
                setupShadowForSegmentAtIndex(index, visible: true, animated: false)
            }
        }
        scrollView.setContentOffset(offsetFromSegment(index), animated: shouldAnimate)
    }
    
    // MARK: - Segment Views Setup
    
    fileprivate func setupSelectedLabel(_ label: UILabel, forSegmentAtIndex index: Int) {
        if (dataSource?.segmentedControl?(self, titleForSelectedSegmentAtIndex: index)) != nil {
            label.text = dataSource?.segmentedControl?(self, titleForSelectedSegmentAtIndex: index)
        }
        if (dataSource?.segmentedControl?(self, attributedTitleForSelectedSegmentAtIndex: index) != nil) {
            label.attributedText = dataSource?.segmentedControl?(self, attributedTitleForSelectedSegmentAtIndex: index)
        }
        label.font = textFont
        if (dataSource?.segmentedControl?(self, titleColorForSelectedSegmentAtIndex: index) != nil) {
            label.textColor = dataSource?.segmentedControl?(self, titleColorForSelectedSegmentAtIndex: index)
        } else {
            label.textColor = selectedSegmentTextColor
        }
        label.textAlignment = .center
    }
    
    fileprivate func setupLabel(_ label: UILabel, forSegmentAtIndex index: Int, selected isSelected: Bool) {
        if isSelected && ((dataSource?.segmentedControl?(self, titleForSelectedSegmentAtIndex: index)) != nil &&
            dataSource?.segmentedControl?(self, attributedTitleForSelectedSegmentAtIndex: index) != nil) {
            setupSelectedLabel(label, forSegmentAtIndex: index)
            return
        }
        if (dataSource?.segmentedControl?(self, titleForSegmentAtIndex: index)) != nil {
            label.text = dataSource?.segmentedControl?(self, titleForSegmentAtIndex: index)
        }
        if (dataSource?.segmentedControl?(self, attributedTitleForSegmentAtIndex: index) != nil) {
            label.attributedText = dataSource?.segmentedControl?(self, attributedTitleForSegmentAtIndex: index)
        }
        label.font = textFont
        if isSelected {
            if (dataSource?.segmentedControl?(self, titleColorForSelectedSegmentAtIndex: index) != nil) {
                label.textColor = dataSource?.segmentedControl?(self, titleColorForSelectedSegmentAtIndex: index)
            } else {
                label.textColor = selectedSegmentTextColor
            }
        } else {
            label.textColor = textColor
        }
        label.textAlignment = .center
    }
    
    fileprivate func viewForSegmentAtIndex(_ index: Int) -> UIView {
        var view: UIView?
        view = dataSource?.segmentedControl?(self, viewForSegmentAtIndex: index)
        if view == nil {
            let label = UILabel(frame: .zero)
            setupLabel(label, forSegmentAtIndex: index, selected: false)
            view = label
        }
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view!
    }
    
    fileprivate func selectedViewForSegmentAtIndex(_ index: Int) -> UIView {
        var view: UIView?
        view = dataSource?.segmentedControl?(self, viewForSelectedSegmentAtIndex: index)
        if view == nil {
            view = dataSource?.segmentedControl?(self, viewForSegmentAtIndex: index)
        }
        if view == nil {
            let label = UILabel(frame: .zero)
            setupLabel(label, forSegmentAtIndex: index, selected: true)
            view = label
        }
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view!
    }
    
    fileprivate func setupSegmentViewAtIndex(_ index: Int, withSelectionPercent percent: CGFloat) {
        if percent < 1 && percent > -1 {
            changedViews.insert(index)
        }
        switch transitionStyle {
        case .fade:
            selectedSegmentViewContainers[index].alpha = 1 - fabs(percent)
            segmentViewContainers[index].alpha = fabs(percent)
        case .slide:
            let segmentView = selectedSegmentViewContainers[index]
            if segmentView.layer.mask == nil {
                segmentView.layer.mask = CAShapeLayer()
            }
            var transform = CGAffineTransform(translationX: segmentView.bounds.width * percent, y: 0)
            let segmentViewShapeLayer = segmentView.layer.mask as! CAShapeLayer
            segmentViewShapeLayer.path = pathForSelectorViewFromPercentage(percent).copy(using: &transform)
        default:
            break
        }
        delegate?.segmentedControl?(self, setupSegmentAtIndex: index,
                                    unselectedView: segmentViewContainers[index],
                                    selectedView: selectedSegmentViewContainers[index],
                                    withSelectionPercent: percent)
    }
    
    fileprivate func deselectSegmentAtIndex(_ index: Int) {
        setupSegmentViewAtIndex(index, withSelectionPercent: 1)
    }
    
    fileprivate func selectSegmentAtIndex(_ index: Int) {
        setupSegmentViewAtIndex(index, withSelectionPercent: 0)
    }
    
    fileprivate func resetSegmentViewAtIndex(_ index: Int) {
        let segmentView = segmentViewContainers[index]
        segmentView.alpha = 1.0
        let selectedSegmentView = selectedSegmentViewContainers[index]
        selectedSegmentView.alpha = 1.0
        selectedSegmentView.layer.mask = nil
        delegate?.segmentedControl?(self, resetSegmentAtIndex: index,
                                    unselectedView: segmentView,
                                    selectedView: selectedSegmentView)
    }
    
    fileprivate func setupSegmentViewsWithCount(_ count: Int) {
        for index in 0 ..< count {
            let viewContainer = UIView(frame: .zero)
            viewContainer.translatesAutoresizingMaskIntoConstraints = false
            viewContainer.isUserInteractionEnabled = false
            viewContainer.backgroundColor = .clear
            self.addSubview(viewContainer)
            segmentViewContainers.append(viewContainer)
            
            if index == 0 {
                setupConstraintsForFirstView(viewContainer)
            } else {
                setupConstraintsForView(viewContainer, withPreviousView: segmentViewContainers[index - 1])
            }
        }
        
        setupRightConstraintForLastView(segmentViewContainers[count - 1])
        
        for index in 0 ..< count {
            let view = viewForSegmentAtIndex(index)
            let viewContainer = segmentViewContainers[index]
            viewContainer.addSubview(view)
            segmentViews.append(view)
            setupConstraintsForView(view, withContainer: viewContainer)
        }
    }
    
    fileprivate func setupSelectedSegmentViewsWithCount(_ count: Int) {
        for index in 0 ..< count {
            let viewContainer = UIView(frame: .zero)
            viewContainer.translatesAutoresizingMaskIntoConstraints = false
            viewContainer.isUserInteractionEnabled = false
            viewContainer.backgroundColor = .clear
            self.insertSubview(viewContainer, aboveSubview: segmentViewContainers[index])
            selectedSegmentViewContainers.append(viewContainer)
            
            if index == 0 {
                setupConstraintsForFirstView(viewContainer)
            } else {
                setupConstraintsForView(viewContainer, withPreviousView: selectedSegmentViewContainers[index - 1])
            }
        }
        
        setupRightConstraintForLastView(selectedSegmentViewContainers[count - 1])
        
        for index in 0 ..< count {
            let view = selectedViewForSegmentAtIndex(index)
            let viewContainer = selectedSegmentViewContainers[index]
            viewContainer.addSubview(view)
            selectedSegmentViews.append(view)
            setupConstraintsForView(view, withContainer: viewContainer)
        }
    }
    
    // MARK: - Calculations
    
    fileprivate func gradientLocationForBounce(_ bounce: SJFluidSegmentedControlBounce,
                                               colorIndex colorIdx: Int,
                                               colorsCount colorsCnt: Int,
                                               segmentsCount segmentsCnt: Int) -> CGFloat {
        let totalCount = CGFloat(segmentsCnt + 2) + CGFloat(segmentsCnt + 1) * gradientBackVelocity
        switch bounce {
        case .left:
            return CGFloat(colorIdx) / CGFloat(colorsCnt - 1) / totalCount
        case .right:
            return (CGFloat(totalCount - 1 + CGFloat(colorIdx)) / CGFloat(colorsCnt - 1)) / totalCount
        }
    }
    
    fileprivate func gradientLocationForSegmentAtIndex(_ segmentIndex: Int,
                                                       colorIndex colorIdx: Int,
                                                       colorsCount colorsCnt: Int,
                                                       segmentsCount segmentsCnt: Int) -> CGFloat {
        let totalCount = CGFloat(segmentsCnt + 2) + CGFloat(segmentsCnt + 1) * gradientBackVelocity
        let offset = CGFloat(1 + segmentIndex) + CGFloat(segmentIndex + 1) * gradientBackVelocity
        return (offset + CGFloat(colorIdx) / CGFloat(colorsCnt - 1)) / CGFloat(totalCount)
    }
    
    fileprivate func pathForSelectorViewFromPercentage(_ percentage: CGFloat) -> CGPath {
        switch shapeStyle {
        case .roundedRect:
            return roundedRectPathForSelectorViewFromPercentage(percentage).cgPath
        case .liquid:
            return dribblePathForSelectorViewFromPercentage(percentage).cgPath
        }
    }
    
    fileprivate func dribblePathForSelectorViewFromPercentage(_ percentage: CGFloat) -> UIBezierPath {
        var newPercentage = percentage
        if newPercentage < 0 {
            newPercentage += 1
        }
        let height = selectorView.frame.height
        let width = selectorView.frame.width
        var p1 = CGPoint(x: height / 2, y: F(newPercentage) * height)
        var p4 = CGPoint(x: width - height / 2, y: F(1 - newPercentage) * height)
        var p2: CGPoint
        var p3: CGPoint
        
        let p2x = height / 2 + (width - height) / 4
        let p2yLeftPartOfExpression = (p1.y * 3 + p4.y) / 4
        
        let p3x = height / 2 + (width - height) * 3 / 4
        let p3yLeftPartOfExpression = (p1.y + p4.y * 3) / 4
        
        let p2p3yRightPartOfExpression = height * 0.1 * (0.2 - fabs(0.5 - newPercentage)) / 0.2
        if newPercentage > 0.3 && newPercentage < 0.7 {
            let p2y = p2yLeftPartOfExpression + p2p3yRightPartOfExpression
            p2 = CGPoint(x: p2x, y: p2y)
            
            let p3y = p3yLeftPartOfExpression + p2p3yRightPartOfExpression
            p3 = CGPoint(x: p3x, y: p3y)
        } else {
            p2 = CGPoint(x: p2x, y: p2yLeftPartOfExpression)
            p3 = CGPoint(x: p3x, y: p3yLeftPartOfExpression)
        }
        
        let length = height / 4
        let coef: CGFloat = 1.2
        var p12vector = CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
        p12vector = normalizeToLength(point: p12vector, length: length)
        var p34vector = CGPoint(x: p4.x - p3.x, y: p4.y - p3.y)
        p34vector = normalizeToLength(point: p34vector, length: length)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addCurve(to: p1,
                      controlPoint1: CGPoint(x: 0, y: height / 2 - length),
                      controlPoint2: CGPoint(x: p1.x - p12vector.x, y: p1.y - p12vector.y))
        path.addLine(to: p2)
        path.addCurve(to: p3,
                      controlPoint1: CGPoint(x: p2.x + p12vector.x / coef, y: p2.y + p12vector.y / coef),
                      controlPoint2: CGPoint(x: p3.x - p34vector.x / coef, y: p3.y - p34vector.y / coef))
        path.addLine(to: p4)
        path.addCurve(to: CGPoint(x: width, y: height / 2),
                      controlPoint1: CGPoint(x: p4.x + p34vector.x, y: p4.y + p34vector.y),
                      controlPoint2: CGPoint(x: width, y: height / 2 - length))
        
        p1.y = height - p1.y
        p2.y = height - p2.y
        p3.y = height - p3.y
        p4.y = height - p4.y
        p12vector.y = -p12vector.y
        p34vector.y = -p34vector.y
        
        path.addCurve(to: p4,
                      controlPoint1: CGPoint(x: width, y: height / 2 + length),
                      controlPoint2: CGPoint(x: p4.x + p34vector.x, y: p4.y + p34vector.y))
        path.addLine(to: p3)
        path.addCurve(to: p2,
                      controlPoint1: CGPoint(x: p3.x - p34vector.x / coef, y: p3.y - p34vector.y / coef),
                      controlPoint2: CGPoint(x: p2.x + p12vector.x / coef, y: p2.y + p12vector.y / coef))
        path.addLine(to: p1)
        path.addCurve(to: CGPoint(x: 0, y: height / 2),
                      controlPoint1: CGPoint(x: p1.x - p12vector.x, y: p1.y - p12vector.y),
                      controlPoint2: CGPoint(x: 0, y: height / 2 + length))
        
        return path
        
    }
    
    fileprivate func roundedRectPathForSelectorViewFromPercentage(_ percentage: CGFloat) -> UIBezierPath {
        return UIBezierPath(roundedRect: selectorView.bounds, cornerRadius: cornerRadius)
    }
    
    fileprivate func leftSegmentIndexFromPercentage(_ percentage: CGFloat) -> Int {
        return Int(floorf(Float(percentage)))
    }
    
    fileprivate func rightSegmentIndexFromPercentage(_ percentage: CGFloat) -> Int {
        return Int(floorf(Float(percentage))) + 1
    }
    
    fileprivate func percentFromOffset(_ offset: CGPoint) -> CGFloat {
        var newOffset = offset
        newOffset.x /= leftSpacerView.frame.width
        newOffset.x *= CGFloat(segmentsCount - 1)
        return CGFloat(segmentsCount - 1) - newOffset.x
    }
    
    fileprivate func offsetFromSegment(_ segment: Int) -> CGPoint {
        let intOffset = segmentsCount - segment - 1
        var offset = CGPoint(x: intOffset, y: 0)
        offset.x *= leftSpacerView.frame.width
        offset.x /= CGFloat(segmentsCount - 1)
        return offset
    }
    
    fileprivate func segmentFromOffset(_ offset: CGPoint) -> Int {
        var newOffset = offset
        newOffset.x /= leftSpacerView.frame.width
        newOffset.x *= CGFloat(segmentsCount - 1)
        let intOffset = Int(roundf(Float(newOffset.x)))
        return segmentsCount - intOffset - 1
    }
    
    fileprivate func segmentFromTapPoint(_ point: CGPoint) -> Int {
        var newPoint = point
        newPoint.x /= selectorView.frame.width
        return Int(floorf(Float(newPoint.x)))
    }
    
    fileprivate func nearestSegmentOffsetFromOffset(_ offset: CGPoint) -> CGPoint {
        var newOffset = offset
        newOffset.x /= leftSpacerView.frame.width
        newOffset.x *= CGFloat(segmentsCount - 1)
        newOffset.x = CGFloat(roundf(Float(newOffset.x)))
        newOffset.x /= CGFloat(segmentsCount - 1)
        newOffset.x *= leftSpacerView.frame.width
        return newOffset
    }
    
    fileprivate var spacerViewWidthMultiplier: CGFloat {
        return CGFloat(segmentsCount - 1) / 1.0 / CGFloat(segmentsCount)
    }
    
    fileprivate var selectorViewWidthMultiplier: CGFloat {
        return 1.0 / CGFloat(segmentsCount)
    }
    
    // MARK: - Liquid Shape Functions
    
    fileprivate func F(_ x: CGFloat) -> CGFloat {
        return 192.862 * pow(x, 8) - 786.037 * pow(x, 7) + 1325.23 * pow(x, 6) - 1182.26 * pow(x, 5) + 587.962 * pow(x, 4) -
            157.531 * pow(x, 3) + 20.5313 * pow(x, 2) - 0.760045 * x
    }
    
    fileprivate func normalizeToLength(point p: CGPoint, length len: CGFloat) -> CGPoint {
        let currentLength = sqrt(p.x * p.x + p.y * p.y)
        if currentLength == 0 {
            return .zero
        }
        return CGPoint(x: p.x / currentLength * len, y: p.y / currentLength * len)
    }
    
    // MARK: - Reload
    
    fileprivate func reinstallConstraints() {
        setupLeftSpacerViewConstraints()
        setupSelectorViewConstraints()
        setupRightSpacerViewConstraints()
        setupScrollViewConstraints()
        setupGradientViewConstraints()
    }
    
    fileprivate func removeOldConstraints() {
        self.removeConstraintsFromSubtree(Set(addedConstraintsToRemove))
        addedConstraintsToRemove.removeAll()
    }
    
    fileprivate func reinstallViews() {
        for view in segmentViewContainers {
            view.removeFromSuperview()
        }
        for view in selectedSegmentViewContainers {
            view.removeFromSuperview()
        }
        segmentViews.removeAll()
        selectedSegmentViews.removeAll()
        segmentViewContainers.removeAll()
        selectedSegmentViewContainers.removeAll()
        if let dataSource = dataSource {
            let count = dataSource.numberOfSegmentsInSegmentedControl(self)
            setupSegmentViewsWithCount(count)
            setupSelectedSegmentViewsWithCount(count)
            setupGradientViewWithCount(count)
        }
    }
    
    fileprivate func updateTransitionStyle() {
        for index in 0 ..< segmentsCount {
            resetSegmentViewAtIndex(index)
            deselectSegmentAtIndex(index)
        }
        selectSegmentAtIndex(currentSegment)
    }
    
    
    /// Reloads the segments of the segmented control.
    open func reloadData() {
        guard let dataSource = dataSource else {
            print("Cannot reload segmented control without specified data source.")
            return
        }
        wereLayoutDependantValuesUpdated = false
        segmentsCount = dataSource.numberOfSegmentsInSegmentedControl(self)
        removeOldConstraints()
        reinstallViews()
        reinstallConstraints()
        self.sendSubview(toBack: scrollView)
        if let gradientViewContainer = gradientViewContainer {
            self.sendSubview(toBack: gradientViewContainer)
        }
        updateTransitionStyle()
        if didViewLayoutSubviews {
            updateLayoutDependantValues()
        }
    }
    
    fileprivate func updateLayoutDependantValues() {
        let savedCurrentSegment = currentSegment
        currentSegment = 0
        setCurrentSegmentIndex(savedCurrentSegment, animated: false)
        wereLayoutDependantValuesUpdated = true
    }

}


// MARK: - UIScrollView Delegate Methods

extension SJFluidSegmentedControl: UIScrollViewDelegate {
    
    /// Tells the delegate when the scroll view is about to start scrolling the content.
    ///
    /// - Parameter scrollView: The scroll-view object that is about to scroll the content view.
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.segmentedControl?(self, willChangeFromSegment: currentSegment)
    }
    
    /// Tells the delegate when the user finishes scrolling the content.
    ///
    /// - Parameters:
    ///   - scrollView: The scroll-view object where the user ended the touch.
    ///   - velocity: The velocity of the scroll view (in points) at the moment the touch was released.
    ///   - targetContentOffset: The expected offset when the scrolling action decelerates to a stop.
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if dataSource != nil {
            targetContentOffset.pointee = nearestSegmentOffsetFromOffset(targetContentOffset.pointee)
        }
    }
    
    /// Tells the delegate that the scroll view has ended decelerating the scrolling movement.
    ///
    /// - Parameter scrollView: The scroll-view object that is decelerating the scrolling of the content view.
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > self.bounds.width - selectorView.bounds.width {
            return
        }
        changeSegmentToSegmentAtIndex(segmentFromOffset(scrollView.contentOffset))
    }
    
    /// Tells the delegate when a scrolling animation in the scroll view concludes.
    ///
    /// - Parameter scrollView: The scroll-view object that is performing the scrolling animation.
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        changeSegmentToSegmentAtIndex(segmentFromOffset(scrollView.contentOffset))
        self.isUserInteractionEnabled = true
    }
    
    /// Tells the delegate when the user scrolls the content view within the receiver.
    ///
    /// - Parameter scrollView: The scroll-view object that is performing the scrolling animation.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.segmentedControl?(self, didScrollWithXOffset: self.frame.width - self.scrollView.contentOffset.x - selectorView.frame.width)
        if offsetFromSegment(segmentFromOffset(scrollView.contentOffset)).x != scrollView.contentOffset.x {
            setupShadowForSegmentAtIndex(currentSegment, visible: false, animated: true)
        }
        let percent = percentFromOffset(scrollView.contentOffset)
        let leftIndex = leftSegmentIndexFromPercentage(percent)
        let rightIndex = rightSegmentIndexFromPercentage(percent)
        
        let _ = changedViews.subtracting(changedViews.filter({ (number) -> Bool in
            if number == leftIndex {
                return false
            }
            if number == rightIndex {
                return false
            }
            deselectSegmentAtIndex(number)
            return true
        }))

        let factor = CGFloat(Float(percent) - floorf(Float(percent)))
        selectorViewPath = pathForSelectorViewFromPercentage(factor)
        if leftIndex >= 0 && leftIndex < segmentsCount {
            setupSegmentViewAtIndex(leftIndex, withSelectionPercent: factor)
        }
        if rightIndex >= 0 && rightIndex < segmentsCount {
            setupSegmentViewAtIndex(rightIndex, withSelectionPercent: factor - 1.0)
        }
        setupGradientWithPercent(factor, offsetFactor: percent / CGFloat(segmentsCount))
    }
    
}
