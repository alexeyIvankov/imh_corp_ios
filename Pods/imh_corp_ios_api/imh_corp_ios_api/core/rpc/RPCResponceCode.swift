

import Foundation

public protocol IRPCResponceCode{
 
    func code() -> Int
    func description() -> String
}

public enum RPCResponceCode: Int, IRPCResponceCode {
    
    case success = 0
    case authTokenExpaired = 1
    case notPermissions = 2
    case jsonFormatFailed = 3
    case moduleNameFailed = 4
    case functionNameFailed = 5
    case accountBaned = 6
    case functionNotImplemented = 7
    case clientVersionExpaired = 8
    case licenseExpaired = 9
    case errorUndefined = 99
    
    case failedLogin = 101
    case failedCode = 102
    case manyRequests = 104
    case failedDeviceId = 105
    case failedClientVersion = 106
    case failedClientPlatform = 107
    case failedName = 108
    case failedPhone = 109
    case failedEmail = 110
    
    public func code() -> Int {
        return self.rawValue
    }
    
    public func description() -> String {
        
        switch self {
            
        case .success:
            return "success"
        
        case .authTokenExpaired:
            return "authToken отсутствует или устарел"
            
        case .notPermissions:
            return "Недостаточно прав"
            
        case .jsonFormatFailed:
            return "Некорректный JSON"
            
        case .moduleNameFailed:
            return "Некорректный moduleName"
            
        case .functionNameFailed:
            return "Некорректный functionName"
            
        case .accountBaned:
            return "Пользователь заблокирован"
            
        case .functionNotImplemented:
            return "Функция пока не реализована"
            
        case .clientVersionExpaired:
            return "Версия клиента устарела"
            
        case .licenseExpaired:
            return "Лицензия истекла"
            
        case .errorUndefined:
            return "Неизвестная ошибка"
            
        case .failedLogin:
            return "Некорректный login"
            
        case .failedCode:
            return "Некорректный код"
            
        case .manyRequests:
            return "Слишком часто отправляете запросы на подтверждение "
            
        case .failedDeviceId:
            return "Некорректный deviceId"
            
        case .failedClientVersion:
            return "Некорректный clientVersion"
            
        case .failedClientPlatform:
            return "Некорректный clientPlatform"
            
        case .failedName:
            return "Некорректное имя"
            
        case .failedPhone:
            return "Некорректный телефон"
            
        case .failedEmail:
            return "Некорректный email"
    }
    }
    
}








    
