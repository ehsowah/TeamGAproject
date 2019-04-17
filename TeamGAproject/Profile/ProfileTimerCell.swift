//
//  ProfileTimerCell.swift
//  TeamGAproject
//
//  Created by sowah on 3/22/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit

class ProfileTimerCell: UICollectionViewCell {
    
    var clockTime: ClockTime? {
        didSet {
            setUpAttributeText()
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let clockIn: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let clockOut: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserStackView()
    }
    
    fileprivate func setupUserStackView() {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, clockIn, clockOut])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }
    
    fileprivate func setUpAttributeText() {
        guard let clockTime = self.clockTime else { return }
        
        let dateAttributedText = NSMutableAttributedString(string: "Date\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        dateAttributedText.append(NSMutableAttributedString(string: clockTime.currentDate, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        dateLabel.attributedText = dateAttributedText
        
        let clockInAttributedText = NSMutableAttributedString(string: "Clock In\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        clockInAttributedText.append(NSMutableAttributedString(string: clockTime.clockIn, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        clockIn.attributedText = clockInAttributedText
        
        let clockOutAttributedText = NSMutableAttributedString(string: "Clock Out\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        clockOutAttributedText.append(NSMutableAttributedString(string: clockTime.clockOut, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        clockOut.attributedText = clockOutAttributedText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
