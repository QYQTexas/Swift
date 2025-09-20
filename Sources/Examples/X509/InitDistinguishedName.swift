//
//  Examples/X509/InitDistinguishedName.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/19.
//

import X509

public struct X509InitDistinguishedNameExamples{
    // 初始化创建 DN
    static public func initObjectDN() -> DistinguishedName?{return _initObjectDN()}
    
    // HIDE
    private init(){}
}

extension X509InitDistinguishedNameExamples{
    static private func _initObjectDN() -> DistinguishedName?{
        do{
            let objectName = try DistinguishedName{
                CountryName("US")                           // C     国家代码,常见有 CN 和 US
                StateOrProvinceName("Texas")                // ST/S  省份或州名
                LocalityName("Austin")                      // L     城市或地区名称
                OrganizationName("Cellinia")                // O     组织或公司名称
                OrganizationalUnitName("QYQ")               // OU    组织内的部门
                CommonName("QYQCelliniaTexas")              /* CN
                                                             最常见的字段，表示实体的“通用名”。
                                                            • 对于服务器证书：通常是域名（如 www.example.com）
                                                            • 对于个人或 CA 证书：可能是人名或 CA 名称。
                                                            ⚠️ 注意：现代 TLS 中，CN 已被 Subject Alternative Name（SAN）取代用于域名验证，但仍常保留。
                                                             */
                EmailAddress("admin@QYQTexas.com")          // E     邮箱地址（非标准但常见）
                DomainComponent("Cellinia.Texas.QYQ.com")   // DC    域组件（Domain Component，LDAP 风格）
                /*
                 EmailAddress 和 DomainComponent 这两个结构体在1.9.0版本才开始存在。
                 查看源码目录 Sources/X509/DistinguishedNameBuilder，可以看到只有 1.9.0 版本及之后才存在这两个结构体的 .swift 文件。
                 */
            }
            return objectName
        }catch{
            printCatch(of: error)
            return nil
        }
    }
}
