//
//  Extensions.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import ImageViewer_swift

// MARK: - Форматирование даты/времени а-ля ВК.

extension Double {
    func getRelativeDateStringFromUTC() -> String {

        if let cached = dateTimeCache.object(forKey: self as NSNumber) { return cached as String }

        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true

        dateTimeCache.setObject(dateFormatter.string(from: date) as NSString, forKey: self as NSNumber)

        return dateFormatter.string(from: date)
    }
}

// MARK: - Форматирование даты/времени в соответствие с локалью ru_RU.

extension Double {
    func getDateStringFromUTC() -> String {

        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date)
    }
}

// MARK: - Форматирование целого числа с разбивкой по разрядам (используется в кол-ве подписчиков).

extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "RU")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)"
    }
}

// MARK: - Количество слов в строке.

extension String {
    var numberOfWords: Int {
        var count = 0
        let range = startIndex..<endIndex
        enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })
        return count
    }
}

// MARK: - Первые сколько-то слов текста.

extension StringProtocol {

    var byLines: [SubSequence] { components(separated: .byLines) }
    var byWords: [SubSequence] { components(separated: .byWords) }

    func components(separated options: String.EnumerationOptions)-> [SubSequence] {
        var components: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: options) { _, range, _, _ in components.append(self[range]) }
        return components
    }

    var firstWord: SubSequence? {
        var word: SubSequence?
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, stop in
            word = self[range]
            stop = true
        }
        return word
    }
    var firstLine: SubSequence? {
        var line: SubSequence?
        enumerateSubstrings(in: startIndex..., options: .byLines) { _, range, _, stop in
            line = self[range]
            stop = true
        }
        return line
    }
}

// MARK: - Кэширование изображений.

extension UIImageView {
    func asyncLoadImageUsingCache(withUrl urlString: String, withImageViewer: Bool = false, indicator: UIActivityIndicatorView? = nil) {

        self.image = nil

        if let cached = imageCache.object(forKey: urlString as NSString) {
            self.image = cached

            if withImageViewer {
                self.setupImageViewer(options: [.closeIcon(UIImage(systemName: "arrow.backward")!),
                                                .theme(self.traitCollection.userInterfaceStyle == .light ? .light : .dark)])
            }

            if indicator != nil {
                indicator!.stopAnimating()
            }

            return
        }

        AF.request(urlString, method: .get).responseImage { response in

            guard let image = response.value else { return }

            imageCache.setObject(image, forKey: urlString as NSString)
            self.image = image

            if withImageViewer {
                self.setupImageViewer(options: [.closeIcon(UIImage(systemName: "arrow.backward")!),
                                                .theme(self.traitCollection.userInterfaceStyle == .light ? .light : .dark)])
            }

            if indicator != nil {
                indicator!.stopAnimating()
            }
        }
    }
}

// MARK: - Get parent view controller.

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
}

// MARK: - Get label height.

extension UILabel {
    func getSize(constrainedWidth: CGFloat) -> CGSize {
        return systemLayoutSizeFitting(CGSize(width: constrainedWidth, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
