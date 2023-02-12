
import UIKit

public extension UIView {

    public func createSnapshot(withFrame : CGRect?,size : CGSize?) -> UIImage? {
        if let size = size {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
        }
        else {
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        }
        if let selectedFrame = withFrame {
            drawHierarchy(in: selectedFrame, afterScreenUpdates: true)
        }
        else {
            
            drawHierarchy(in: frame, afterScreenUpdates: true)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
