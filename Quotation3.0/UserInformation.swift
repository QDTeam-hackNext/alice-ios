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
        if status == .granted {
          DispatchQueue.global(qos: .background).async {
            self.loadUserContact(callback: {
              userData in
              self.userData = userData
              completionHandler(true)
            })
          }
        }
      }

    case .denied, .notDetermined:
      let contactStore = CNContactStore()

      contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
        if access {
          CKContainer.default().requestApplicationPermission(.userDiscoverability) {
            status, error in
            if status == .granted {
              completionHandler(access)
            }
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
                        CNContactBirthdayKey, CNContactJobTitleKey]
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
}
