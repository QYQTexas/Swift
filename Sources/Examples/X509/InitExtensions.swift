//
//  InitExtensions.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/20.
//

import X509

public struct X509InitExtensionsExamples{
    // 初始化穿件 Extensions
    static public func initExtensions() -> Certificate.Extensions?{return _initExtensions()}
    
    // HIDE
    private init(){}
}


extension X509InitExtensionsExamples{
    static private func _initExtensions() -> Certificate.Extensions?{
        do{
            /// From: swift-certificates > Sources > X509 > Extension  > Extensions > init()
            /// Construct a collection of extensions using the ``ExtensionsBuilder`` syntax.
            ///
            /// Constructing ``Certificate/Extensions-swift.struct`` can be somewhat awkward due to the opaque nature of ``Certificate/Extension``.
            /// To make this easier, ``Certificate/Extensions-swift.struct`` supports being constructed using a result builder DSL powered by ``ExtensionsBuilder``
            /// and ``CertificateExtensionConvertible``, using ``init(builder:)``. As an example, we can create a simple set of
            /// extensions like this:
            ///
            /// ```swift
            /// let extensions = Certificate.Extensions {
            ///     Critical(
            ///         KeyUsage(digitalSignature: true, keyCertSign: true, cRLSign: true)
            ///     )
            ///
            ///     ExtendedKeyUsage([.serverAuth, .clientAuth])
            ///
            ///     Critical(
            ///         BasicConstraints.isCertificateAuthority(maxPathLength: 0)
            ///     )
            ///
            ///     AuthorityInformationAccess([.init(method: .ocspServer, location: .uniformResourceIdentifier("http://ocsp.digicert.com"))])
            /// }
            /// ```
            ///
            /// - Parameter builder: The ``ExtensionsBuilder`` DSL.
            let extensions = try Certificate.Extensions{
                Critical(
                    BasicConstraints.notCertificateAuthority
                )
                
                Critical(
                    /// From:  swift-certificates > Sources > X509 > Extension Types > KeyUsage > KeyUsage > init()
                    /// Construct a ``KeyUsage`` extension with some usages set.
                    ///
                    /// - Parameters:
                    ///   - digitalSignature: This is true when the subject public key is used for verifying digital signatures,
                    ///       other than signatures used in certificates (covered by `keyCertSign`) or in
                    ///       CRLs (covered by `cRLSign`).
                    ///   - nonRepudiation: This is true when the subject public key is used to verify digital signatures used
                    ///       to provide a non-repudiation service that protects against the signing entity denying
                    ///       some action. This does not cover signatures used in certificates (covered by `keyCertSign`)
                    ///       or in CRLs (`cRLSign`).
                    ///   - keyEncipherment: This is true when the subject public key is used to encrypt private or secret keys, e.g.
                    ///       for key transport.
                    ///   - dataEncipherment: This is true when the subject public key is used to encrypt raw data directly, without the use
                    ///       of an intervening symmetric cipher.
                    ///   - keyAgreement: This is true when the subject public key is used for key agreement.
                    ///   - keyCertSign: This is true when the subject public key is used for verifying signatures on
                    ///       certificates.
                    ///   - cRLSign: This is true when the subject public key is used for verifying signatures on
                    ///       certificate revocation lists.
                    ///   - encipherOnly: This only has meaning when the `keyAgreement` field is also `true`. When `true` in that
                    ///       case, the subject public key may only be used for encrypting data while performing key
                    ///       agreement.
                    ///   - decipherOnly: This only has meaning when the `keyAgreement` field is also `true`. When `true` in that
                    ///       case, the subject public key may only be used for decrypting data while performing key
                    ///       agreement.
                    
                    /*
                     -Default
                     digitalSignature: Bool = false,
                     nonRepudiation: Bool = false,
                     keyEncipherment: Bool = false,
                     dataEncipherment: Bool = false,
                     keyAgreement: Bool = false,
                     keyCertSign: Bool = false,
                     cRLSign: Bool = false,
                     encipherOnly: Bool = false,
                     decipherOnly: Bool = false
                     */
                    KeyUsage(
                        keyCertSign: true,
                    )
                )
            }
            
            return extensions
        }catch{
            printCatch(of: error)
            return nil
        }
    }
}
