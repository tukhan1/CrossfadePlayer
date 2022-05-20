//
//  CFError.swift
//  CrossfadePlayer
//
//  Created by Egor Tushev on 24.04.2022.
//

import Foundation

enum CFError: String, Error {
    case urlError = "There is no audio with this name, please chooze another audio"
    case playerError = "Something wrong with player, try again later😅"
    case invalidAudioName = "Ooops, audio that you choose is unavailable"
}
