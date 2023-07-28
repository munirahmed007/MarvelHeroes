import Cocoa

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.height
    }

}

class CenteredMultilineTextFieldCell: NSTextFieldCell {
    override func titleRect(forBounds theRect: NSRect) -> NSRect
       {
           var titleFrame = super.titleRect(forBounds: theRect)
           var titleHeight = self.attributedStringValue.heightWithConstrainedWidth(width: titleFrame.width)
           
           if titleHeight > 100 {
               print("")
           }
           titleFrame.origin.y = theRect.origin.y - 1.0 + (theRect.size.height - titleHeight) / 2.0
           return titleFrame
       }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView)
       {
           var titleRect = self.titleRect(forBounds: cellFrame)

           self.attributedStringValue.draw(in: titleRect)
       }
}
