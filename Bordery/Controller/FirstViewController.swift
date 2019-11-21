//
//  FirstViewController.swift
//  Bordery
//
//  Created by Kevin Laminto on 21/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit
import Photos

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLabel1()
        setupLabel2()
        setupNoticeLabel()
        setupPermissionButton()
        setupNextButton()
        setupConstraint()
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
                        self.noticeLabel.text = "Permission granted!"
                        self.permissionButton.isEnabled = false
                        self.permissionButton.layer.borderColor = UIColor.gray.cgColor
                    }
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
                else if status == .denied {
                    TapticEngine.errorTaptic()
                    DispatchQueue.main.async {
                        AlertService.alert(self, title: "Permission Error!", message: "We can't edit your photos without access to your photo library. Please allow access through setting!")
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
            noticeLabel.text = "Permission granted!"
            self.permissionButton.setTitleColor(.gray, for: .normal)
            self.permissionButton.layer.borderColor = UIColor.gray.cgColor
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        else if status == .denied {
            TapticEngine.errorTaptic()
            DispatchQueue.main.async {
                AlertService.alert(self, title: "Permission Error!", message: "We can't edit your photos without access to your photo library. Please allow access through setting!")
            }
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoLibraryViewNav")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion:nil)
    }
    
    fileprivate func setupUI() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        nextButton.isHidden = true
    }
    
    fileprivate func setupLabel1() {
        label1.textColor = .white
        label1.numberOfLines = 0
        label1.text = "Hello!"
        label1.sizeToFit()
        label1.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label1.addCharacterSpacing()
    }
    
    fileprivate func setupLabel2() {
        let attributedString = NSMutableAttributedString(string: "Thank you for downloading Bordery.\nThis app was made with love and passion in Melbourne, Australia by Kevin Laminto.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label2.attributedText = attributedString
        
        label2.textColor = .white
        label2.numberOfLines = 0
        label2.sizeToFit()
        label2.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label2.addCharacterSpacing(kernValue: 0.2)
    }
    
    fileprivate func setupNoticeLabel() {
        let attributedString = NSMutableAttributedString(string: "We need access to your photo library\nso we can help you make some rad photos(:")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        noticeLabel.attributedText = attributedString
        
        noticeLabel.textColor = .gray
        noticeLabel.numberOfLines = 0
        noticeLabel.sizeToFit()
        noticeLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        noticeLabel.addCharacterSpacing(kernValue: 0.2)
    }
    
    fileprivate func setupPermissionButton() {
        var a = "Grant Permission"
        a = a.uppercased()
        permissionButton.backgroundColor = .clear
        permissionButton.setTitle(a, for: .normal)
        permissionButton.titleLabel?.numberOfLines = 0
        permissionButton.titleLabel?.textAlignment = .center
        permissionButton.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        permissionButton.setTitleColor(.white, for: .normal)
        permissionButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 17)
        permissionButton.layer.borderColor = UIColor.white.cgColor
        permissionButton.layer.borderWidth = 1
        permissionButton.layer.cornerRadius = 0
    }
    
    fileprivate func setupNextButton() {
        var a = "Start Editing"
        nextButton.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        a = a.uppercased()
        let icon = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        nextButton.setImage(icon, for: .normal)
        nextButton.tintColor = .black
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        nextButton.backgroundColor = .white
        nextButton.setTitle(a, for: .normal)
        nextButton.titleLabel?.numberOfLines = 0
        nextButton.titleLabel?.textAlignment = .center
        nextButton.titleLabel!.font = UIFont(name: "NewYorkMedium-Semibold", size: 15)
        nextButton.addTextSpacing(0.5)
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 17)
        nextButton.layer.borderColor = UIColor.black.cgColor
    }
    
    fileprivate func setupConstraint() {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            image.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            image.heightAnchor.constraint(equalToConstant: view.frame.width * 0.8)
            
        ])
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label1.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15)
        ])
        
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 5),
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
