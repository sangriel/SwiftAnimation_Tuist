
import UIKit

public extension UIView {

    func createSnapshot(withFrame : CGRect?,size : CGSize?,afterScreenUpdate : Bool = true) -> UIImage? {
        if let size = size {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
        }
        else {
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        }
        if let selectedFrame = withFrame {
            drawHierarchy(in: selectedFrame, afterScreenUpdates: afterScreenUpdate)
        }
        else {
            drawHierarchy(in: frame, afterScreenUpdates: afterScreenUpdate)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
