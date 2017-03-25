//
//  GeneralInformationView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class GeneralIfomationView: UIViewController, WithViewModel {
  typealias Model = GeneralInformationViewModel

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var aliceTextLabel: UILabel!

  @IBOutlet weak var firstQuestionContainer: UIView!
  @IBOutlet weak var firstQuestionTitle: UILabel!
  @IBOutlet weak var firstQuestion: UILabel!
  @IBOutlet weak var firstQuestionValue: UILabel!
  @IBOutlet weak var firstQuestionSlider: UISlider!

  @IBOutlet weak var secondQuestionContainer: UIView!
  @IBOutlet weak var secondQuestionTitle: UILabel!
  @IBOutlet weak var secondQuestion: UILabel!
  @IBOutlet weak var secondQuestionValue: UILabel!
  @IBOutlet weak var secondQuestionSlider: UISlider!

  @IBOutlet weak var thirdQuestionContainer: UIView!
  @IBOutlet weak var thirdQuestion: UILabel!
  @IBOutlet weak var thirdQuestionSwitch: UISwitch!

  @IBOutlet weak var quoteButton: UIButton!

  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.background
    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width,
                                         height: self.scrollView.contentSize.height)

    self.styleContainer(container: self.firstQuestionContainer)
    self.styleContainer(container: self.secondQuestionContainer)
    self.styleContainer(container: self.thirdQuestionContainer)

    self.styleTitle(title: self.firstQuestionTitle)
    self.styleTitle(title: self.secondQuestionTitle)
    self.styleTitle(title: self.thirdQuestion)

    self.styleQuestion(question: self.firstQuestion)
    self.styleQuestion(question: self.secondQuestion)

    self.styleSlider(slider: self.firstQuestionSlider)
    self.styleSlider(slider: self.secondQuestionSlider)

    self.styleValue(label: self.firstQuestionValue)
    self.styleValue(label: self.secondQuestionValue)

    self.firstQuestionSlider.value = 100000
    self.firstQuestionSlider.minimumValue = 25000
    self.firstQuestionSlider.maximumValue = 10000000
    self.secondQuestionSlider.value = 10
    self.secondQuestionSlider.minimumValue = 1
    self.secondQuestionSlider.maximumValue = 50

    self.quoteButton.backgroundColor = UIColor.vividPurple
    self.quoteButton.layer.cornerRadius = 8
    self.quoteButton.clipsToBounds = true
    self.quoteButton.titleLabel?.font = UIFont.buttonFontFont()
    self.quoteButton.setTitleColor(UIColor.white, for: .normal)
  }

  @IBAction func firstSliderValueChanged(_ sender: Any) {
    let v = Int(self.firstQuestionSlider.value)
    self.firstQuestionValue.text = "\(v)"
  }

  @IBAction func secondSliderValueChanged(_ sender: Any) {
    let v = Int(self.secondQuestionSlider.value)
    self.secondQuestionValue.text = "\(v)"
  }

  fileprivate func styleContainer(container: UIView) {
    container.layer.cornerRadius = 8
    container.clipsToBounds = true
  }

  fileprivate func styleTitle(title: UILabel) {
    title.font = UIFont.questionHeaderFontFont()
  }

  fileprivate func styleQuestion(question: UILabel) {
    question.numberOfLines = 0
    question.lineBreakMode = .byWordWrapping
    question.font = UIFont.questionFontFont()
  }

  fileprivate func styleSlider(slider: UISlider) {
    slider.maximumTrackTintColor = UIColor.gray
    slider.thumbTintColor = UIColor.dodgerBlueTwo
  }

  fileprivate func styleValue(label: UILabel) {
    label.textColor = UIColor.dodgerBlueTwo
    label.font = UIFont.questionValueFont()
  }
}
