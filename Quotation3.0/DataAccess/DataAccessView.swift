//
//  DataAccessView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

class DataAccessView: UIViewController, WithViewModel {
  typealias Model = DataAccessViewModel

  @IBOutlet weak var container: UIView!

  @IBOutlet weak var nameRow: InformationRowView!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var spouseRow: InformationRowView!
  @IBOutlet weak var phoneRow: InformationRowView!
  @IBOutlet weak var emailRow: InformationRowView!
  @IBOutlet weak var jobRow: InformationRowView!
  @IBOutlet weak var activitiesRow: InformationRowView!
  @IBOutlet weak var healthRow: InformationRowView!
  @IBOutlet weak var coverageRow: InformationRowView!
  @IBOutlet weak var yearsOfProtectionRow: InformationRowView!
  @IBOutlet weak var divider: UILabel!
  @IBOutlet weak var monthlyFeeRow: InformationRowView!

  @IBOutlet weak var payButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var disclamierLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.background

    self.container.layer.cornerRadius = 8
    self.container.clipsToBounds = true

    self.nameRow.name.text = "\(self.model.data!.user.givenName) \(self.model.data!.user.familyName)"
    self.nameRow.value.text = "\(self.model.data!.age) yrs."

    self.addressLabel.lineBreakMode = .byWordWrapping
    self.addressLabel.numberOfLines = 0
    self.addressLabel.textColor = UIColor.slate50
    self.addressLabel.font = UIFont.questionFontFont()
    self.addressLabel.text = "\(self.model.data!.address)"

    self.spouseRow.name.text = "Spouse"
    self.spouseRow.value.text = "Aleksandra"

    self.phoneRow.name.text = "Phone"
    self.phoneRow.value.text = "\(self.model.data!.phoneNumber)"

    self.emailRow.name.text = "E-mail"
    self.emailRow.value.text = "\(self.model.data!.email)"

    self.jobRow.name.text = "Job"
    self.jobRow.value.text = ""

    self.activitiesRow.name.text = "Activities"
    self.activitiesRow.value.text = ""

    self.healthRow.name.text = "Health"
    self.healthRow.value.text = ""

    self.coverageRow.name.text = "Coverage"
    self.coverageRow.value.text = "\(self.model.data!.sum)€"

    self.yearsOfProtectionRow.name.text = "Years of protection"
    self.yearsOfProtectionRow.value.text = "\(self.model.data!.period)"

    self.monthlyFeeRow.name.text = "Monthly fee"
    self.monthlyFeeRow.value.text = "\(self.model.data!.price)€"
    self.monthlyFeeRow.value.font = UIFont.partialPriceFontFont()
    self.monthlyFeeRow.value.textColor = UIColor.green

    self.divider.text = ""
    self.divider.backgroundColor = UIColor.slate10

    self.payButton.backgroundColor = UIColor.greenTwo
    self.payButton.setTitleColor(UIColor.white, for: .normal)
    self.payButton.titleLabel?.font = UIFont.buttonFontFont()
    self.payButton.setTitle("Pay now", for: .normal)

    self.saveButton.backgroundColor = UIColor.darkGreyBlue
    self.saveButton.setTitleColor(UIColor.white, for: .normal)
    self.saveButton.titleLabel?.font = UIFont.buttonFontFont()
    self.saveButton.setTitle("Save for later", for: .normal)

    self.disclamierLabel.font = UIFont.disclaimerFont()
    self.disclamierLabel.textColor = UIColor.slate
    self.disclamierLabel.textAlignment = .center
    self.disclamierLabel.text = "This insurance proposal will land directly in your inbox."
  }
}
