//
//  Combine+UIKit.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/09.
//

import Combine
import UIKit

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}

extension UIScrollView {
    func scrollPublisher(util offsetY: CGFloat) -> AnyPublisher<Bool, Never> {
        publisher(for: \.contentOffset)
            .map {
                let threshold = offsetY + self.frame.height + $0.y
                return self.contentSize.height - threshold < 0
            }.removeDuplicates()
            .filter { $0 }
            .throttle(
                for: .milliseconds(200),
                scheduler: RunLoop.main,
                latest: false
            ).eraseToAnyPublisher()
    }
}
