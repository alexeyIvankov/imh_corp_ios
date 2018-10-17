//
//  WelcomePageDataSource.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 17.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomePagesDataSource : IWelcomePagesDataSource{
    
    func getPages() -> [IWelcomePage]{
        var pages = Array<IWelcomePage>()
        
        pages.append(WelcomePage(image: UIImage(named: "logo_welcome"), name: "Корпоративный портал ПМХ", details: "Представляем вам наше корпоративное приложение"))
        pages.append(WelcomePage(image: UIImage(named: "hand_welcome"), name: "Услуги", details: "Корпоративные документы и услуги у вас в кармане"))
        pages.append(WelcomePage(image: UIImage(named: "news_welcome"), name: "Новости", details: "Самые свежие новости из жизни компании"))
        pages.append(WelcomePage(image: UIImage(named: "contact_welcome"), name: "Люди", details: "Календарь событий и справочник сотрудников компании"))
        
        return pages
    }
}
