//
//  GeneralInformationView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 20/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import Contacts

class GeneralIfomationView: UIViewController, WithViewModel {
  typealias Model = GeneralInformationViewModel

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var aliceSays: AliceSaysView!

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

  private var price = ""

  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.background

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

    self.firstQuestionSlider.minimumValue = 25000
    self.firstQuestionSlider.maximumValue = 10000000
    self.firstQuestionSlider.value = 100000
    self.secondQuestionSlider.minimumValue = 1
    self.secondQuestionSlider.maximumValue = 50
    self.secondQuestionSlider.value = 10
    self.thirdQuestionSwitch.setOn(false, animated: false)

    DispatchQueue.main.async {
      self.quoteButton.backgroundColor = UIColor.vividPurple
      self.quoteButton.layer.cornerRadius = 8
      self.quoteButton.clipsToBounds = true
      self.quoteButton.titleLabel?.font = UIFont.buttonFontFont()
      self.quoteButton.setTitleColor(UIColor.white, for: .normal)

      self.aliceSayPrice(price: "")
      self.firstSliderValueChanged(self)
      self.secondSliderValueChanged(self)
    }
    self.computePrice()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toUserStory" {
      let nextControler = segue.destination as! UserStoryView
      let data = GeneralInformationData(price: self.price,
                                        period: Int(self.secondQuestionSlider.value),
                                        smokes: self.thirdQuestionSwitch.isOn,
                                        sum: Int(ceil(self.firstQuestionSlider.value / 5000.0) * 5000)
//        ,
//                                        user: self.model.userData!
      )
      nextControler.setData(generalData: data)
    }
  }

  @IBAction func firstSliderValueChanged(_ sender: Any) {
    let v = Int(ceil(self.firstQuestionSlider.value / 5000.0) * 5000)
    self.firstQuestionValue.text = "\(v)€"
  }

  @IBAction func firstSliderTouchUpInside(_ sender: Any) {
    self.computePrice()
  }

  @IBAction func secondSliderValueChanged(_ sender: Any) {
    let v = Int(self.secondQuestionSlider.value)
    self.secondQuestionValue.text = "\(v)"
  }

  @IBAction func smokingSwitchChangedValue(_ sender: Any) {
    self.computePrice()
  }

  @IBAction func reduceButtonTouchDown(_ sender: Any) {
    self.performSegue(withIdentifier: "toUserStory", sender: self)
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

  fileprivate func aliceSayPrice(price: String) {
    DispatchQueue.main.async {
      if !price.isEmpty {
        self.aliceSays.text.text = "\(self.model.userRealName()), your current quote is \(price)€"
      } else {
        self.aliceSays.text.text = "I'm checking price for you"
      }
//      let formattedText = NSAttributedString(string: text)
//      self.aliceTextLabel.attributedText = formattedText
    }
  }

  fileprivate func computePrice() {
    self.aliceSayPrice(price: "")
    self.model.calculateQuote(period: Int(self.secondQuestionSlider.value),
                              smokes: self.thirdQuestionSwitch.isOn,
                              sum: "\(Int(ceil(self.firstQuestionSlider.value / 5000.0) * 5000))",
                              callback: {
      price in
      self.price = price
      self.aliceSayPrice(price: price)
    })
  }
}

struct GeneralInformationData {
  let price: String
  let period: Int
  let smokes: Bool
  let sum: Int
//  let user: CNContact
}
