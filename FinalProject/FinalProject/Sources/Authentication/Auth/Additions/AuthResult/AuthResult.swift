//
//  AuthResult.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import Firebase

enum AuthResult: Equatable {
    case successSignIn
    case fieldsNotFilled
    case emailVerificationSent
    case emailNotVerified(user: User)
    case resetPasswordLinkSent
    case userNotFound
    case wrongPassword
    case badEmailFormat
    case weakPassword
    case emailAlreadyInUse
    case networkError
    case serverError
    case tooManyRequests
    case undefinedError
    
    var title: String {
        switch self {
        case .emailNotVerified:
            return "E-mail не подтвержден"
        case .emailVerificationSent:
            return "Письмо для подтверждения отправлено"
        case.resetPasswordLinkSent:
            return "Письмо для сброса отправлено"
        case .userNotFound:
            return "Пользователь с таким e-mail не найден"
        case .wrongPassword:
            return "Пароль введен не верно"
        case .fieldsNotFilled:
            return "Не все поля заполнены"
        case .successSignIn:
            return ""
        case .badEmailFormat:
            return "Неверный формат e-mail"
        case .weakPassword:
            return "Слабый пароль"
        case .emailAlreadyInUse:
            return "E-mail уже занят"
        case .networkError:
            return "Не удалось подключиться"
        case .serverError:
            return "Ошибка на сервере"
        case .tooManyRequests:
            return "Много запросов"
        case .undefinedError:
            return "Непредвиденная ошибка"
        }
    }
    
    var message: String {
        switch self {
        case .emailNotVerified:
            return "Отправить письмо для подтверждения?"
        case .emailVerificationSent:
            return "На введеный вами e-mail отправлено письмо с ссылкой для подтверждения."
        case.resetPasswordLinkSent:
            return "На введеный вами e-mail отправлено письмо с ссылкой для сброса пароля."
        case .userNotFound:
            return "Желаете зарегистрироваться?"
        case .wrongPassword:
            return "Проверьте ввели ли вы пароль верно. Если у вас не получается войти, вы можете сбросить пароль."
        case .fieldsNotFilled:
            return "Пожалуйста заполните поля."
        case .successSignIn:
            return ""
        case .badEmailFormat:
            return "E-mail должен быть в формате example@mail.com."
        case .weakPassword:
            return "В целях вашей безопасности придумайте пароль сложнее"
        case .emailAlreadyInUse:
            return "На введеный вами e-mail уже создана учетная запись."
        case .networkError:
            return "Пожалуйста проверьте ваше подключение к сети"
        case .serverError:
            return "На сервере произошла ошибка. Приносим свои извинение. Исправим в ближайшее время."
        case .tooManyRequests:
            return "Доступ к этому аккаунту временно заблокирован. Вы можете сбросить пароль или повторить попытку позже."
        case .undefinedError:
            return "Приносим свои извинение. Исправим в ближайшее время."
        }
    }
    
    var buttonTitle: String {
        return "ОК"
    }
}
