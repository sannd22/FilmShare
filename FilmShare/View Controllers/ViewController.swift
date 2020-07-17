//
//  ViewController.swift
//  MovieShare
//
//  Created by David Sann on 7/8/20.
//  Copyright © 2020 David Sann. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //setUpVideo()
    }
    
    func setUpVideo() {
        // Get the Path to the resource in the bundle
        let vidPath = Bundle.main.path(forResource: "backTemp", ofType: "MOV")
        guard vidPath != nil else {
            return
        }
        
        // Create url
        let url = URL(fileURLWithPath: vidPath!)
        
        // Create Video Player Item
        let item = AVPlayerItem(url: url)
        
        // Create Player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create layer & Adjust size and frame
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.width*0.2, y: -self.view.frame.width*0.5, width: self.view.frame.size.width*1.4, height: self.view.frame.size.height * 1.4)
        
        // Play the video
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 1.0)
    }
    
    func setUpElements() {
        // Style Buttons
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
