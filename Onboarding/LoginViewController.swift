//
//  ViewController.swift
//  Onboarding
//
//  Created by Zone 3 on 4/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit


protocol LoginViewControllerDelegate : class {
   func finishRegister()
}

class LoginViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout, LoginViewControllerDelegate{
    
    
    let loginCellId = "logincellid"
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let pages : [Page] = {
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipient's first book is on us.", imageName: "page1")
        
        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
        
        let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
        return [firstPage, secondPage, thirdPage]
    }()
    
    lazy var pageControl : UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .orange
        control.numberOfPages = self.pages.count+1
        
        return control
    }()
    
    lazy var skipButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
       return button
    }()
    
    lazy var nextButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    return button
    }()
    
    func skipPage(){
        pageControl.currentPage = pages.count-1
        nextPage()
    }
    
    func nextPage() {
        
        if pageControl.currentPage == pages.count{
            return
        }
        
        if pageControl.currentPage == pages.count - 1{
            moveControlOutOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }

    var pageControlBottomAnchor : NSLayoutConstraint?
    var skipButtonTopAnchor : NSLayoutConstraint?
    var nextButtonTopAnchor : NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotification()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 60, heightConstant: 50).first
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        registercell()
        
    }
    
    fileprivate func observeKeyboardNotification() {
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardShow()  {
        
        var yLength : CGFloat = -100
        if UIDevice.current.orientation.isLandscape{
            yLength = -150
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.view.frame = CGRect(x: 0, y: yLength, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardHide()  {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }, completion: nil)
    }
    
    fileprivate func registercell(){
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "mycell")
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return pages.count+1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count{
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            
            loginCell.delegate = self
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! PageCell
        let page = pages[indexPath.row]
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x/view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count{
            moveControlOutOffScreen()
            
        }else{
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant =  16
            nextButtonTopAnchor?.constant =  16
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
             self.view.layoutIfNeeded()
        }, completion: nil)
    }
    

    func moveControlOutOffScreen(){
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant =  -40
        nextButtonTopAnchor?.constant =  -40
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
            collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    }
    
    func finishRegister()  {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        guard let mainNavigationController = rootViewController as? MainNavigationController else {
            return
        }
        mainNavigationController.viewControllers = [HomeViewController()]
        
        dismiss(animated: true, completion: nil)
    }

}

