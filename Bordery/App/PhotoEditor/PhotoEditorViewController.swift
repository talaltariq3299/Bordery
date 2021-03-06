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
    let VIEW_HEIGHTMULTIPLIER_CONSTANT: CGFloat = 0.18
    var asset: PHAsset!
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: imageView.bounds.width * scale, height: imageView.bounds.height * scale)
    }
    var imageEngine = ImageEngine()
    var colourSelector: ColourEngine!
    var ratioSelector: RatioEngine!
    var oriImage: UIImage!
    var exportSelector: ExportEngine!
    var datestampEngine: DatestampEngine!
    
    // editorView properties
    lazy var sizeButton = UIButton()
    lazy var colourButton = UIButton()
    lazy var ratioButton = UIButton()
    lazy var datestampButton = UIButton()
    // size
    lazy var sliderValueLabel = UILabel()
    lazy var adjustmentNameLabel = UILabel()
    // colour
    lazy var colourSelectorScrollView = UIScrollView()
    lazy var borderView = UIView()
    //Ratio
    lazy var ratioSelectorScrollView = UIScrollView()
    lazy var noticeLabel = UILabel()
    //datestamp
    lazy var hasDate = false
    lazy var datestamp = UILabel()
    lazy var dateColourSelectorScrollView = UIScrollView()
    lazy var dateText = UITextField()
    lazy var counter = 0
    lazy var allignmentArray: [NSTextAlignment] = [.right, .left, .center]
    lazy var hasDateCounter = 0
    lazy var hasDateArray = [true, false]
    var toolBarFunction: ToolBarView!
    lazy var fontScrollIsHiddenCounter = 0
    lazy var fontScrollView = UIScrollView()
    
    // barView Properties
    lazy var menuBarBackgroundView = UIView()
    lazy var barItemOnEditStackView = UIStackView()
    lazy var borderButton = UIButton()
    lazy var saveButton = UIButton()
    lazy var adjustmentButton = UIButton()
    
    // export
    lazy var exportSelectorScrollView = UIScrollView()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTop: UIImageView!
    @IBOutlet weak var editorView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var progressDownloadingLabel: UILabel!
    @IBOutlet weak var progressBarOutlet: UIProgressView!
    @IBOutlet weak var progressPercentageLabel: UILabel!
    @IBOutlet weak var adjustmentSliderOutlet: UISlider!
    
    @IBOutlet weak var progressStackView: UIStackView!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the elements on default
        hide(progress: true, barItemOnEdit: true, ui: true, slider: true, colourSelector: true, ratioSelector: true)
        exportButtonHide(true)
        dateColourHide(true)
        
        setupUI()
        setupBarItemOnEdit() // bar item on editing (x or checkmark)
        setupMenuBar()
        
        //editorView
        setupMainButtons()
        setupAdjustmentSlider()
        setupColourSelector()
        setupRatioSelector()
        setupExportSelector()
        setupDatestampView()
        
        setupConstraint()
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
        hide(progress: false, barItemOnEdit: nil, ui: nil, slider: nil, colourSelector: nil, ratioSelector: nil)
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
                    AlertService.alert(self, title: "No internet Connection!", message: "We cannot download your photos from iCloud. Check your internet Connection and try again.")
                }
                print("Internet Error. at PhotoEditor updateImage function.")
            }
            
            // update the UI
            DispatchQueue.main.async {
                self.progressBarOutlet.setProgress(Float(progress), animated: true)
                self.progressPercentageLabel.text = "\(String(format: "%.0f", progress * 100))%"
            }
        }
        // request the image and displaying it.
        if asset != nil {
            PHImageManager.default().requestImage(
                for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options,
                resultHandler: { image, _ in
                    guard let image = image else {
                        print("Attempt to request an invalid image! updateImage function.")
                        return
                    }
                    self.hide(progress: true, barItemOnEdit: nil, ui: false, slider: nil, colourSelector: nil, ratioSelector: nil)
                    
                    // the top image
                    self.imageViewTop.image = image
                    self.oriImage = image
                    
                    // final rendering
                    self.imageViewTop.image = self.imageEngine.createRenderImage(foregroundImage: self.imageViewTop.image!, backgroundImageFrame: self.imageViewTop.contentClippingRect)
                    self.borderView.frame = self.imageViewTop.contentClippingRect
                    
                    // the borderView or the border color view.
                    self.borderView.backgroundColor = self.colourSelector.currentColour
                    self.imageView.addSubview(self.borderView)
                    
                    self.imageEngine.imgSizeMultiplier = 0.0
                    self.imageEngine.sliderCurrentValue = 0.0
                    
                    if image.size.width == image.size.height {
                        let a = UIButton()
                        a.tag = 1
                        a.setTitle("override", for: .normal)
                        self.ratioTapped(sender: a)
                    }
                    
                    // create a custom colour and append to the colour selector screen
                    DispatchQueue.main.async {
                        // add the border
                        let customColorButton: [UIButton] = self.colourSelector.colorFromImage(image: self.oriImage)
                        
                        customColorButton.last!.addTarget(self, action: #selector(self.colourTapped), for: .touchUpInside)
                        for button in customColorButton {
                            self.colourSelectorScrollView.addSubview(button)
                        }
                        
                        // rearrange to fit the content
                        self.colourSelectorScrollView.contentSize = CGSize(width: self.colourSelector.buttonWidth * CGFloat(Double(self.colourSelector.colourName.count + customColorButton.count) + 1.3), height: self.colourSelectorScrollView.frame.height)
                    }
                    
                    // add a default timestamp
                    self.datestamp = self.adjustDateStamp(datestamp: self.datestampEngine.datestamp(), allignment: .right)
                    self.datestamp.tag = ViewTagReserved.datestamp.rawValue
                    self.imageViewTop.addSubview(self.datestamp)
                    self.datestamp.isHidden = true
                    self.datestamp.backgroundColor = .red
            })
        }
    }
    
    // MARK: - Supporting Functions
    fileprivate func setupUI() {
        adjustmentNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        adjustmentNameLabel.textColor = UIColor.white
        adjustmentNameLabel.textAlignment = .center
        adjustmentNameLabel.numberOfLines = 0
        
        noticeLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 21)
        noticeLabel.textAlignment = .center
        noticeLabel.text = "The app will automatically adjust the ratio and return to the previous screen."
        noticeLabel.textColor = .gray
        noticeLabel.font = UIFont.systemFont(ofSize: 11)
        noticeLabel.numberOfLines = 0
        noticeLabel.sizeToFit()
        
        noticeLabel.isHidden = true
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        // progress colour
        progressPercentageLabel.textColor = UIColor.white
        progressBarOutlet.progressTintColor = UIColor.white
        progressDownloadingLabel.textColor = UIColor.white
        // custom text
        progressDownloadingLabel.text = "Downloading image from iCloud..."
        progressPercentageLabel.text = "0%"
        
        setupNavBar()
        
        barView.addSubview(addTopBorder(with: UIColor(named: "backgroundSecondColor"), andWidth: 1, to: barView))
        menuBarBackgroundView.frame = barView.frame
        menuBarBackgroundView.backgroundColor = UIColor(displayP3Red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
        barView.addSubview(menuBarBackgroundView)
        
        barView.sendSubviewToBack(menuBarBackgroundView)
        
    }
    
    // create navigation bar
    fileprivate func setupNavBar() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let startingYPos = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let navItem = UINavigationItem(title: "Bordery.")
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: startingYPos, width: view.bounds.width, height: 44))
        navBar.barTintColor = UIColor(named: "backgroundColor")
        navBar.isTranslucent = false
        navBar.tintColor = UIColor.white
        guard let customFont = UIFont(name: "NewYorkMedium-Semibold", size: 20) else {
            fatalError("Failed to load the font")
        }
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: customFont]
        navBar.setItems([navItem], animated: true)

        view.addSubview(navBar)
    }
    
    // for debugging
    fileprivate func setupDebug() {
        editorView.backgroundColor = .clear
        barView.backgroundColor = .clear
        imageView.backgroundColor = .clear
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        // convert the range
        var ratioConverter = RangeConverter(oldMax: sender.maximumValue, oldMin: sender.minimumValue, newMax: 10, newMin: 0, oldValue: sender.value)
        let newValue = ratioConverter.getNewValueStr(decimalPlace: 1)
        DispatchQueue.main.async {
            self.sliderValueLabel.text = "\(newValue) pts"
        }
        let y:Float = (sender.minimumValue + sender.maximumValue) - sender.value
        let imgSizeMultiplier: CGFloat = CGFloat(y)
        
        imageViewTop.transform = CGAffineTransform(scaleX: imgSizeMultiplier, y: imgSizeMultiplier)
    }
    
    // MARK: - Selector functions
    @objc func cancelAction() {
        var actions: [UIAlertAction] = []
        
        let okAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actions.append(okAction)
        actions.append(cancelAction)
        
        AlertService.alertAction(self, title: "", message: "Would you like to go back to camera library?", actions: actions)
        
    }
    
    // function for barItem on Edit
    @objc func cancelButtonTapped(sender: UIButton!) {
        TapticEngine.lightTaptic()
        menuBarHide(false)
        sender.setTitleColor(.white, for: .normal)
        
        switch adjustmentNameLabel.text {
        case imageEngine.adjustmentName[0]:
            mainButtonHide(false)
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: true, colourSelector: nil, ratioSelector: nil)
            
            // reset the configuration back to its previous state
            adjustmentSliderOutlet.value = imageEngine.sliderCurrentValue
            sliderValueLabel.text = "\(imageEngine.sliderCurrentValueRatio) pts"
            imageViewTop.transform = CGAffineTransform(scaleX: imageEngine.imgSizeMultiplierCurrent, y: imageEngine.imgSizeMultiplierCurrent)
            
        case imageEngine.adjustmentName[1]:
            mainButtonHide(false)
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: nil, colourSelector: true, ratioSelector: nil)
            
            // reset the configuration back to it previous state
            borderView.backgroundColor = colourSelector.currentColour
            
        case imageEngine.adjustmentName[2]:
            mainButtonHide(false)
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: nil, colourSelector: nil, ratioSelector: true)
            
        case Effects.datestamp.rawValue:
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: nil, colourSelector: nil, ratioSelector: nil)
            dateColourHide(true)
            effectsButtonHide(false)
            datestamp.textColor = datestampEngine.currentColour
            datestamp.isHidden = datestampEngine.isHidden
            hasDateCounter = (hasDateCounter + 1) % hasDateArray.count
            
            // datestamp font
            self.datestamp.font = datestampEngine.dateFont
            
        default:
            print("No execution detected! PhotoEditorVC cancelButtonTapped function")
        }
    }
    
    @objc func checkButtonTapped(sender: UIButton!) {
        TapticEngine.lightTaptic()
        menuBarHide(false)
        sender.setTitleColor(.white, for: .normal)
        
        switch adjustmentNameLabel.text {
        case imageEngine.adjustmentName[0]:
            mainButtonHide(false)
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: true, colourSelector: nil, ratioSelector: nil)
            
            // convert to 0 - 0.5 range for blending
            var ratioConverter = RangeConverter(oldMax: adjustmentSliderOutlet.maximumValue, oldMin: adjustmentSliderOutlet.minimumValue, newMax: 0.5, newMin: 0, oldValue: adjustmentSliderOutlet.value)
            imageEngine.imgSizeMultiplier = CGFloat(ratioConverter.getNewValueFloat())
            imageEngine.sliderCurrentValue = adjustmentSliderOutlet.value
            
            // convert to 0 - 10 range and store current value for future undo.
            var ratioConverter2 = RangeConverter(oldMax: adjustmentSliderOutlet.maximumValue, oldMin: adjustmentSliderOutlet.minimumValue, newMax: 10, newMin: 0, oldValue: adjustmentSliderOutlet.value)
            imageEngine.sliderCurrentValueRatio = ratioConverter2.getNewValueStr(decimalPlace: 1)
            imageEngine.imgSizeMultiplierCurrent = imageViewTop.transform.a
            
        case imageEngine.adjustmentName[1]:
            mainButtonHide(false)
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: nil, colourSelector: true, ratioSelector: nil)
            colourSelector.currentColour = borderView.backgroundColor!
            
            
        case imageEngine.adjustmentName[2]:
            mainButtonHide(false)
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: nil, colourSelector: nil, ratioSelector: true)
            
        case Effects.datestamp.rawValue:
            hide(progress: nil, barItemOnEdit: true, ui: nil, slider: nil, colourSelector: nil, ratioSelector: nil)
            dateColourHide(true)
            effectsButtonHide(false)
            datestampEngine.currentColour = datestamp.textColor
            datestampEngine.isHidden = datestamp.isHidden
            
            //datestamp font
            datestampEngine.dateFont = self.datestamp.font
            
        default:
            fatalError("No execution detected! PhotoEditorVC checkButtonTapped function")
        }
        
    }
    
} // end of class

