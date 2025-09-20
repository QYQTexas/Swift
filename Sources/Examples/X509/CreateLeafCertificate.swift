//
//  Examples/X509/CreateLeafCertificate.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/19.
//

import X509
import SwiftASN1
import CryptoKit
import Foundation



// 演示创建终端证书的流程
public struct X509CreateLeafCertificateExamples{
    static public func createLeafCertificate() -> Certificate? {return _createLeafCertificate()}
    private init(){}
}

extension X509CreateLeafCertificateExamples{
    // Show
    static private func _createLeafCertificate() -> Certificate?{
        do{
            // 构建 Leaf Certificate Private Key
            let leafPrivateKey = Certificate.PrivateKey(P256.Signing.PrivateKey())
            let leafPublicKey = leafPrivateKey.publicKey
            
            // 获取时间点位
            let validBegin = Date()
            let validEnd = validBegin.addingTimeInterval(60*60*24*365*2)
            
            // 从示例中获取相应的值
            guard
                // 获取 Root CA Pair
                let rootCaPrivateKey = X509ParseFromPemExamples.parsePrivateKeyPkcs8(),
                let rootCaCertificate = X509ParseFromPemExamples.parseCertificate(),
                // 构建 subject DN
                let subject = X509InitDistinguishedNameExamples.initObjectDN(),
                // 构建 extensions
                let extensions = X509InitExtensionsExamples.initExtensions()
            else{
                return nil
            }
            
            // 获取 issuer DN
            let issuer = rootCaCertificate.issuer
            
            
            
            /// From: swift-certificates > Sources > X509 > Certificate > Certificate > init()
            /// Construct a certificate from constituent parts, signed by an issuer key.
            ///
            /// This API can be used to construct a ``Certificate`` directly, without an intermediary
            /// Certificate Signing Request. The ``signature-swift.property`` for this certificate will be produced
            /// automatically, using `issuerPrivateKey`.
            ///
            /// This API can be used to construct a self-signed key by passing the private key for `publicKey` as the
            /// `issuerPrivateKey` argument.
            ///
            /// - Parameters:
            ///   - version: The X.509 specification version for this certificate.
            ///   - serialNumber: The serial number of this certificate.
            ///   - publicKey: The public key associated with this certificate.
            ///   - notValidBefore: The date before which this certificate is not valid.
            ///   - notValidAfter: The date after which this certificate is not valid.
            ///   - issuer: The ``DistinguishedName`` of the issuer of this certificate.
            ///   - subject: The ``DistinguishedName`` of the subject of this certificate.
            ///   - signatureAlgorithm: The signature algorithm that will be used to produce `signature`. Must be compatible with the private key type.
            ///   - extensions: The extensions on this certificate.
            ///   - issuerPrivateKey: The private key to use to sign this certificate.
            // 填充字段参数，创建终端证书
            let leafCertificate = try Certificate(
                version: .v3,
                serialNumber: Certificate.SerialNumber(),
                publicKey: leafPublicKey,
                notValidBefore: validBegin,
                notValidAfter: validEnd,
                issuer: issuer,
                subject: subject,
                signatureAlgorithm: .ecdsaWithSHA256,
                extensions: extensions,
                issuerPrivateKey: rootCaPrivateKey
            )
            
            return leafCertificate
        }catch{
            printCatch(of: error)
            return nil
        }
    }
}

