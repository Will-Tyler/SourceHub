//
//  RepositoryViewController.swift
//  SourceHub
//
//  Created by APPLE on 4/15/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit

class RepositoryViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    convenience init() {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
        
        tabBarItem.title = "Repository"
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let commitsViewController = CommitsViewController()
    
    var repo: GitHub.Repository? {
        didSet {
            commitsViewController.repo = repo
        }
    }
    private lazy var pages = [ContentsViewController(), commitsViewController] as [UIViewController]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        delegate = self
        dataSource = self
        
        if let first = pages.first {
            navigationItem.title = first.title
            setViewControllers([first], direction: .forward, animated: false)
        }

    }
    
    // MARK: UIPageViewControllerDelegate
    private var newTitle: String?
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        assert(pendingViewControllers.count == 1)

        if let first = pendingViewControllers.first {
            navigationItem.title = first.title
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        assert(previousViewControllers.count == 1)
        
        if let previous = previousViewControllers.first, !completed {
            navigationItem.title = previous.title
        }
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        
        index -= 1
        
        return pages[index]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        index += 1
        
        guard index < pages.count else {
            return nil
        }
        
        return pages[index]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
