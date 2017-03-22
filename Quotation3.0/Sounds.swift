//
//  Sounds.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import AVFoundation

class Sounds {
  let questionMp3 = Bundle.main.url(forResource: "sounds/question", withExtension: "mp3")
  var player: AVPlayer?

  func question() {
    self.player = AVPlayer(url: self.questionMp3!)
    player?.play()
  }
}
