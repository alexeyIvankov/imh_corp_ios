

import Foundation

extension String {
    var localized: String {
        return MyApplication.application().localizator.localize(str: self)
    }
}
