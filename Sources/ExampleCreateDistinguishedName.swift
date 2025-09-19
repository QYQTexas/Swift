//
//  ExampleCreateDistinguishedName.swift
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
final public class ExampleCreateDistinguishedName{
    private init(){};
}

extension ExampleCreateDistinguishedName{
    static public func createDistinguishedName() -> DistinguishedName?{
        do{
            let objectName = try DistinguishedName{
                CountryName("US")   //国家代码,常见有 CN 和 US
                StateOrProvinceName("Texas")    //省份或州名
                LocalityName("Austin")  //城市或地区名称
                OrganizationName("Cellinia")    //组织或公司名称
                OrganizationalUnitName("QYQ")   //组织内的部门
                CommonName("QYQCelliniaTexas")  /*
                                                 最常见的字段，表示实体的“通用名”。
                                                 • 对于服务器证书：通常是域名（如 www.example.com）
                                                 • 对于个人或 CA 证书：可能是人名或 CA 名称。
                                                 ⚠️ 注意：现代 TLS 中，CN 已被 Subject Alternative Name（SAN）取代用于域名验证，但仍常保留。
                                                 */
                EmailAddress("admin@QYQTexas.com")   //邮箱地址（非标准但常见）
                DomainComponent("Cellinia.Texas.QYQ.com")  //域组件（Domain Component，LDAP 风格）
                /*
                                                     此处两个结构体在1.9.0版本开始才开始存在，在 1.9.0 版本
                                                     之前，无法调用这两个结构体。可以通过在源码中查看目录
                                                     Sources/X509/DistinguishedNameBuilder，可以发现只有
                                                     当 1.9.0 版本及之后才存在这个结构体的 swift 文件。
                                                     */
            }
            return objectName
        }catch{
            return nil
        }
    }
    
    static public func printDistinguishedName(){
        guard let objectName = createDistinguishedName() else{
            return
        }
        print(objectName)
    }
}
