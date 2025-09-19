//
//  exampleDecodePrivateKeyFromPem.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/19.
//

import X509
import SwiftASN1
import CryptoKit
import Foundation

// Case: Certificate.PrivateKey.init(penEncoded:)
// 例子：私钥在源码中以 PEM 格式的硬编码形式存在，演示如何读取这类情景的私钥
final public class ExampleDecodePrivateKeyFromPem{
    private init(){};
}

// 在硬编码的场景下，我们应当会提前知道证书的格式，因此代码调用处理流程一致，只是在 PEM 中修改了 BEGIN-END 的头尾信息
extension ExampleDecodePrivateKeyFromPem{
    // case1 pkcs1-rsa
    // 演示如何读取 pkcs1-rsa 格式的私钥
    static public func decodePrivateKeyPem() -> Certificate.PrivateKey?{
        do{
            let privateKey = try Certificate.PrivateKey(pemEncoded: RootCA.privateKeyPem)
            return privateKey
        }catch{
            print("\(type(of: error)): \(error)")
            return nil
        }
    }
    
    // case2 pkcs8
    // 演示如何读取 pkcs8 格式的私钥
    static public func decodePrivateKeyPkcs8Pem() -> Certificate.PrivateKey?{
        do{
            let privateKeyPkcs8Pem = try Certificate.PrivateKey(pemEncoded: RootCA.privateKeyPkcs8Pem)
            return privateKeyPkcs8Pem
        }catch{
            print("\(type(of: error)): \(error)")
            return nil
        }
    }
    
    /*
     @QYQTexas:
     如果有别的情景，可以查看 Certificate.PrivateKey 源码进行相应处理，可以看到 init 内有几个 case，init 会根据不同的 BEGIN-END 头信息
     调用不同的解析函数。如果出现这类错误：
     """
     Failed to decode private key
     error: ASN1Error.unexpectedFieldType: ASN1Identifier(tagNumber: 2, tagClass: universal) SwiftASN1/DER.swift:45
     type(of: error): ASN1Error
     Program ended with exit code: 0
     """
     可以根据实际情况更改证书 PEM 格式中的 BEGIN-END 头信息来匹配正确的解析函数。
     */

    /* Certificate.PrivateKey 源码
     extension Certificate.PrivateKey {
         @inlinable
         static var pemDiscriminatorForRSA: String { "RSA PRIVATE KEY" }

         @inlinable
         static var pemDiscriminatorForSEC1: String { "EC PRIVATE KEY" }

         @inlinable
         static var pemDiscriminatorForPKCS8: String { "PRIVATE KEY" }

         @inlinable
         public init(pemEncoded: String) throws {
             try self.init(pemDocument: PEMDocument(pemString: pemEncoded))
         }

         @inlinable
         public init(pemDocument: PEMDocument) throws {
             switch pemDocument.discriminator {
             case Self.pemDiscriminatorForRSA:
                 self = try .init(_CryptoExtras._RSA.Signing.PrivateKey.init(derRepresentation: pemDocument.derBytes))

             case Self.pemDiscriminatorForSEC1:
                 let sec1 = try SEC1PrivateKey(derEncoded: pemDocument.derBytes)
                 self = try .init(ecdsaAlgorithm: sec1.algorithm, rawEncodedPrivateKey: sec1.privateKey.bytes)

             case Self.pemDiscriminatorForPKCS8:
                 let pkcs8 = try PKCS8PrivateKey(derEncoded: pemDocument.derBytes)
                 switch pkcs8.algorithm {
                 case .ecdsaP256, .ecdsaP384, .ecdsaP521:
                     let sec1 = try SEC1PrivateKey(derEncoded: pkcs8.privateKey.bytes)
                     if let innerAlgorithm = sec1.algorithm, innerAlgorithm != pkcs8.algorithm {
                         throw ASN1Error.invalidASN1Object(
                             reason: "algorithm mismatch. PKCS#8 is \(pkcs8.algorithm) but inner SEC1 is \(innerAlgorithm)"
                         )
                     }
                     self = try .init(ecdsaAlgorithm: pkcs8.algorithm, rawEncodedPrivateKey: sec1.privateKey.bytes)

                 case .rsaKey:
                     self = try .init(_CryptoExtras._RSA.Signing.PrivateKey(derRepresentation: pkcs8.privateKey.bytes))
                 case .ed25519:
                     self = try .init(Curve25519.Signing.PrivateKey(pkcs8Key: pkcs8))
                 default:
                     throw CertificateError.unsupportedPrivateKey(reason: "unknown algorithm \(pkcs8.algorithm)")
                 }

             default:
                 throw ASN1Error.invalidPEMDocument(
                     reason:
                         "PEMDocument has incorrect discriminator \(pemDocument.discriminator). Expected \(Self.pemDiscriminatorForPKCS8), \(Self.pemDiscriminatorForSEC1) or \(Self.pemDiscriminatorForRSA) instead"
                 )
             }
         }
     */
    
    
}
