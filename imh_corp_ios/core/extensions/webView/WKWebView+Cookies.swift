//
//  WKWebView+Cookies.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import WebKit

//https://stackoverflow.com/questions/33156567/getting-all-cookies-from-wkwebview
extension WKWebView {
    
    @available(iOS 11.0, *)
    private var httpCookieStore: WKHTTPCookieStore  {
        return WKWebsiteDataStore.default().httpCookieStore
    }
    
    func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())  {
        var cookieDict = [String : AnyObject]()
        if #available(iOS 11.0, *) {
            httpCookieStore.getAllCookies { (cookies) in
                for cookie in cookies {
                    if let domain = domain {
                        if cookie.domain.contains(domain) {
                            cookieDict[cookie.name] = cookie.properties as AnyObject?
                        }
                    } else {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                    }
                }
                completion(cookieDict)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
