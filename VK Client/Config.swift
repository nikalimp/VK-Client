//
//  Config.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit

let maxWordsCount = 60
let readMore = "Показать полностью..."

let activeURLColor = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 1)
let activeURLColorSelected = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 0.5)

let activeHashTagColor = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 1)
let activeHashTagColorSelected = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 0.5)

let activeVkHashTagColor = UIColor(red: 138.0/255, green: 138.0/255, blue: 142.0/255, alpha: 1)
let activeVkHashTagColorSelected = UIColor(red: 138.0/255, green: 138.0/255, blue: 142.0/255, alpha: 0.5)

let imageCache = NSCache<NSString, UIImage>()
let dateTimeCache = NSCache<NSNumber, NSString>()
