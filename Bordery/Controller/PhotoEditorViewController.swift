//
//  PhotoEditorViewController.swift
//  Bordery
//
//  Created by Kevin Laminto on 28/6/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit
import PhotosUI
import Photos
import CoreImage

class PhotoEditorViewController: UIViewController {

    // Global Variables
    let VIEW_HEIGHTMULTIPLIER_CONSTANT: CGFloat = 0.19
    var asset: PHAsset!
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: imageView.bounds.width * scale, height: imageView.bounds.height * scale)
    }
    
    // editorView properties
    lazy var adjustmentFiltersScrollView = UIScrollView()
    lazy var sliderValueLabel = UILabel()
    lazy var adjustmentNameLabel = UILabel()
    // barView Properties
    lazy var barItemOnEditStackView = UIStackView()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var progressDownloadingLabel: UILabel!
    @IBOutlet weak var progressBarOutlet: UIProgressView!
    @IBOutlet weak var progressPercentageLabel: UILabel!
    
    @IBOutlet weak var progressStackView: UIStackView!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the progress bar on default
        hide(progress: true, barItemOnEdit: true, ui: true)

        setupUI()
        setupConstraint()
        // bar item on editing
        setupBarItemOnEdit()
        // Adjustment View
        setupAdjustmentView()

        setupDebug()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateImage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Main Functions
    // image downloading function
    fileprivate func updateImage() {
        hide(progress: false, barItemOnEdit: nil, ui: nil)
        // reset the progressBar value
        progressBarOutlet.progress = 0.0
        
        // Prepare the options to pass when fetching the image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.progressHandler = { (progress, error, _, _) in
            // shows error when there is no internet connection
            if error != nil {
                DispatchQueue.main.async {
                    self.progressDownloadingLabel.text = "Please check your internet connection and try again."
                }
                AlertService.alert(self, title: "No internet Connection!", message: "We cannot download your photos from iCloud. Check your internet Connection and try again.")
                print("Internet Error. at PhotoEditor VC line 105")
            }
            
            // update the UI
            DispatchQueue.main.async {
                self.progressBarOutlet.setProgress(Float(progress), animated: true)
                self.progressPercentageLabel.text = "\(String(format: "%.0f", progress * 100))%"
            }
        }
        // request the image and displaying it.
        if asset != nil {
            PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options,
                                                  resultHandler: { image, _ in
                                                    guard let image = image else { return }
//                                                    self.imageView.image = image
                                                    self.hide(progress: true, barItemOnEdit: nil, ui: false)
                                                    let borderColor = UIColor.white.image()

                                                    let image2: UIImage = UIImage(data: self.blendImages(borderColor, image)!)!
                                                    self.imageView.image = image2
                                                    
            })
        }
    }
    
    // MARK: - Supporting Functions
    fileprivate func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        // progress colour
        progressPercentageLabel.textColor = UIColor.white
        progressBarOutlet.progressTintColor = UIColor.white
        progressDownloadingLabel.textColor = UIColor.white
        // custom text
        progressDownloadingLabel.text = "Downloading image from iCloud..."
        progressPercentageLabel.text = "0%"
        
        setupNavBar()

    }
    
    // create navigation bar
    fileprivate func setupNavBar() {
//        let startingYPos = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let startingYPos = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: startingYPos, width: self.view.bounds.width, height: 44))
        navBar.barTintColor = UIColor(named: "backgroundColor")
        navBar.isTranslucent = false
        navBar.tintColor = UIColor.white
        let navItem = UINavigationItem(title: "Bordery")
        
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(cancelAction))
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: true)
        
        self.view.addSubview(navBar)
    }
    
    // create constraint
    fileprivate func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
            ])
        
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressStackView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            progressStackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            ])
        
        editorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editorView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            editorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            editorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            editorView.heightAnchor.constraint(equalToConstant: view.frame.height * VIEW_HEIGHTMULTIPLIER_CONSTANT)
            ])

        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: editorView.bottomAnchor),
            barView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barView.leftAnchor.constraint(equalTo: view.leftAnchor),
            barView.rightAnchor.constraint(equalTo: view.rightAnchor),
            barView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    // for debugging
    fileprivate func setupDebug() {
        editorView.backgroundColor = .clear
        barView.backgroundColor = .clear
        imageView.backgroundColor = .clear
    }

    
    // MARK: - Selector functions
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // function for barItem on Edit
    @objc func cancelButtonTapped() {
        hide(progress: nil, barItemOnEdit: true, ui: nil)
        adjustmentFiltersScrollView.isHidden = false
    }
    
    @objc func checkButtonTapped() {
        hide(progress: nil, barItemOnEdit: true, ui: nil)
        adjustmentFiltersScrollView.isHidden = false
        
    }
    
} // end of class
