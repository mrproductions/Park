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
    case UserFriendNotDefinedTo = 8
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
            return "Действие с другом не указано"
        case .UserFriendNotDefinedTo:
            return "Друг не указан"
        case .FriendshipNotFound:
            return "Дружба не найдена"
        case .TrackIDNotFound:
            return "Идентификатор трека не найден"
        case .TrackNotFound:
            return "Трек не найден"
        case .ImageNotFound:
            return "Изображение не найдено"
        case .InvalidImage:
            return "Некорректное изображение"
        case .WeatherNotFound:
            return "Погода не найдена"
        case .FieldUndefined:
            return "Поле не указано"
        case .ValueUndefined:
            return "Значение не указано"
        case .UnsupportedField:
            return "Неподдерживаемое поле"
        case .UserToIDsUndefined:
            return "Идентификатор получателя не указан"
        case .MailOrLoginUndefined:
            return "Почта или логин не указаны"
        case .PasswordMD5Undefined:
            return "MD5 хеш пароля не указан"
        case .TaskUndefined:
            return "Упражнение не указано"
        case .EmailOrLoginUndefined:
            return "Электронная почта или логин не указаны"
        case .PasswordUndefined:
            return "Пароль не указан"
        case .DeviceIdUndefined:
            return "Идентификатор устройства не указан"
        case .UserAlreadyExists:
            return "Пользователь с таким именем уже существует"
        case .LoginUndefined:
            return "Логин не указан"
        case .MailUndefined:
            return "Почта не указана"
        case .MessageTitleUndefined:
            return "Тема сообщения не указана"
        case .MessageTextUndefined:
            return "Тело сообщения не указано"
        case .DTStartUndefined:
            return "Время начала не указано"
        case .DTNUndefined:
            return "DTN не указан"
        case .UserIsNotTaskAdmin:
            return "Пользователь не является администратором упражнения"
        case .UserIsNotEventAdmin:
            return "Пользователь не является администратором события"
        case .TaskNotFound:
            return "Упражнение не найдено"
        case .RasterForTaskNotFound:
            return "Растр для упражнения не найден"
        case .TeamUndefined:
            return "Команда не определена"
        case .TeamNotFound:
            return "Команда не найдена"
        case .TracksIdUndefined:
            return "Идентификатор трека не указан"
        case .TrackAccessDenied:
            return "Доступ к треку запрещен"
        case .SSIdUndefined:
            return "SS идентификатор не указан"
        case .SSTypeUndefined:
            return "SS тип не указан"
        case .SSTokenUndefined:
            return "SS токен не указан"
        case .NotCopyFile:
            return "Файл не был скопирован"
        case .ClubUndefined:
            return "Клуб не указан"
        case .UserIsNotClubAdmin:
            return "Пользователь не является администратором клуба"
        case .RasterMapNotFound:
            return "Растровая карта не найдена"
        }
    }
    
}
