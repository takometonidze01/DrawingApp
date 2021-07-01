//
//  ViewController.swift
//  SimpleDrawApp
//
//  Created by CodergirlTM on 01.07.21.
//

import UIKit

enum FileType: String {
    case png
    case pdf
}


class PaintViewController: BaseViewController {
    
    
    var images = [URL]()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)

        return button
    }()
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)

        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let orangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    let rubberButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(button: UIButton) {
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .touchUpInside)

        return slider
    }()
    
    @objc fileprivate func handleSliderChange() {
        canvas.setStrokeWidth(width: slider.value)
    }
    let canvas = Canvas()
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.frame = view.frame
        canvas.backgroundColor = .white
        view.addSubview(canvas)
        let logoutBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePaint))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
        
        setupLayout()
    }
    func saveFile(with data: Data?, fileType: FileType) {
        let documentsDir = try? FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
        
        let randomFileName = "\(UUID.init().uuidString).\(fileType.rawValue)"
        guard let filePath = documentsDir?.appendingPathComponent(randomFileName) else {return}
        
        do {
            try data?.write(to: filePath)
        } catch {
            print(error)
        }
        print(filePath)
        self.images.append(filePath)
    }
    
    @objc fileprivate func savePaint() {
        var image:UIImage?
        let currentLayer = UIApplication.shared.keyWindow!.layer
        let currentScale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale);
        guard let currentContext = UIGraphicsGetCurrentContext() else {return}
        currentLayer.render(in: currentContext)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let img = image else { return }
        saveFile(with: img.pngData(), fileType: .png)
        coordinator?.showSuccessAlert()
        print(images)
        
    }
    
    func setupLayout() {
        let colorStackView = UIStackView(arrangedSubviews: [greenButton, redButton, yellowButton, orangeButton, rubberButton])
        colorStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
        undoButton,
        clearButton,
        colorStackView,
        slider])
        
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}


