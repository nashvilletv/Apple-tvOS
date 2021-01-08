//
//  ViewController.swift
//  NashvilleCountryTV
//
//  Created by Mayur Pitroda on 18/10/20.
//

import UIKit 
import AVKit

class ViewController: UIViewController {
    
    var centerView : UIView!
    var imgTop : UIImageView!
    var btnPlay : UIButton!
    let playerController = AVPlayerViewController()
    
    var stackView : UIStackView!
    var btnAbout : UIButton!
    var btnContact : UIButton!
    var focusGuide : UIFocusGuide!
    
    var viewToFocus: UIButton? = nil {
        didSet {
            if viewToFocus != nil {
                self.setNeedsFocusUpdate()
                self.updateFocusIfNeeded()
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0x429295)
        //        GlobalEvent.presentEvent.addHandler { player,playerVC in
        //
        //        }
    }
    
    
    fileprivate func setupView(){
        
        btnAbout = UIButton()
        btnAbout.setTitle("About", for: .normal)
        btnAbout.layer.cornerRadius = 10
        btnAbout.layer.borderWidth = 3
        btnAbout.isHidden = true
        btnAbout.layer.borderColor = UIColor.white.cgColor
        btnAbout.addTarget(self, action: #selector(playVideo), for: .primaryActionTriggered)
        
        
        btnContact = UIButton()
        btnContact.setTitle("Privacy Policy", for: .normal)
        btnContact.layer.cornerRadius = 10
        btnContact.layer.borderWidth = 3
        btnContact.layer.borderColor = UIColor.white.cgColor
        btnContact.addTarget(self, action: #selector(pp), for: .primaryActionTriggered)
        
        stackView = UIStackView(arrangedSubviews: [btnContact,btnAbout])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        centerView = UIView()
        centerView.isUserInteractionEnabled = true
        centerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerView)
        
        imgTop = UIImageView()
        imgTop.image = UIImage(named: "appIcon")
        imgTop.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(imgTop)
        
        btnPlay = UIButton()
        btnPlay.setTitle("Watch now", for: .normal)
        btnPlay.backgroundColor = .clear
        btnPlay.isUserInteractionEnabled = true
        btnPlay.layer.cornerRadius = 10
        btnPlay.layer.borderWidth = 3
        btnPlay.layer.borderColor = UIColor.white.cgColor
        btnPlay.addTarget(self, action: #selector(playVideo), for: .primaryActionTriggered)
        btnPlay.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(btnPlay)
        
        self.animationScaleEffect(view: imgTop, animationTime: 1.0)
        
        focusGuide = UIFocusGuide()
        focusGuide.preferredFocusEnvironments = [btnContact,btnPlay,btnAbout]
        view.addLayoutGuide(focusGuide)
        
        view.addSubview(FocusGuideDebugView(focusGuide: focusGuide))
    }
    
    
    func configureFocusLayout() {
        addFocusGuide(from: btnAbout, to: btnContact, direction: .left)
        addFocusGuide(from: btnContact, to: btnPlay, direction: .bottom)
        addFocusGuide(from: btnAbout, to: btnPlay, direction: .bottom)
        addFocusGuide(from: btnPlay, to: btnContact, direction: .top)
        addFocusGuide(from: btnContact, to: btnAbout, direction: .right)
        
    }
    
    fileprivate func setupLayout(){
        
        //        focusGuide.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.1).isActive = true
        //        focusGuide.heightAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.1).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.06).isActive = true
        
        btnAbout.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.1).isActive = true
        btnContact.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.13).isActive = true
        
        centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        imgTop.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        imgTop.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
        imgTop.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        imgTop.leadingAnchor.constraint(equalTo: centerView.leadingAnchor).isActive = true
        imgTop.trailingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        imgTop.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        
        btnPlay.topAnchor.constraint(equalTo: imgTop.bottomAnchor,constant: 50).isActive = true
        btnPlay.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
        btnPlay.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13).isActive = true
        btnPlay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        btnPlay.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        
    }
    
    func animationScaleEffect(view:UIView,animationTime:Float)
    {
        UIView.animate(withDuration: TimeInterval(animationTime), animations: {
            
            view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
        },completion:{completion in
            UIView.animate(withDuration: TimeInterval(animationTime), animations: { () -> Void in
                
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
        
    }
    
    
    @objc func playVideo(){
        print("hello")
        let url = URL(string: "https://103122.global.ssl.fastly.net/edge/live_4e8e1640bfb211ea909ea10718cdb17d/index.m3u8")!
        DispatchQueue.main.async {
            let player = AVPlayer(url: url)
            self.playerController.player = player
            player.playImmediately(atRate: 1.0)
            self.present(self.playerController, animated: true)
            //            GlobalEvent.presentEvent.raise(data: (player, self.playerController))
        }
    }
    
    
    @objc func contactUs(){
        
    }
    
    @objc func pp(){
        self.navigationController?.pushViewController(PPViewController(), animated: true)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        super.didUpdateFocus(in: context, with: coordinator)
        if context.nextFocusedView == btnContact {
            btnContact.layer.borderColor = UIColor.red.cgColor
            btnAbout.layer.borderColor = UIColor.white.cgColor
            btnPlay.layer.borderColor = UIColor.white.cgColor
        }else if context.previouslyFocusedView == btnAbout {
            btnAbout.layer.borderColor = UIColor.red.cgColor
            btnContact.layer.borderColor = UIColor.white.cgColor
            btnPlay.layer.borderColor = UIColor.white.cgColor
        }
        else {
            btnPlay.layer.borderColor = UIColor.red.cgColor
            btnAbout.layer.borderColor = UIColor.white.cgColor
            btnContact.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureFocusLayout()
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension UIViewController {
    @discardableResult
    func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide {
        return addFocusGuide(from: origin, to: [destination], direction: direction, debugMode: debugMode)
    }

    @discardableResult
    func addFocusGuide(from origin: UIView, to destinations: [UIView], direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide {
        let focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        focusGuide.preferredFocusEnvironments = destinations
        focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

        switch direction {
        case .bottom:
            focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .top:
            focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .left:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .right:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
        default:
            // Not supported :(
            break
        }

//        if debugMode {
//            view.addSubview(FocusGuideDebugView(focusGuide: focusGuide))
//        }

        return focusGuide
    }
}

class FocusGuideDebugView: UIView {

    init(focusGuide: UIFocusGuide) {
        super.init(frame: focusGuide.layoutFrame)
        backgroundColor = UIColor.green.withAlphaComponent(0.15)
        layer.borderColor = UIColor.green.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

