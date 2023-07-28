//
//  CharacterListViewController.swift
//  MavelCharacters
//
//  Created by Munir Ahmed on 27/07/2023.
//

import Cocoa


class CharacterListViewController: NSViewController {

    @IBOutlet weak var characterListView: NSTableView!
    let blockingProgressview = MarvelBlockingProgressView()
    var characterViewModel = CharacterListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        characterViewModel.delegate = self
        blockingProgressview.frame = view.frame
        view.addSubview(blockingProgressview, positioned: .above, relativeTo: nil)
        characterListView.dataSource = self
        // Add observer to monitor the scrollView's content offset changes
        if let scrollView = characterListView.enclosingScrollView {
            scrollView.contentView.postsBoundsChangedNotifications = true
            NotificationCenter.default.addObserver(self, selector: #selector(scrollViewDidScroll(_:)), name: NSView.boundsDidChangeNotification, object: scrollView.contentView)
            
        }
        blockingProgressview.show()
        characterViewModel.loadData { error in
            self.blockingProgressview.hide()
            guard error == nil else { return }
            self.characterListView.reloadData()
        }
    }
}

extension CharacterListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return characterViewModel.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        guard let tableColumn = tableColumn else { return nil }
        
        let attribute = CharacterAttributeEnum(rawValue: tableColumn.identifier.rawValue )
        return characterViewModel[row, attribute]
    }
}

extension CharacterListViewController {
    @objc func scrollViewDidScroll(_ notification: Notification) {
        // Calculate the visible height and the content height
        if let scrollView = characterListView.enclosingScrollView {
            let visibleHeight = scrollView.contentView.bounds.size.height
            let contentHeight = scrollView.documentView?.frame.size.height ?? 0
            
            // Calculate the current scroll position
            let scrollPosition = scrollView.contentView.bounds.origin.y
            
            // Check if the scroll position is at the bottom
            let isAtBottom = (scrollPosition + visibleHeight) >= contentHeight
            
            if isAtBottom && blockingProgressview.isHidden {
                // The scroll view has reached the end of its view
                blockingProgressview.show()
                characterViewModel.loadData { error in
                    self.blockingProgressview.hide()
                    guard error == nil else { return }
                    self.characterListView.reloadData()
                }
            }
        }
    }
}

extension CharacterListViewController: MarvelHeroImageDelegate {
    func didFinishLoadingImage(rowIndex: Int) {
        DispatchQueue.main.async {
            self.characterListView.reloadData()
        }
    }
}
