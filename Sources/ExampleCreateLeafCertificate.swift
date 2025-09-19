//
//  exampleCreateLeafCertificate.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/19.
//

import X509
import SwiftASN1
import CryptoKit
import Foundation



// Case: process of creating a leaf certificate
// 演示创建终端证书的流程
final public class ExampleCreateLeafCertificate{
    private init(){};
    
    // Root CA
    static private let certificatePem = RootCA.certificatePem
    static private let privateKeyPkcs8Pem = RootCA.privateKeyPkcs8Pem
}

extension ExampleCreateLeafCertificate{
    // Show
    static public func createLeafCertificate(){
        print("=====TEST FUNC testCreateLeafCertificate=====")
        
        var rootCaCertificate: Certificate?;
        var rootCaPrivateKeyPkcs8Pem: Certificate.PrivateKey?;
        self._parseRootCa(rootCaCertificate: &rootCaCertificate, rootCaPrivateKeyPkcs8Pem: &rootCaPrivateKeyPkcs8Pem)
        guard rootCaCertificate != nil && rootCaPrivateKeyPkcs8Pem != nil else{
            return
        }
        
        var objectName:DistinguishedName?;
        self._getObjectName(objectName: &objectName)
        guard objectName != nil else{
            return
        }
        
        
    }
    
    // Helper
    static private func _getObjectName(objectName: inout DistinguishedName?){
        do{
            objectName = try DistinguishedName{
                CountryName("US")   // 国家代码
            }
        }catch{
            print("error: \(error)")
            objectName = nil;
        }
    }
    
    // Helper
    static private func _parseRootCa(rootCaCertificate: inout Certificate?, rootCaPrivateKeyPkcs8Pem: inout Certificate.PrivateKey?){
        do{
            rootCaCertificate = try Certificate(pemEncoded: self.certificatePem)
            rootCaPrivateKeyPkcs8Pem = try Certificate.PrivateKey(pemEncoded: self.privateKeyPkcs8Pem)
        }catch{
            print("error: \(error)")
            rootCaCertificate = nil
            rootCaPrivateKeyPkcs8Pem = nil
        }
    }
}

