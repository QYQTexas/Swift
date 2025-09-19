//
//  exampleDecodeCertificateFromPem.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/19.
//

import X509
import SwiftASN1
import CryptoKit
import Foundation

// Case: Certificate.init(pemEncoded:)
// 例子：证书在源码中以 PEM 格式的硬编码形式存在，演示如何读取这类情景的证书
final public class ExampleDecodeCertificateFromPem{
    private init(){};
}

extension ExampleDecodeCertificateFromPem{
    static public func decodeCertificatePem() -> Certificate?{
        do{
            let certificate = try Certificate(pemEncoded: RootCA.certificatePem)
            return certificate
        }catch{
            print("\(type(of: error)): \(error)")
            return nil
        }
    }
    
    static public func printCertificateDebugDescription(){
        let certificate = self.decodeCertificatePem();
        print("certificate.debugDescription: \(certificate.debugDescription.utf8)")
    }
    
    static public func printCertificateIssuer(){
        let certificate = self.decodeCertificatePem();
        guard let issuer = certificate?.issuer else{
            print("This certificate without issuer")
            return
        }
        print("certificate?.issuer: \(issuer)")
    }
    
    static public func printCertificateSubject(){
        let certificate = self.decodeCertificatePem();
        guard let subject = certificate?.subject else{
            return
        }
        print("certificate?.subject: \(subject)")
    }
}
