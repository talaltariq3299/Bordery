//
//  FirstViewController.swift
//  Bordery
//
//  Created by Kevin Laminto on 21/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit
import Photos
import SwiftConfettiView
import BonMot

class FirstViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var permissionButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var noticeLabel: UILabel!
    
    
    var confettiView: SwiftConfettiView!
    let confettiButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var isConfetti = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLabel1()
        setupLabel2()
        setupNoticeLabel()
        setupPermissionButton()
        setupNextButton()
        setupConstraint()
        setupConfettiButton()
        
        // confetti adjustment
        confettiView = SwiftConfettiView(frame: self.view.bounds)
        confettiView.isUserInteractionEnabled = false
        confettiView.type = .confetti
        self.view.addSubview(confettiView)
        confettiView.startConfetti()
        perform(#selector(confettiTimeStop), with: nil, afterDelay: 3)
    }
    
    @objc func stopConfetti() {
        confettiView.stopConfetti()
    }
    
    @objc func confettiTimeStop() {
        stopConfetti()
        confettiButton.tintColor = .red
    }

    @IBAction func permissionButtonTapped(_ sender: Any) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    TapticEngine.successTaptic()
                    DispatchQueue.main.async {
                        UIView.transition(with: self.nextButton, duration: 0.25, options: .transitionCrossDissolve, animations: {
                            self.nextButton.isHidden = false
                        })
                        let text1 = "Happy editing! 😍"
                        let text2 = ""
                        self.label1.attributedText = text1.styled(with: Typography.titleLarge())
                        self.noticeLabel.attributedText = text2.styled(with: Typography.subbodyLarge())
                        self.permissionButton.isEnabled = false
                        self.permissionButton.layer.borderColor = UIColor.gray.cgColor
                        let a = "PERMISSION GRANTED"
                        let style = StringStyle(
                            .color(.gray),
                            .font(UIFont.systemFont(ofSize: 13, weight: .regular)),
                            .tracking(.point(0.3))
                        )
                        self.permissionButton.setAttributedTitle(a.styled(with: style), for: .normal)
                    }
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
                else if status == .denied {
                    TapticEngine.errorTaptic()
                    DispatchQueue.main.async {
                        AlertService.alert(self, title: "Permission Error!", message: "We can't edit your photos without access to your photo library. Please allow access through setting!")
                        let text1 = "Is this what betrayal feels like? 😢"
                        self.label1.attributedText = text1.styled(with: Typography.titleLarge())
                    }
                    

                }
            })
        }
        else if status == .authorized {
            TapticEngine.successTaptic()
            UIView.transition(with: nextButton, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.nextButton.isHidden = false
            })
            permissionButton.isEnabled = false
            let text1 = "Happy editing! 😍"
            let text2 = ""
            self.label1.attributedText = text1.styled(with: Typography.titleLarge())
            self.noticeLabel.attributedText = text2.styled(with: Typography.subbodyLarge())
            self.permissionButton.layer.borderColor = UIColor.gray.cgColor
            let a = "PERMISSION GRANTED"
            let style = StringStyle(
                .color(.gray),
                .font(UIFont.systemFont(ofSize: 13, weight: .regular)),
                .tracking(.point(0.3))
            )
            self.permissionButton.setAttributedTitle(a.styled(with: style), for: .normal)
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        else if status == .denied {
            TapticEngine.errorTaptic()
            DispatchQueue.main.async {
                AlertService.alert(self, title: "Permission Error!", message: "We can't edit your photos without access to your photo library. Please allow access through setting!")
                let text1 = "Is this what betrayal feels like? 😢"
                self.label1.attributedText = text1.styled(with: Typography.titleLarge())
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        TapticEngine.lightTaptic()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoLibraryViewNav")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion:nil)
    }
    
    fileprivate func setupUI() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.isHidden = true
        permissionButton.isEnabled = true
    }
    
    fileprivate func setupLabel1() {
        let text = "Hello!"
        
        label1.attributedText = text.styled(with: Typography.titleLarge())
        label1.textColor = .white
        label1.numberOfLines = 0
        label1.sizeToFit()
    }
    
    fileprivate func setupLabel2() {
        let text = "Thank you for downloading Bordery.\nThis app was made with love and passion in Melbourne, Australia by Kevin Laminto."

        label2.attributedText = text.styled(with: Typography.bodyLarge())
        label2.textColor = .white
        label2.numberOfLines = 0
        label2.sizeToFit()
    }
    
    fileprivate func setupNoticeLabel() {
        let text = "We need access to your photo library\nso we can help you make some rad photos(:"
        
        noticeLabel.attributedText = text.styled(with: Typography.subbodyLarge())
        noticeLabel.textColor = .gray
        noticeLabel.numberOfLines = 0
        noticeLabel.sizeToFit()

    }
    
    fileprivate func setupPermissionButton() {
        var a = "Grant Permission"
        a = a.uppercased()
        let style = StringStyle(
            .color(.white),
            .font(UIFont.systemFont(ofSize: 13, weight: .regular)),
            .tracking(.point(0.3))
        )
        permissionButton.setAttributedTitle(a.styled(with: style), for: .normal)
        permissionButton.backgroundColor = .clear
        permissionButton.titleLabel?.numberOfLines = 0
        permissionButton.titleLabel?.textAlignment = .center
        permissionButton.setTitleColor(.white, for: .normal)
        permissionButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 17)
        permissionButton.layer.borderColor = UIColor.white.cgColor
        permissionButton.layer.borderWidth = 1
        permissionButton.layer.cornerRadius = 0
    }
    
    fileprivate func setupNextButton() {
        var a = "Start Editing"
        a = a.uppercased()
        let style = StringStyle(
            .color(.black),
            .font(UIFont(name: "NewYorkMedium-Semibold", size: 14)!),
            .tracking(.point(0.3))
        )
        nextButton.setAttributedTitle(a.styled(with: style), for: .normal)
        
        nextButton.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        let icon = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        nextButton.setImage(icon, for: .normal)
        nextButton.tintColor = .black
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 2)
        nextButton.backgroundColor = .white
        nextButton.titleLabel?.numberOfLines = 0
        nextButton.titleLabel?.textAlignment = .center
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 17)
        nextButton.layer.borderColor = UIColor.black.cgColor
    }
    
    fileprivate func setupConfettiButton() {
        confettiButton.setImage(UIImage(named: "confetti-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        confettiButton.addTarget(self, action: #selector(confettiButtonTapped), for: .touchUpInside)
        self.view.addSubview(confettiButton)
        
        confettiButton.tintColor = .green
        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confettiButton.leftAnchor.constraint(equalTo: permissionButton.rightAnchor, constant: 30),
            confettiButton.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 35),
            confettiButton.widthAnchor.constraint(equalToConstant: 25),
            confettiButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
    @objc func confettiButtonTapped() {
        if isConfetti {
            TapticEngine.lightTaptic()
            isConfetti = false
            confettiButton.tintColor = .red
            confettiView.stopConfetti()
        }
        else {
            TapticEngine.lightTaptic()
            isConfetti = true
            confettiButton.tintColor = .green
            confettiView.startConfetti()
        }
    }
    
    fileprivate func setupConstraint() {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            image.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6),
            image.heightAnchor.constraint(equalToConstant: view.frame.width * 0.6)
        ])
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label1.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15)
        ])
        
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 3),
            label2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])
        
        permissionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            permissionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            permissionButton.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 30)
        ])
        
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noticeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            noticeLabel.topAnchor.constraint(equalTo: permissionButton.bottomAnchor, constant: 5)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

}
