//
//  CharacterDetailViewController.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 28/07/2023.
//

import Cocoa

class CharacterDetailViewController: NSViewController {
    
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var characterImage: NSImageView!
    @IBOutlet weak var characterDescription: NSTextField!
    
    var stackView: NSStackView!
    var character: MarvelCharacter!
    var service = MarvelAPIService.shared
    var comicViewModel: ComicListViewModel!
    let blockingProgressview = MarvelBlockingProgressView()
    
    var comicViews: [MarvelComicView] = []
    override func viewDidAppear() {
        super.viewDidLoad()
        
        // Creating a custom NSStackView
        if let _ = stackView {
            stackView.removeFromSuperview()
        }
        
        stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.frame = NSRect(x: 0, y: 0, width: 220 * 20, height: 175)
        // Add the custom NSStackView to the NSScrollView's document view
        scrollView.documentView = stackView
        
        characterDescription.stringValue = String(from: character.description)
        comicViewModel = ComicListViewModel(character: character)
     
        characterImage.image = comicViewModel.fetchImage(for: character.imageURL, rowIndex: -1)
        blockingProgressview.show()
        comicViewModel.loadData { error in
            self.blockingProgressview.hide()
            guard error == nil else { return }
            self.setupViewComicList()
        }
    }
    
    func setupViewComicList() {
        for index in 0..<comicViewModel.count {
            let view = MarvelComicView(frame: NSRect(x: index + 120, y: 0, width: 200, height: 175))
            let comic = comicViewModel[index]!
            let description = String(from: comic.title)
            view.setupSubviews(image: comicViewModel.fetchImage(for: comic.imageURL, rowIndex: index), description: description)
            comicViews.append(view)
            stackView.addArrangedSubview(view)
            view.display()
        }
    }
}
