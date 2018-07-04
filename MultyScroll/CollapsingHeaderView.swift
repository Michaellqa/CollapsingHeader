//
//  CollapsingHeaderView.swift
//  MultyScroll
//
//  Created by Micky on 04/07/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit

class CollapsingHeaderView: UIView {
    
    var minVisibleHeight: CGFloat = 0.0
    var onHeightChanged: ((_ height: CGFloat, _ percentDelta: CGFloat) -> ())? = nil
    
    private var currentHeight: CGFloat = 0.0
    private var viewHeight: CGFloat = 0.0
    private let internalView: UIView
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        return recognizer
    }()
    
    init(minVisibleHeight: CGFloat, headerView: UIView) {
        self.internalView = headerView
        super.init(frame: headerView.frame)
        
        self.minVisibleHeight = minVisibleHeight
        currentHeight = frame.height
        viewHeight = frame.height
        
        addSubview(internalView)
        internalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            internalView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            internalView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            internalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
////            internalView.topAnchor.constraint(equalTo: self.topAnchor)
//            internalView.heightAnchor.constraint(equalToConstant: 200),
//            internalView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        internalView.addGestureRecognizer(panGestureRecognizer)
    }

    
    @objc func handlePanGesture() {
        switch panGestureRecognizer.state {
        case .began: print("began")
        case .changed:
            let transition = panGestureRecognizer.translation(in: subviews.first!)
            changeCurrentHeight(delta: transition.y)
        case .ended: print("ended")
        default: break
        }
        // prevent cummulative effect
        panGestureRecognizer.setTranslation(.zero, in: self)
    }
    
    private func changeCurrentHeight(delta: CGFloat) {
        guard (delta > 0 && currentHeight < viewHeight) || (delta < 0 && currentHeight > minVisibleHeight) else {
            return
        }
        let newHeight = internalView.frame.size.height + delta
//        frame.size.height = newHeight
        internalView.frame.size.height = newHeight
        
        print("whole \(frame)")
        print("content \(internalView.frame)")
        currentHeight = newHeight
        
        onHeightChanged?(newHeight, 0)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        internalView = UIView()
        super.init(coder: aDecoder)
    }
    
//    private func commonInit() {
//        Bundle.main.loadNibNamed("CollapsingHeaderView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    }
    
}
