//
//  Constans.swift
//  avionicus
//
//  Created by Фамил Гаджиев on 24.10.16.
//  Copyright © 2016 Фамил Гаджиев. All rights reserved.
//

import Foundation

let TrackId = "http://avionicus.com/android/track_v0649.php?avkey=1M1TE9oeWTDK6gFME9JYWXqpAGc%3D&hash=58ecdea2a91f32aa4c9a1d2ea010adcf2348166a04&track_id=42505&user_id=22"

let BASE = "http://avionicus.com/android/track_v0649.php?"
let AVKEY = "1M1TE9oeWTDK6gFME9JYWXqpAGc"
let HASH = "58ecdea2a91f32aa4c9a1d2ea010adcf2348166a04&"
let TRACK_ID = "track_id=42505&"
let USER_ID = "user_id=22"

//http://avionicus.com/api/common/login?login=famil&password=7ca2d617fc3aa9ef13e32c48e02db870&response_type=json&avkey=1M1TE9oeWTDK6gFME9JYWXqpAGc
let LOGINURL = "http://avionicus.com/api/common/login?avkey=1M1TE9oeWTDK6gFME9JYWXqpAGc&login=famil&password=7ca2d617fc3aa9ef13e32c48e02db870&response_type=json"
let REGITRURL = "http://avionicus.com/api/common/registration?avkey=1M1TE9oeWTDK6gFME9JYWXqpAGc%3D&response_type=json&"
let userProfile = "http://avionicus.com/api/avtrack/user?avkey=1M1TE9oeWTDK6gFME9JYWXqpAGc%3D&hash=870eda99a1084d3b8f6a17f6d6fdfb40e8a5636377&response_type=json&action=get_profile"
let track = "http://avionicus.ru/android/tracks_v0648.php?avkey=1M1TE9oeWTDK6gFME9JYWXqpAGc%3D&hash=870eda99a1084d3b8f6a17f6d6fdfb40e8a5636377&response_type=json&user_id=3392"

let GoogleKey = "AIzaSyBgG0dJUojkL9upRYIjykFTFBNnae5mPII"
let GooglePlace = "AIzaSyC5j3iX-eJHNQREUK02VNmf9FfastILDTY"
let GooglePlace2 = "AIzaSyC5j3iX-eJHNQREUK02VNmf9FfastILDTY"

typealias DownloadComplete = () -> ()

let CURENT_TRACK = "\(BASE)\(AVKEY)\(HASH)\(TRACK_ID)\(USER_ID)"



