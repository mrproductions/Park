//
//  AvionicusError.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 15.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation

enum AvionicusError: Int {
    case AnotherError = 101
    case WrongHash = 1
    case UserNotFound = 2
    case StatusUndefined = 3
    case UserUndefined = 4
    case EventUndefined = 5
    case EventNotFound = 6
    case UserFriendActionUndefined = 7
    case UserFriendNotDefindTo = 8
    case FriendshipNotFound = 9
    case TrackIDNotFound = 10
    case TrackNotFound = 11
    case ImageNotFound = 12
    case InvalidImage = 13
    case WeatherNotFound = 14
    case FieldUndefined = 15
    case ValueUndefined = 16
    case UnsupportedField = 17
    case UserToIDsUndefined = 18
    case MailOrLoginUndefined = 19
    case PasswordMD5Undefined = 20
    case TaskUndefined = 21
    case EmailOrLoginUndefined = 22
    case PasswordUndefined = 23
    case DeviceIdUndefined = 24
    case UserAlreadyExists = 25
    case LoginUndefined = 26
    case MailUndefined = 27
    case MessageTitleUndefined = 28
    case MessageTextUndefined = 29
    case DTStartUndefined = 30
    case DTNUndefined = 31
    case UserIsNotTaskAdmin = 32
    case UserIsNotEventAdmin = 33
    case TaskNotFound = 34
    case RasterForTaskNotFound = 35
    case TeamUndefined = 36
    case TeamNotFound = 37
    case TracksIdUndefined = 38
    case TrackAccessDenied = 39
    case SSIdUndefined = 40
    case SSTypeUndefined = 41
    case SSTokenUndefined = 42
    case NotCopyFile = 43
    case ClubUndefined = 44
    case UserIsNotClubAdmin = 45
    case RasterMapNotFound = 46
    
    var description: String {
        switch self {
        case .AnotherError:
            return "Неизвестная ошибка"
        case .WrongHash:
            return "Неверный хеш"
        case .UserNotFound:
            return "Пользователь не найден"
        case .StatusUndefined:
            return "Статус не указан"
        case .UserUndefined:
            return "Пользователь не указан"
        case .EventUndefined:
            return "Событие не указано"
        case .EventNotFound:
            return "Событие не найдено"
        case .UserFriendActionUndefined:
            return ""
        case .UserFriendNotDefindTo:
            return ""
        case .FriendshipNotFound:
            return ""
        case .TrackIDNotFound:
            return ""
        case .TrackNotFound:
            return ""
        case .ImageNotFound:
            return ""
        case .InvalidImage:
            return ""
        case .WeatherNotFound:
            return ""
        case .FieldUndefined:
            return ""
        case .ValueUndefined:
            return ""
        case .UnsupportedField:
            return ""
        case .UserToIDsUndefined:
            return ""
        case .MailOrLoginUndefined:
            return ""
        case .PasswordMD5Undefined:
            return ""
        case .TaskUndefined:
            return ""
        case .EmailOrLoginUndefined:
            return ""
        case .PasswordUndefined:
            return ""
        case .DeviceIdUndefined:
            return ""
        case .UserAlreadyExists:
            return ""
        case .LoginUndefined:
            return ""
        case .MailUndefined:
            return ""
        case .MessageTitleUndefined:
            return ""
        case .MessageTextUndefined:
            return ""
        case .DTStartUndefined:
            return ""
        case .DTNUndefined:
            return ""
        case .UserIsNotTaskAdmin:
            return ""
        case .UserIsNotEventAdmin:
            return ""
        case .TaskNotFound:
            return ""
        case .RasterForTaskNotFound:
            return ""
        case .TeamUndefined:
            return ""
        case .TeamNotFound:
            return ""
        case .TracksIdUndefined:
            return ""
        case .TrackAccessDenied:
            return ""
        case .SSIdUndefined:
            return ""
        case .SSTypeUndefined:
            return ""
        case .SSTokenUndefined:
            return ""
        case .NotCopyFile:
            return ""
        case .ClubUndefined:
            return ""
        case .UserIsNotClubAdmin:
            return ""
        case .RasterMapNotFound:
            return ""
        default:
            return "Неизвестная ошибка"
        }
    }
    
}
