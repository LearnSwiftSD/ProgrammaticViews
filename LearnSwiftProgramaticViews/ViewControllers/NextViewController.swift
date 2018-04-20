//
//  NextViewController.swift
//  LearnSwiftProgramaticViews
//
//  Created by Stephen Martinez on 4/18/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    let coronadoImage = UIImageView(image: #imageLiteral(resourceName: "CoronadoImage"))
    let lSSDLogoImage = UIImageView(image: #imageLiteral(resourceName: "LS Written Logo"))
    let messageLable = UILabel()
    var name: String?
    var message: String{return "Welcome\n \(name ?? "")\n To "}
    
    override func loadView() {
        let gradientView = UIGradientView()
        gradientView.addLinearGradient(colors: [UIColor.lSSDYellow, UIColor.lSSDOrange])
        view = gradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
        setUpMessage()
        setUpLogo()
    }
    
    func setUpImage() {
        view.addSubview(coronadoImage)
        coronadoImage.contentMode = .scaleAspectFill
        coronadoImage.translatesAutoresizingMaskIntoConstraints = false
        coronadoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coronadoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coronadoImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        coronadoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUpMessage() {
        view.addSubview(messageLable)
        messageLable.translatesAutoresizingMaskIntoConstraints = false
        messageLable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messageLable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messageLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        messageLable.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        messageLable.textAlignment = .center
        messageLable.numberOfLines = 0
        messageLable.lineBreakMode = .byWordWrapping
        messageLable.attributedText = NSAttributedString(
            string: message,
            attributes: [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 30),
                NSAttributedStringKey.foregroundColor : UIColor.white
            ])
    }
    
    func setUpLogo() {
        view.addSubview(lSSDLogoImage)
        lSSDLogoImage.translatesAutoresizingMaskIntoConstraints = false
        lSSDLogoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lSSDLogoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lSSDLogoImage.topAnchor.constraint(equalTo: messageLable.bottomAnchor, constant: 0).isActive = true
        lSSDLogoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        lSSDLogoImage.contentMode = .scaleAspectFit
    }
    
}
