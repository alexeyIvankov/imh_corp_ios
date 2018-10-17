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
        
        pages.append(WelcomePage(image: UIImage(named: "logo_welcome_icon"), name: "Корпоративный портал ПМХ", details: "Представляем вам наше корпоративное приложение"))
        pages.append(WelcomePage(image: UIImage(named: "folder_welcome_icon"), name: "Услуги", details: "Корпоративные документы и услуги у вас в кармане"))
        pages.append(WelcomePage(image: UIImage(named: "star_welcome_icon"), name: "Новости", details: "Самые свежие новости из жизни компании"))
        pages.append(WelcomePage(image: UIImage(named: "contact_welcome_icon"), name: "Люди", details: "Календарь событий и справочник сотрудников компании"))
        pages.append(WelcomePage(image: UIImage(named: "check_welcome_icon"), name: "Добро пожаловать", details: "Авторизуйтесь что бы войти"))
        
        return pages
    }
}
