//
//  WIModelStatusView.swift
//  WIModelStatus
//
//  Created by Vikas Pandey on 04/01/19.
//  Copyright © 2019 Wissen. All rights reserved.
//

import UIKit

public class WIModelStatusView: UIView {
    
    let nibName = "WIModelStatusView"
    var contentView: UIView!
    var timer: Timer?
    
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var statusTitleLabel: UILabel!
    @IBOutlet private weak var statusMessageLabel: UILabel!
    
    // MARK: Set Up View
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        statusTitleLabel.text = ""
        statusMessageLabel.text = ""
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // Provide functions to update view
    public func set(image: UIImage) {
        self.statusImageView.image = image
    }
    
    public func set(headline text: String) {
        self.statusTitleLabel.text = text
    }
    
    public func set(subheading text: String) {
        self.statusMessageLabel.text = text
    }
    
    // Allow view to control itself
    public override func layoutSubviews() {
        // Rounded corners
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    public override func didMoveToSuperview() {
        // Fade in when added to superview
        // Then add a timer to remove the view
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }) { _ in
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func removeSelf() {
        // Animate removal of view
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
