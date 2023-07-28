import Cocoa

class CenteredMultilineTextFieldCell: NSTextFieldCell {
    override func cellSize(forBounds rect: NSRect) -> NSSize {
        // Calculate the size required for the text with multiple lines
        let textRect = rect.insetBy(dx: 4, dy: 4) // Adjust insets if needed
        let textStorage = NSTextStorage(string: stringValue)
        let textContainer = NSTextContainer(containerSize: NSSize(width: textRect.width, height: CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        layoutManager.glyphRange(forBoundingRect: textRect, in: textContainer)
        
        let usedRect = layoutManager.usedRect(for: textContainer)
        let cellSize = NSSize(width: textRect.width, height: ceil(usedRect.height) + 8) // Adjust 8 if needed
        
        return cellSize
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        // Calculate the rectangle to draw the text inside the cell
        let textRect = cellFrame.insetBy(dx: 4, dy: 4) // Adjust insets if needed
        
        // Create the text storage, text container, and layout manager
        let textStorage = NSTextStorage(string: stringValue)
        let textContainer = NSTextContainer(containerSize: NSSize(width: textRect.width, height: CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Center the text vertically
        let usedRect = layoutManager.usedRect(for: textContainer)
        let yOffset = textRect.height - usedRect.height
        let drawRect = NSRect(x: textRect.minX, y: textRect.minY + yOffset / 2, width: textRect.width, height: usedRect.height)
        
        // Draw the text
        layoutManager.drawGlyphs(forGlyphRange: layoutManager.glyphRange(forBoundingRect: drawRect, in: textContainer), at: drawRect.origin)
    }
}
