//
//  UserInformation.swift
//  Quotation3.0
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Contacts

class UserInformation {

  func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
    let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)

    switch authorizationStatus {
    case .authorized:
      completionHandler(true)

    case .denied, .notDetermined:
      let contactStore = CNContactStore()

      contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
        if access {
          completionHandler(access)
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

  func getUserDetails() {
    requestForAccess { (accessGranted) -> Void in
      if accessGranted {
        let predicate = CNContact.predicateForContacts(matchingName: NSFullUserName())
        let keys = [CNContactBirthdayKey, CNContactJobTitleKey]

        do {
          let contactStore = CNContactStore()
          let contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keys as [CNKeyDescriptor])

          if contacts.count == 0 {
            print("No contacts were found matching the given name.")
          } else {
            for contact in contacts {
              contact.birthday
              contact.jobTitle
            }
          }
        }
        catch {
          print("Unable to fetch contacts.")
        }
      }
    }
  }
}
