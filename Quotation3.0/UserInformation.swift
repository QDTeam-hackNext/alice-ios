//
//  UserInformation.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import UIKit
import CloudKit
import Contacts
import AddressBook

class UserInformation {
  fileprivate var userData: CNContact?

  func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
    let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)

    switch authorizationStatus {
    case .authorized:
      CKContainer.default().requestApplicationPermission(.userDiscoverability) {
        status, error in
        let result = status == .granted || status == .couldNotComplete // .couldnotComplete result occurs on the symulator
        if result {
          if status == .couldNotComplete {
            completionHandler(true)
            return
          }
          DispatchQueue.global(qos: .background).async {
            self.loadUserContact(callback: {
              userData in
              self.userData = userData
              completionHandler(true)
            })
          }
        } else {
          completionHandler(false)
        }
      }

    case .denied, .notDetermined:
      let contactStore = CNContactStore()

      contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
        if access {
          CKContainer.default().requestApplicationPermission(.userDiscoverability) {
            status, error in
            completionHandler(status == .granted || status == .couldNotComplete)
          }
        } else {
          if authorizationStatus == CNAuthorizationStatus.denied {
            let queue = DispatchQueue(label: "com.app.queue")
            queue.async() {
              let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
              print(message)
            }
          }
        }
      })

    default:
      completionHandler(false)
    }
  }

  func loadUserContact(callback: @escaping (CNContact) -> Void) {
    if let data = self.userData {
      callback(data)
    }
    let container = CKContainer.default()
    container.fetchUserRecordID(completionHandler: {
      record, error in
      if error != nil {
        callback(self.devContact())
        return
      }
      if let r = record {
        container.discoverUserIdentity(withUserRecordID: r, completionHandler: {
          userIdentity, error in
          if let ui = userIdentity,
              let nameData = ui.nameComponents,
              let givenName = nameData.givenName ,
              let familyName = nameData.familyName {
            let predicate = CNContact.predicateForContacts(matchingName: "\(givenName) \(familyName)")
            let contactStore = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,
                        CNContactBirthdayKey, CNContactJobTitleKey,
                        CNContactPhoneNumbersKey,
                        CNContactEmailAddressesKey, CNContactPostalAddressesKey]
            do {

              let contacts = try contactStore.unifiedContacts(matching: predicate,
                                                              keysToFetch: keys as [CNKeyDescriptor])

              if contacts.count == 0 {
                print("No contacts were found matching the given name.")
              } else {
                callback(contacts.first!)
              }
            } catch {
              print("Unable to fetch contacts.")
            }
          }
        })
      }
    })
  }

  fileprivate func devContact() -> CNContact {
    let devContact = CNMutableContact()
    devContact.givenName = "Darek"
    devContact.birthday = DateComponents()
    devContact.birthday?.day = 4
    devContact.birthday?.month = 5
    devContact.birthday?.year = 1986
    devContact.emailAddresses.append(CNLabeledValue(label: "",
                                                    value: "dariusz.luksza@gmail.com"))
    devContact.phoneNumbers.append(CNLabeledValue(label: "",
                                                  value: CNPhoneNumber(stringValue: "222 333 444")))
    let address = CNMutablePostalAddress()
    address.city = "Berlin"
    address.postalCode = "10555"
    address.street = "Alianz Str. 12"
    address.country = "Germany"
    devContact.postalAddresses.append(CNLabeledValue(label: "", value: address))

    return devContact
  }
}
