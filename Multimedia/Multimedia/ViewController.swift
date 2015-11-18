//
//  ViewController.swift
//  Multimedia
//
//  Created by Usuário Convidado on 16/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    let playerController: AVPlayerViewController = AVPlayerViewController()
    
    var musicPlayer:AVAudioPlayer?
    @IBOutlet weak var progressMusica: UIProgressView!
    @IBOutlet weak var sliderMusica: UISlider!
    
    var updateTimer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? musicPlayer = AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("musica", withExtension: "mp3")!)
        musicPlayer!.volume = 0.5
        sliderMusica.minimumValue = 0
        sliderMusica.maximumValue = 1
        sliderMusica.value = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapVideo(sender: UIButton) {
        
        /*
        let videoPath:NSURL = NSBundle.mainBundle().URLForResource("big-buck-bunny-clip", withExtension: "m4v")!
        */
        let videoPath:NSURL = NSURL(string: "https://dl.dropboxusercontent.com/u/7902152/FIAP/movie.mp4")!
        self.playerController.player = AVPlayer(URL: videoPath)
        self.playerController.view.frame = CGRectMake(20, 170, 280, 250)
        self.view.addSubview(self.playerController.view)
        self.playerController.player!.play()
        
    }
    
    @IBAction func tapPlay(sender: UIBarButtonItem) {
        if(!musicPlayer!.playing) {
             self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.05), target: "updateMusicProgress", selector: nil, userInfo: nil, repeats: true)
            musicPlayer?.play()
        }
    }

    @IBAction func tapPause(sender: UIBarButtonItem) {
        if(musicPlayer!.playing) {
            musicPlayer?.pause()
        }
    }
    
    @IBAction func tapStop(sender: UIBarButtonItem) {
        if(musicPlayer!.playing) {
            musicPlayer?.stop()
            musicPlayer?.currentTime = NSTimeInterval(0)
        }
    }
    
    @IBAction func sliderMusicaValueChanged(sender: UISlider) {
        musicPlayer?.volume =  sender.value
    }
    
    func updateMusicProgress() {
        let progress:Float = Float(musicPlayer!.currentTime) / Float(self.musicPlayer!.duration)
        self.progressMusica.setProgress(progress, animated: true)
    }
    
}

