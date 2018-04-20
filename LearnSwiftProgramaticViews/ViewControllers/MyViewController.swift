//
//  MyViewController.swift
//  LearnSwiftProgramaticViews
//
//  Created by Stephen Martinez on 4/18/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

class MyViewController: UIViewController{
    
    let bannerImageView = UIImageView(image: #imageLiteral(resourceName: "LS Written Logo"))
    let holdingView = UIView()
    var questionView: AskingView?
    let checkButton = UIButton()
    let myBannerGuide = UILayoutGuide()
    let myQuestionGuide = UILayoutGuide()
    let myButtonGuide = UILayoutGuide()
    var topConstraint: NSLayoutConstraint?
    var enteredName: String?
    var nextPage: Int = 1
    
    //Model typically seperate from View Controller, but is here for tutorial purposes
    let model = [
        "Would you like to learn fun and new techniques for programming iOS Applications?",
        "Do you want to stretch beyond the average object oriented paradigm of programing",
        "Join us today and see what all the fuss is about\n\n Enter your name."]
    
    //This method is called to produce the view. Super is not called because
    //we don't want the blank view to produced.
    override func loadView() {
        //Create our gradient View
        let gradientView = UIGradientView()
        //Add the gradient colors
        gradientView.addLinearGradient(colors: [UIColor.lSSDBlue, UIColor.lSSDTeal])
        //Swap out the standard view for the gradient view
        view = gradientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSetupProcesses()
    }
    
    ///Contains of the start up methods for the view controller
    private func startSetupProcesses() {
        setUpGuides()
        setUpViews()
        subscribeToKeyboardNotifications()
    }
    
    ///Sets up all of our UILayout Guides
    private func setUpGuides() {
        let bannerHtM: CGFloat = 0.08
        let questionHtM: CGFloat = 0.5
        let leftPad: CGFloat = 10
        let rightPad: CGFloat = -10
        
        //Add our Layout Guides to the main view
        [myBannerGuide, myQuestionGuide, myButtonGuide].forEach{[view] in view?.addLayoutGuide($0)}
        
        //Store the top constraint in a Controller property so it can be moved when keyboard appears
        topConstraint = myBannerGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        topConstraint?.isActive = true
        
        //Add the rest of the constraints
        NSLayoutConstraint.activate([
            //Banner Image Layout
            myBannerGuide.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: bannerHtM),
            myBannerGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPad),
            myBannerGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightPad),
            //Question View Layout
            myQuestionGuide.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: questionHtM),
            myQuestionGuide.topAnchor.constraint(equalTo: myBannerGuide.bottomAnchor, constant: 30),
            myQuestionGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            myQuestionGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            //Button Layout
            myButtonGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myButtonGuide.topAnchor.constraint(equalTo: myQuestionGuide.bottomAnchor),
            myButtonGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPad),
            myButtonGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightPad)
            ])
    }
    
    ///Sets up our views' properties and any remaining constraints still needed
    private func setUpViews() {
        //Initialize and add views to the hierarchy
        questionView = AskingView(question: model[0], needsEntry: false, delegate: self)
        view.addSubview(bannerImageView)
        view.addSubview(holdingView)
        view.addSubview(checkButton)
        holdingView.addSubview(questionView!)
        //Set up image properties and snap to guide
        bannerImageView.contentMode = .scaleAspectFit
        bannerImageView.clipsToBounds = true
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.snapToGuide(myBannerGuide)
        //Snap the holding view that contains the question view
        holdingView.translatesAutoresizingMaskIntoConstraints = false
        holdingView.snapToGuide(myQuestionGuide)
        //Snap the question view to the same guide as the holding view
        questionView?.translatesAutoresizingMaskIntoConstraints = false
        questionView?.snapToGuide(myQuestionGuide)
        //Pivot the button inside of the button guide by set up it's constraints.
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.heightAnchor.constraint(equalToConstant: 110).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        checkButton.centerXAnchor.constraint(equalTo: myButtonGuide.centerXAnchor).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: myButtonGuide.centerYAnchor).isActive = true
        checkButton.setImage(#imageLiteral(resourceName: "checkButtonImage"), for: .normal)
        checkButton.contentMode = .scaleAspectFit
        checkButton.addTarget(self, action: #selector(transitionQuestion), for: .touchUpInside)
    }
    
    
    ///Navigates the model and Animates the transition to the selected page.
    private func transitionToNext(page: Int){
        let index = page - 1
        let textFieldNeeded = page == 3
        guard index >= 0, index < model.count else {return}
        let askView = AskingView(question: model[index], needsEntry: textFieldNeeded, delegate: self)
        view.addSubview(askView)
        askView.translatesAutoresizingMaskIntoConstraints = false
        askView.snapToGuide(myQuestionGuide)
        let option: UIViewAnimationOptions = page == 1 ? .transitionCrossDissolve : .transitionFlipFromRight
        let duration: TimeInterval = page == 1 ? 0.3 : 0.7
        UIView.transition(
            from: questionView!,
            to: askView,
            duration: duration,
            options: [option],
            completion:
                page == 1 ? nil : {[weak self] completed in self?.questionView = askView}
        )
        if page == 1 {questionView = askView}
    }
    
    ///Changes the page and eventually goes to the next viewController
    @objc private func transitionQuestion() {
        switch nextPage{
        case 1: nextPage = 2
        transitionToNext(page: nextPage)
        case 2: nextPage = 3
        transitionToNext(page: nextPage)
        case 3: nextPage = 1
        transitionToNext(page: nextPage)
        let nextOne = NextViewController()
        nextOne.name = enteredName
        navigationController?.pushViewController(nextOne, animated: true)
        default: break
        }
    }
    
    //Won't be called because this is our root vc, but a good reminder that this will need to be placed
    //somewhere if the app moves beyond two vc's or the second one also utilizes a keyboard.
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}



//UITextFieldDelegate Methods
extension MyViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredName = textField.text
        textField.resignFirstResponder()
        return true
    }
    
}


//Keyboard Management
extension MyViewController {
    
    private func moveWithConstraints(up: Bool, by: CGFloat? = nil) {
        if up {
            guard let by = by else {return}
            topConstraint?.constant -= abs(by)
        }
        else {topConstraint?.constant = 0}
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.curveEaseOut],
            animations: {[view] in view?.layoutIfNeeded()})
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{return}
        guard questionView != nil else{return}
        if holdingView.frame.intersects(keyboardFrame){
            let moveBy = holdingView.frame.intersection(keyboardFrame)
            moveWithConstraints(up: true, by: moveBy.height)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {moveWithConstraints(up: false)}
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}
