
import UIKit
import AVKit

class GlobalEvent {
    static var pushEvent = Events<UIViewController>()
    static var presentEvent = Events<(AVPlayer,AVPlayerViewController)>()
}
