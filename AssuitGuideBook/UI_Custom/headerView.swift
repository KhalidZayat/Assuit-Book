//
//  headerView.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/25/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("headerView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setupHeader(imageName: String, title: String)
    {
        headerImage.image = UIImage(named: imageName)
        label.text = title
    }
}
