//
//  ViewController.swift
//  DemoRSA
//
//  Created by Jose Carreno on 6/28/19.
//  Copyright © 2019 Financiera Oh. All rights reserved.
//

import UIKit
import SwiftyRSA

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let certificateData = NSData(contentsOf:Bundle.main.url(forResource: "public", withExtension: "der")!)
            
            let certificate = SecCertificateCreateWithData(nil, certificateData!)
            
            var trust: SecTrust?
            
            let policy = SecPolicyCreateBasicX509()
            let status = SecTrustCreateWithCertificates(certificate!, policy, &trust)
            
            if status == errSecSuccess {
                let key = SecTrustCopyPublicKey(trust!)!
                
                let publicKey = try PublicKey(reference: key)
                let clear = try ClearMessage(string: "Clear Text", using: .utf8)
                let encrypted = try clear.encrypted(with: publicKey, padding: .OAEP)
    
                print(encrypted.base64String)
            }
        } catch {
            print(error.localizedDescription)
        }

    }


}

