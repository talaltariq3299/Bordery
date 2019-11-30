//
//  PhotoEditorVC_Extension+.swift
//  Bordery
//
//  Created by Kevin Laminto on 5/7/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

extension PhotoEditorViewController {
    
    //------------------------------
    // MARK: - Main buttons
    // main buttons for the app
    func setupMainButtons() {
        // variables
        let sizeIcon = UIImage(named: "size-icon")!.withRenderingMode(.alwaysTemplate)
        let colourIcon = UIImage(named: "colour-icon")!.withRenderingMode(.alwaysTemplate)
        let ratioIcon = UIImage(named: "ratio-icon")!.withRenderingMode(.alwaysTemplate)
        
        sizeButton = MainButton.createButton(buttonIcon: sizeIcon, buttonName: borderEngine.adjustmentName[0], buttonTag: 0)
        sizeButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        sizeButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        sizeButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        
        colourButton = MainButton.createButton(buttonIcon: colourIcon, buttonName: borderEngine.adjustmentName[1], buttonTag: 1)
        colourButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        colourButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        colourButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        
        ratioButton = MainButton.createButton(buttonIcon: ratioIcon, buttonName: borderEngine.adjustmentName[2], buttonTag: 2)
        ratioButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        ratioButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        ratioButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        
        setupEffectsButton()
        
        self.editorView.addSubview(sizeButton)
        self.editorView.addSubview(colourButton)
        self.editorView.addSubview(ratioButton)
    }
    
    func setupEffectsButton() {
        let datestampIcon = UIImage(named: "datestamp-icon")!.withRenderingMode(.alwaysTemplate)
        // datestamp
        datestampButton = MainButton.createButton(buttonIcon: datestampIcon, buttonName: "Date stamp", buttonTag: 3)
        datestampButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        datestampButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        datestampButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        effectsButtonHide(true)
        editorView.addSubview(datestampButton)
    }
    
    //------------------------------
    // MARK: - Main buttons components
    // create a slider for adjusting the image
    func setupAdjustmentSlider() {
        editorView.addSubview(sliderValueLabel)
        editorView.addSubview(adjustmentNameLabel)
        
        adjustmentSliderOutlet.maximumValue = 1.0
        adjustmentSliderOutlet.minimumValue = 0.5
        adjustmentSliderOutlet.value = 0.5
        
        adjustmentSliderOutlet.maximumTrackTintColor = UIColor(named: "backgroundSecondColor")
        adjustmentSliderOutlet.minimumTrackTintColor = UIColor.gray
        adjustmentSliderOutlet.thumbTintColor = UIColor.white
        
        // setup labels
        sliderValueLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        sliderValueLabel.text = "0.0 pts"
        sliderValueLabel.textColor = UIColor.white
        sliderValueLabel.textAlignment = .center
        sliderValueLabel.numberOfLines = 0
    }
    
    // create colour selectors
    func setupColourSelector() {
        colourSelector = ColourEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(colourSelectorScrollView)
        colourSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // instantiate
        let colourButtons: [UIButton] = colourSelector.createButtonArray()
        
        for colourButton in colourButtons {
            colourButton.addTarget(self, action: #selector(colourTapped), for: .touchUpInside)
            colourSelectorScrollView.addSubview(colourButton)
        }
    }
    
    // create export buttons
    func setupExportSelector() {
        exportSelector = ExportEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(exportSelectorScrollView)
        exportSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // instantiate
        let exportButtons: [UIButton] = exportSelector.createButtonArray()
        
        for exportButton in exportButtons {
            exportSelectorScrollView.addSubview(exportButton)
            exportButton.addTarget(self, action: #selector(exportTapped), for: .touchUpInside)
        }
        
        // rearrange to fit the content
        exportSelectorScrollView.contentSize = CGSize(width: exportSelector.buttonWidth * CGFloat(Double(exportSelector.exportName.count) + 0.6), height: exportSelectorScrollView.frame.height)
    }
    
    // create ratio selectors
    func setupRatioSelector() {
        ratioSelector = RatioEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(ratioSelectorScrollView)
        barView.addSubview(noticeLabel)
        ratioSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // instantiate
        let ratioButtons: [UIButton] = ratioSelector.createButtonArray()
        
        for ratioButton in ratioButtons {
            ratioButton.addTarget(self, action: #selector(ratioTapped), for: .touchUpInside)
            ratioSelectorScrollView.addSubview(ratioButton)
        }
        
        // rearrange to fit the content
        ratioSelectorScrollView.contentSize = CGSize(width: ratioSelector.buttonWidth * CGFloat(Double(ratioSelector.ratioName.count) + 1.3), height: colourSelectorScrollView.frame.height)
    }
    
    // datestamp
    func setupDatestampView() {
        datestampEngine = DatestampEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(dateColourSelectorScrollView)
        dateColourSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // Functions
        let dateColourFunctionButtons = datestampEngine.createDateFunction()
        for button1 in dateColourFunctionButtons {
            switch button1.tag {
            case 99, 100:
                button1.addTarget(self, action: #selector(datestampFunctionTapped), for: .touchUpInside)
            default:
                print("Attempt to add a function to a non existing button tag. (setupDatestampView function)")
            }
            dateColourSelectorScrollView.addSubview(button1)
        }
        
        // colour buttons array
        let dateColourButtons: [UIButton] = datestampEngine.createButtonArray()
        for dateColourButton in dateColourButtons {
            dateColourButton.addTarget(self, action: #selector(datestampFunctionTapped), for: .touchUpInside)
            dateColourSelectorScrollView.addSubview(dateColourButton)
        }
        
        dateColourSelectorScrollView.contentSize = CGSize(width: datestampEngine.buttonWidth * CGFloat(Double(datestampEngine.colourName.count + dateColourFunctionButtons.count) + 0.4), height: dateColourSelectorScrollView.frame.height)
    }
    
    func adjustDateStamp(datestamp: UILabel, allignment: NSTextAlignment) -> UILabel {
        let imageFrameY = imageViewTop.contentClippingRect.maxY * 0.9
        var imageFrameX = imageViewTop.contentClippingRect.maxX * 0.85
        switch allignment {
        case .left:
            imageFrameX = imageViewTop.contentClippingRect.maxX * 0.20
        case .center:
            imageFrameX = imageViewTop.contentClippingRect.midX
        default:
            break
        }

        datestamp.center = CGPoint(x: imageFrameX, y: imageFrameY)
        
        return datestamp
    }
    
    //------------------------------
    // MARK: - Menu bar
    // create bar items to present option to proceed or not on an edit
    func setupBarItemOnEdit() {
        barItemOnEditStackView.translatesAutoresizingMaskIntoConstraints = false
        barItemOnEditStackView.axis = .horizontal
        barItemOnEditStackView.distribution = .fillProportionally
        barView.addSubview(barItemOnEditStackView)
        
        NSLayoutConstraint.activate([
            barItemOnEditStackView.topAnchor.constraint(equalTo: barView.topAnchor),
            barItemOnEditStackView.leftAnchor.constraint(equalTo: barView.leftAnchor),
            barItemOnEditStackView.rightAnchor.constraint(equalTo: barView.rightAnchor),
            barItemOnEditStackView.bottomAnchor.constraint(equalTo: barView.bottomAnchor),
        ])
        
        let cancelButton = BarItemEdit.createBarItemButton(title: "☓")
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        cancelButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        let cancelButtonWrapper = UIView()
        cancelButtonWrapper.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: cancelButtonWrapper.topAnchor, constant: 5),
            cancelButton.bottomAnchor.constraint(equalTo: cancelButtonWrapper.bottomAnchor, constant: -5),
            cancelButton.leftAnchor.constraint(equalTo: cancelButtonWrapper.leftAnchor, constant: 5),
            cancelButton.rightAnchor.constraint(equalTo: cancelButtonWrapper.rightAnchor, constant: -5)
        ])
        
        let checkButton = BarItemEdit.createBarItemButton(title: "✓")
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        checkButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        let checkButtonWrapper = UIView()
        checkButtonWrapper.addSubview(checkButton)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: checkButtonWrapper.topAnchor, constant: 5),
            checkButton.bottomAnchor.constraint(equalTo: checkButtonWrapper.bottomAnchor, constant: -5),
            checkButton.leftAnchor.constraint(equalTo: checkButtonWrapper.leftAnchor, constant: 5),
            checkButton.rightAnchor.constraint(equalTo: checkButtonWrapper.rightAnchor, constant: -5)
        ])
        
        barItemOnEditStackView.addArrangedSubview(cancelButtonWrapper)
        barItemOnEditStackView.addArrangedSubview(checkButtonWrapper)
        
        
    }

    // create main menu bar
    func setupMenuBar() {
        let saveIcon = UIImage(named: "save-icon")!.withRenderingMode(.alwaysTemplate)
        let borderIcon = UIImage(named: "border-icon")!.withRenderingMode(.alwaysTemplate)
        let adjustmentIcon = UIImage(named: "adjustment-icon")!.withRenderingMode(.alwaysTemplate)
        
        borderButton = MenuBarButton.createButton(buttonIcon: borderIcon, buttonTag: 0, isActive: true)
        borderButton.addTarget(self, action: #selector(menuBarTapped), for: .touchUpInside)
        
        saveButton = MenuBarButton.createButton(buttonIcon: saveIcon, buttonTag: 1, isActive: false)
        saveButton.addTarget(self, action: #selector(menuBarTapped), for: .touchUpInside)
        
        adjustmentButton = MenuBarButton.createButton(buttonIcon: adjustmentIcon, buttonTag: 2, isActive: false)
        adjustmentButton.addTarget(self, action: #selector(menuBarTapped), for: .touchUpInside)

        self.barView.addSubview(borderButton)
        self.barView.addSubview(saveButton)
        self.barView.addSubview(adjustmentButton)
    }
    
    
    // MARK: - Hide elements function
    func hide(progress: Bool?, barItemOnEdit: Bool?, ui: Bool?, slider: Bool?, colourSelector: Bool?, ratioSelector: Bool?) {
        if let progress = progress {
            self.progressDownloadingLabel.isHidden = progress
            self.progressPercentageLabel.isHidden = progress
            self.progressBarOutlet.isHidden = progress
        }
        if let barItemOnEdit = barItemOnEdit {
            barItemOnEditStackView.isHidden = barItemOnEdit
        }
        if let ui = ui {
            editorView.isHidden = ui
            barView.isHidden = ui
        }
        if let slider = slider {
            adjustmentSliderOutlet.isHidden = slider
            sliderValueLabel.isHidden = slider
            adjustmentNameLabel.isHidden = slider
        }
        if let colourSelector = colourSelector {
            adjustmentNameLabel.isHidden = colourSelector
            colourSelectorScrollView.isHidden = colourSelector
        }
        if let ratioSelector = ratioSelector {
            adjustmentNameLabel.isHidden = ratioSelector
            ratioSelectorScrollView.isHidden = ratioSelector
        }
    }
    
    func exportButtonHide(_ bool: Bool) {
        adjustmentNameLabel.isHidden = bool
        exportSelectorScrollView.isHidden = bool
    }

    // this function is to hide the main buttons for showing detailed panel.
    func mainButtonHide(_ bool: Bool) {
        colourButton.isHidden = bool
        sizeButton.isHidden = bool
        ratioButton.isHidden = bool
    }
    
    func effectsButtonHide(_ bool: Bool) {
        datestampButton.isHidden = bool
    }
    
    // this function is to hide the menu bar buttons.
    func menuBarHide(_ bool: Bool) {
        borderButton.isHidden = bool
        saveButton.isHidden = bool
        adjustmentButton.isHidden = bool
    }
    
    func dateColourHide(_ bool: Bool) {
        adjustmentNameLabel.isHidden = bool
        dateColourSelectorScrollView.isHidden = bool
    }
    
    // MARK: - Constraints
    func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
        ])
        
        imageViewTop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            imageViewTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewTop.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageViewTop.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            imageViewTop.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
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
        
        sizeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor, constant: -130),
            sizeButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor ,constant: -5),
            sizeButton.heightAnchor.constraint(equalToConstant: 120),
            sizeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        colourButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            colourButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor, constant: -5),
            colourButton.heightAnchor.constraint(equalToConstant: 120),
            colourButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        ratioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratioButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor, constant: 130),
            ratioButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor, constant: -5),
            ratioButton.heightAnchor.constraint(equalToConstant: 120),
            ratioButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.heightAnchor.constraint(equalToConstant: 49),
            barView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barView.leftAnchor.constraint(equalTo: view.leftAnchor),
            barView.rightAnchor.constraint(equalTo: view.rightAnchor),
            barView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        menuBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBarBackgroundView.topAnchor.constraint(equalTo: barView.topAnchor),
            menuBarBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuBarBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuBarBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            menuBarBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        datestampButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datestampButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor, constant: -130),
            datestampButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor ,constant: -5),
            datestampButton.heightAnchor.constraint(equalToConstant: 120),
            datestampButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // setup the constraints for the labels and slider.
        adjustmentSliderOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentSliderOutlet.topAnchor.constraint(equalTo: editorView.topAnchor, constant: 50),
            adjustmentSliderOutlet.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            adjustmentSliderOutlet.widthAnchor.constraint(equalToConstant: editorView.frame.height * 1.6),
            adjustmentSliderOutlet.heightAnchor.constraint(equalToConstant: editorView.frame.height * 0.2)
        ])
        
        sliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderValueLabel.topAnchor.constraint(equalTo: adjustmentSliderOutlet.bottomAnchor, constant: 8),
            sliderValueLabel.centerXAnchor.constraint(equalTo: adjustmentSliderOutlet.centerXAnchor)
        ])
        
        adjustmentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentNameLabel.topAnchor.constraint(equalTo: editorView.topAnchor, constant: 15),
            adjustmentNameLabel.centerXAnchor.constraint(equalTo: editorView.centerXAnchor)
        ])
        
        colourSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            colourSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            colourSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            colourSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        ratioSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratioSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            ratioSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            ratioSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            ratioSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        exportSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exportSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            exportSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            exportSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            exportSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        dateColourSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateColourSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            dateColourSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            dateColourSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            dateColourSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        borderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderButton.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 0.33),
            borderButton.leftAnchor.constraint(equalTo: barView.leftAnchor, constant: 0),
            borderButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 0.33),
            saveButton.rightAnchor.constraint(equalTo: barView.rightAnchor, constant: 0),
            saveButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
        
        adjustmentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentButton.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 0.33),
            adjustmentButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor, constant: 0),
            adjustmentButton.heightAnchor.constraint(equalTo: barView.heightAnchor),
        ])
        
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noticeLabel.centerXAnchor.constraint(equalTo: barView.centerXAnchor),
            noticeLabel.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            noticeLabel.leftAnchor.constraint(equalTo: barView.leftAnchor, constant: 10),
            noticeLabel.rightAnchor.constraint(equalTo: barView.rightAnchor, constant: -10)
        ])
    }
    
    // from https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat, to: UIView) -> UIView {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: to.frame.size.width, height: borderWidth)
        
        return border
    }
    
    // MARK: - Objc Functions
    @objc func mainButtonTapped(sender: UIButton!) {
        TapticEngine.lightTaptic()
        switch sender.tag {
        // border
        case 0:
            sender.tintColor = .white
            adjustmentNameLabel.text = borderEngine.adjustmentName[0]
            mainButtonHide(true)
            menuBarHide(true)
            hide(progress: nil, barItemOnEdit: false, ui: nil, slider: false, colourSelector: nil, ratioSelector: nil)
        // colour
        case 1:
            sender.tintColor = .white
            adjustmentNameLabel.text = borderEngine.adjustmentName[1]
            mainButtonHide(true)
            menuBarHide(true)
            hide(progress: nil, barItemOnEdit: false, ui: nil, slider: nil, colourSelector: false, ratioSelector: nil)
        // ratio
        case 2:
            sender.tintColor = .white
            adjustmentNameLabel.text = borderEngine.adjustmentName[2]
            mainButtonHide(true)
            menuBarHide(true)
            noticeLabel.isHidden = false
            hide(progress: nil, barItemOnEdit: nil, ui: nil, slider: nil, colourSelector: nil, ratioSelector: false)
        // datestamp
        case 3:
            sender.tintColor = .white
            adjustmentNameLabel.text = Effects.datestamp.rawValue
            dateColourHide(false)
            effectsButtonHide(true)
            menuBarHide(true)
            hide(progress: nil, barItemOnEdit: false, ui: nil, slider: nil, colourSelector: nil, ratioSelector: nil)
            
        default:
            print("Attempting to run a non linked main button function. (mainButtonTapped)")
            break
        }
    }
    
    // when user select a button but didnt press it.
    @objc func buttonHighlighted(sender: UIButton!) {
        sender.tintColor = .lightGray
        sender.setTitleColor(.lightGray, for: .normal)
    }
    
    // when user drag their finger outside the button
    @objc func buttonNormal(sender: UIButton!) {
        sender.tintColor = .white
        sender.setTitleColor(.white, for: .normal)
    }
    
    @objc func exportTapped(sender: UIButton) {
        sender.tintColor = .white
        let finalImageData = borderEngine.blendImages(backgroundImg: borderView.asImage(), foregroundImg: imageViewTop.image!)!
        guard let finalImage = UIImage(data: finalImageData) else {
            AlertService.alert(self, title: "oof!", message: "It appears that the export engine is not working. Try again later or submit a bug report!")
            return
        }
        
        switch sender.tag {
        case 0:
            CustomPhotoAlbum.shared.save(image: finalImage) { (success) in
                if success {
                    TapticEngine.successTaptic()
                    DispatchQueue.main.async {
                        AlertService.alert(self, title: "Hooray!", message: "Your photo has been successfully saved!")
                    }
                }
                else {
                    DispatchQueue.main.async {
                        TapticEngine.errorTaptic()
                        AlertService.alert(self, title: "Oops!", message: "Something went wrong while we tried to save your photo!")
                    }
                }
            }
            
        case 1:
            // image to share
            let image = finalImage
            
            // set up activity view controller
            let imageToShare = [image]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
            
        default:
            print("Default")
            
        }
    }
    
    @objc func menuBarTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            borderButton.tintColor = .white
            saveButton.tintColor = .darkGray
            adjustmentButton.tintColor = .darkGray
            
            mainButtonHide(false)
            exportButtonHide(true)
            effectsButtonHide(true)
        case 1:
            adjustmentNameLabel.text = "Export"
            borderButton.tintColor = .darkGray
            saveButton.tintColor = .white
            adjustmentButton.tintColor = .darkGray
            
            mainButtonHide(true)
            exportButtonHide(false)
            effectsButtonHide(true)
        case 2:
            adjustmentNameLabel.text = "Effects"
            borderButton.tintColor = .darkGray
            saveButton.tintColor = .darkGray
            adjustmentButton.tintColor = .white
            
            mainButtonHide(true)
            exportButtonHide(true)
            effectsButtonHide(false)

        default:
            print("barButtonTapped default.")
        }
    }
    
    // function when a colour is tapped
    @objc func colourTapped(sender: UIButton) {
        TapticEngine.lightTaptic()
        
        let borderColor = sender.backgroundColor!
        borderView.backgroundColor = borderColor
    }
    
    // funtion resonponsible on display the edit text on datestamp.
    @objc func datestampFunctionTapped(sender: UIButton) {
        sender.tintColor = .white
        TapticEngine.lightTaptic()
        switch sender.tag {
        case 99:
            // from https://stackoverflow.com/questions/39423809/toggle-between-three-states-with-uibutton
            hasDateCounter = (hasDateCounter + 1) % hasDateArray.count
            datestamp.isHidden = hasDateArray[hasDateCounter]
            
        case 100:
            let tap = UITapGestureRecognizer(target: self, action: #selector(datestampViewTapped))
            
            let backView = UIView(frame: self.view.frame)
            backView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8)
            backView.tag = ViewTagReserved.datestamp.rawValue
            backView.addGestureRecognizer(tap)
            
            dateText.textColor = .white
            dateText.text = datestampEngine.dateText
            dateText.font = UIFont(name: "DateStamp-Bold", size: 25)
            dateText.textAlignment = datestampEngine.currentAllignment
            dateText.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.8, height: self.view.frame.size.height * 0.04)
            dateText.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY * 0.6)
            dateText.backgroundColor = .clear
            dateText.tag = ViewTagReserved.datestamp.rawValue
            
            // toolbar setup
            let toolbar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            toolbar.backgroundColor = .clear
            
            let toolHeight = toolbar.bounds.height * 0.5
            
            // setup scrollView
            let scrollView = UIScrollView(frame: CGRect(x: 0, y: toolbar.frame.midY, width: toolbar.bounds.width, height: toolHeight))
            scrollView.backgroundColor = UIColor(named: "backgroundSecondColor")
            scrollView.showsHorizontalScrollIndicator = false
            
            // setup second scrollview for fonts
            scrollView2 = UIScrollView(frame: CGRect(x: 0, y: toolbar.frame.minY, width: toolbar.bounds.width, height: toolHeight))
            scrollView2.backgroundColor = UIColor(displayP3Red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
            scrollView2.showsHorizontalScrollIndicator = false
            scrollView2.isHidden = fontScrollIsHidden
            
            // setup Done button
            let width = toolbar.frame.width * 0.15
            let doneButton = UIButton(type: .custom)
            doneButton.setTitleColor(.white, for: .normal)
            doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            doneButton.setTitle("Done", for: .normal)
            doneButton.tag = 0
            doneButton.backgroundColor = .clear
            doneButton.addTarget(self, action: #selector(datestampKeyboardToolBarTapped), for: .touchUpInside)
            doneButton.frame = CGRect(x: toolbar.frame.maxX - width - 10, y: toolbar.frame.maxY, width: width, height: toolHeight)
            doneButton.center = CGPoint(x: doneButton.frame.midX, y: toolbar.frame.maxY * 0.75)

            toolBarFunction = ToolBarView.init(toolbarW: toolbar.frame.width, toolbarH: toolbar.frame.height * 0.5)
            
            for button in toolBarFunction.createButtonArray() {
                button.center = CGPoint(x: button.frame.midX, y: toolbar.frame.midY * 0.5)
                button.addTarget(self, action: #selector(datestampKeyboardToolBarTapped), for: .touchUpInside)
                scrollView.addSubview(button)
            }
            
            toolbar.addSubview(scrollView2)
            toolbar.addSubview(scrollView)
            toolbar.addSubview(doneButton)
 
            dateText.inputAccessoryView = toolbar
            
            self.view.addSubview(backView)
            self.view.addSubview(dateText)
            dateText.becomeFirstResponder()
            
        // default would be when user tap on the colour selector.
        default:
            self.datestamp.textColor = sender.backgroundColor!
        }
        
    }
    
    @objc func ratioTapped(sender: UIButton) {
        if sender.titleLabel?.text != "override" {
            TapticEngine.lightTaptic()
        }
        
        if oriImage.size.width == oriImage.size.height {
            sender.tag = 1
        }
        
        sender.tintColor = .white
        noticeLabel.isHidden = true
        
        switch sender.tag {
        case 0:
            imageViewTop.image = oriImage
            borderView.frame = imageViewTop.contentClippingRect
            let renderImage = borderEngine.createRenderImage(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
            imageViewTop.image = renderImage
            
        case 1:
            // from the original size's perspective
            borderView.frame = imageViewTop.contentClippingRect
            // get the difference to make the border square
            let heightDiff = borderView.frame.size.width - borderView.frame.size.height
            // move the y point the same amount the height added.
            let reducedYPt = borderView.frame.minY - heightDiff / 2
            borderView.frame.size.height = borderView.frame.size.width
            // transform.
            borderView.frame = CGRect(x: 0, y: reducedYPt, width: imageView.frame.width, height: imageView.frame.width)
            borderView.center = CGPoint(x: imageView.frame.size.width  / 2, y: imageView.frame.size.height / 2)
            
            // scale accordingly.
            // square portrait or square square
            if oriImage.size.width < oriImage.size.height || oriImage.size.width == oriImage.size.height {
                let renderImage = borderEngine.createRenderImageSquare(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
                imageViewTop.image = renderImage
            }
            
        case 2:
            print("No value found!")
            //                // preserve ratio
            //                let newW = 9 * imageView.frame.height / 16
            //                borderView.frame = CGRect(x: 0, y: 0, width: newW, height: imageView.frame.height)
            //                borderView.center = CGPoint(x: imageView.frame.width  / 2, y: imageView.frame.height / 2)
            //
            //                if oriImage.size.width > oriImage.size.height {
            //                    let renderImage = borderEngine.createRenderImagePortrait(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
            //                    imageViewTop.image = renderImage
            //                }
            //                // portrait portrait
            //                else {
            //                    let renderImage = borderEngine.createRenderImagePortrait(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
            //                    imageViewTop.image = renderImage
            //                }
            
        default:
            print("No tag matches! ratioTapped function on PhotoEditorVC Extension+")
        }
        
        hide(progress: nil, barItemOnEdit: nil, ui: nil, slider: nil, colourSelector: nil, ratioSelector: true)
        mainButtonHide(false)
        menuBarHide(false)
    }
    
    @objc func datestampKeyboardToolBarTapped(sender: UIButton!) {
        switch sender.tag {
        // done
        case 0:
            for _ in 0 ..< 3 {
                guard let viewWithTag = self.view.viewWithTag(ViewTagReserved.datestamp.rawValue) else {
                    print("cannot remove datestamp views! (keyboardDoneTapped)")
                    return
                }
                viewWithTag.removeFromSuperview()
            }
            
            if let text = dateText.text {
                if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                    datestampEngine.dateText = text
                }
                else {
                    datestampEngine.dateText = "09 01 '18"
                }
            }
            // adjust allignment
            datestampEngine.currentAllignment = allignmentArray[counter]
            
            self.datestamp = self.adjustDateStamp(datestamp: self.datestampEngine.datestamp(), allignment: datestampEngine.currentAllignment)
            self.datestamp.tag = ViewTagReserved.datestamp.rawValue
            self.imageViewTop.addSubview(self.datestamp)

        // allignment
        case 1:
            counter = (counter + 1) % allignmentArray.count
            dateText.textAlignment = allignmentArray[counter]
            sender.setImage(toolBarFunction.allignmentViewImage[counter], for: .normal)
            
        default:
            break
        }

        
    }
    
    @objc func datestampViewTapped() {
        let a = UIButton()
        a.tag = 0
        datestampKeyboardToolBarTapped(sender: a)
    }
}
