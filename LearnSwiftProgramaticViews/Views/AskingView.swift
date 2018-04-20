//
//  AskingView.swift
//  LearnSwiftProgramaticViews
//
//  Created by Stephen Martinez on 4/18/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class AskingView: UIView {
    
    let question: String
    let needsEntry: Bool
    var textField: UITextField?
    let textDiplay = UILabel()
    let textGuide = UILayoutGuide()
    
    init(question: String, needsEntry: Bool, delegate: UITextFieldDelegate) {
        self.question = question
        self.needsEntry = needsEntry
        super.init(frame: CGRect.zero)
        setMeUp(with: delegate)
    }
    
    private func setMeUp(with delegate: UITextFieldDelegate) {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.25
        self.layer.borderColor = UIColor.white.cgColor
        setUpText()
        setUpEntry(needed: needsEntry, delegate: delegate)
    }
    
    private func setUpText() {
        //Add to Heirarchy
        addSubview(textDiplay)
        addLayoutGuide(textGuide)
        //Activate AutoLayout & Constraints
        textDiplay.translatesAutoresizingMaskIntoConstraints = false
        textGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
        textGuide.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        textGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        //Set up the textDisplay properties
        textDiplay.snapToGuide(textGuide)
        textDiplay.textAlignment = .center
        textDiplay.numberOfLines = 0
        textDiplay.lineBreakMode = .byWordWrapping
        textDiplay.attributedText = NSAttributedString(
            string: question,
            attributes: [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 26),
                NSAttributedStringKey.foregroundColor : UIColor.white
            ])
    }
    
    func setUpEntry(needed: Bool, delegate: UITextFieldDelegate) {
        guard needed else {return}
        //Create your view
        textField = UITextField()
        guard let textField = textField else{return}
        //Add to heirarchy
        addSubview(textField)
        //Activate AutoLayout
        textField.translatesAutoresizingMaskIntoConstraints = false
        //SetUp Constraints
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.trailingAnchor.constraint(equalTo: textGuide.trailingAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: textGuide.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: textDiplay.bottomAnchor, constant: 10).isActive = true
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        textField.layer.cornerRadius = 10
        textField.delegate = delegate
    }
    
    //Only used in StoryBoard
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
