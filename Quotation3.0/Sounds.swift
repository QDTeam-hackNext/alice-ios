//
//  Sounds.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import AVFoundation

class Sounds {
  fileprivate let delegate = Delegate()
  fileprivate let questionMp3 = Bundle.main.url(forResource: "sounds/question", withExtension: "mp3")

  fileprivate var player: AVAudioPlayer?

  func question(afterFinish: @escaping () -> () = {}) {
    self.delegate.afterFinish = afterFinish
    do {
      self.player = try AVAudioPlayer(contentsOf: questionMp3!)
      self.player?.delegate = self.delegate
      self.player?.play()
    } catch {
      
    }
  }

  fileprivate class Delegate: NSObject, AVAudioPlayerDelegate {
    var afterFinish: (() -> ())?

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      self.afterFinish?()
    }
  }
}
