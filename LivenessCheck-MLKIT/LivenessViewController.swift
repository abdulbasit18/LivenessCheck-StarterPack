//
//  ViewController.swift
//  LivenessCheck-MLKIT
//
//  Created by Abdul Basit on 17/06/2020.
//  Copyright © 2020 Abdul Basit. All rights reserved.
//

import UIKit
import CoreMedia

class LivenessViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private var videoPreview: UIView!
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - Internal Properties
    private var videoCapture: VideoCapture!
    
    // MARK: - Data
    
    private var detectionOptions = [" 👱🏻‍♂️ Single Face Detection",
                                    " 👀 Blinking",
                                    " 👉🏻 Look Right",
                                    " 👈🏻 Look Left",
                                    " 🙂 Smile :)"]
    private var completedSteps =  [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - SetUp Video
    private func setUpCamera() {
        videoCapture = VideoCapture()
        videoCapture.delegate = self
        videoCapture.fps = 5
        videoCapture.setUp(sessionPreset: .vga640x480) { success in
            if success {
                // add preview view on the layer
                if let previewLayer = self.videoCapture.previewLayer {
                    self.videoPreview.layer.addSublayer(previewLayer)
                    self.resizePreviewLayer()
                }
                // start video preview when setup is done
                self.videoCapture.start()
            }
        }
    }
    
    
    private func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
    
    
}

// MARK: - Video Delegate

extension LivenessViewController: VideoCaptureDelegate {
    
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        
        
    }
    
}

// MARK: - TableView Delegates

extension LivenessViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detectionOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? (UITableViewCell(style: .default, reuseIdentifier: "cell"))
        cell.textLabel?.text = detectionOptions[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        if completedSteps.contains(indexPath.row + 1) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
}
