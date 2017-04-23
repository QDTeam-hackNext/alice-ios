//
//  SummaryView.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 22/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit

class SummaryView: UIViewController, WithViewModel {
  typealias Model = SummaryViewModel

  @IBOutlet weak var container: UIView!

  @IBOutlet var dividers: [UILabel]!

  @IBOutlet weak var insuranceNoRow: InformationRowView!
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
  @IBOutlet weak var monthlyFeeRow: InformationRowView!
  
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

    for d in self.dividers {
      d.text = ""
      d.backgroundColor = UIColor.slate10
    }
  }
}
