//
//  Examples/X509/ParseFromPem.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/20.
//
//

import X509


public struct X509ParseFromPemExamples{
    // MARK: -目录:
    
    // 解析 PEM 格式证书
    static public func parseCertificate() -> Certificate? {return _parseCertificate()}
    
    // 解析 PEM 格式私钥
    static public func parsePrivateKeyPkcs8() -> Certificate.PrivateKey? {return _parsePrivateKeyPkcs8()}   //pkcs8
    static public func parsePrivateKeyPkcs1Rsa() -> Certificate.PrivateKey? {return _parsePrivateKeyPkcs1Rsa()} //pkcs1-rsa
    static public func parsePrivateKeyWrong() -> Certificate.PrivateKey? {return _parsePrivateKeyWrong()}    //踩坑
    
    // HIDE
    private init(){}
}

// MARK: -解析 PEM 格式证书
private extension X509ParseFromPemExamples{
    static private func _parseCertificate() -> Certificate?{
        do{
            let cert = try Certificate(pemEncoded: RootCA.certificatePem)
            return cert
        }catch{
            printCatch(of: error)
            return nil
        }
    }

}

// MARK: -解析 PEM 格式私钥
private extension X509ParseFromPemExamples{
    // pkcs8
    static private func _parsePrivateKeyPkcs8() -> Certificate.PrivateKey?{
        do{
            let pkcs8 = try Certificate.PrivateKey(pemEncoded: RootCA.privateKeyPkcs8Pem)
            return pkcs8
        }catch{
            printCatch(of: error)
            return nil
        }
    }
    
    // pkcs1-rsa
    static private func _parsePrivateKeyPkcs1Rsa() -> Certificate.PrivateKey?{
        do{
            let pkcs1Rsa = try Certificate.PrivateKey(pemEncoded: RootCA.privateKeyPkcs1RsaPem)
            return pkcs1Rsa
        }catch{
            printCatch(of: error)
            return nil
        }
    }
    
    // 踩坑
    static private func _parsePrivateKeyWrong() -> Certificate.PrivateKey?{
        do{
            let pkWrong = try Certificate.PrivateKey(pemEncoded: RootCA.privateKeyWrong)
            return pkWrong
        }catch{
            let message: String = """
             @QYQTexas:
             PrivateKey 的解析有不同 case，查看 Certificate.PrivateKey 源码，init 会根据不同的 BEGIN-END 头尾信息调用不同 case 的解析函数。
             有两种方法可以解决，两者任选其一即可：
             1.使用 OpenSSL 或其他工具，查看私钥的结构，根据结构修改证书 PEM 格式中的 BEGIN-END 头尾信息，匹配结构对应的解析函数；
             2.统一转换为 pkcs8 结构，统一头尾信息为 PRIVATE KEY。

             以上述报错为示例，因为私钥结构是 pkcs1/rsa 结构，但 PEM 格式的头尾信息标记为 PRIVATE KEY，所以 init 走了 pkcs8 的解析函数，结构错误因而报错。
            """
            printCatch(of: error, say: message)
            return nil
        }
    }
}
