//
//  PageCell.swift
//  Onboarding
//
//  Created by Zone 3 on 4/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit


class PageCell : UICollectionViewCell{
    
    var page : Page?{
        didSet{
            guard let page = page else {
                return
            }
            
            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape {
                imageName += "_landscape"
            }
            
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedTitleText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : color])
            
            let attributedMessageText = NSMutableAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName : color])
            attributedTitleText.append(attributedMessageText)
            
           
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            attributedTitleText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attributedTitleText.string.characters.count))
            
             textView.attributedText = attributedTitleText
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.yellow
        iv.image = UIImage(named: "page1")
        return iv
    }()
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.text = "Sample text"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparator : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return line
    }()
    
    func setupViews() -> () {
        backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparator)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        lineSeparator.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
}
