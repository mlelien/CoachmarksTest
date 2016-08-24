//
//  CoachmarksPageViewController.swift
//  IceFishing
//
//  Created by Emily Lien on 5/17/16.
//  Copyright © 2016 CUAppDev. All rights reserved.
//
import UIKit
class CoachmarksPageViewController: UIPageViewController {
    
    weak var coachmarksDelegate: CoachmarksPageViewControllerDelegate?
    var pageControl: UIPageControl!
    static var doubleCheckIndex = 0
    static var loadVC5 = false
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.newImageViewController(1),
                self.newImageViewController(2),
                self.newImageViewController(3),
                self.newImageViewController(4),
                self.newImageViewController(5)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        coachmarksDelegate?.coachmarksPageViewController(self,
                                                         didUpdatePageCount: orderedViewControllers.count)
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let width:CGFloat = screenSize.width / 10
        let height:CGFloat = screenSize.height / 13
        let x = screenSize.width / 2 - CGFloat(width / 2)
        let y:CGFloat = screenSize.height - height
        pageControl = UIPageControl(frame: CGRectMake(x, y, width, height))
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        view.addSubview(pageControl)
    }
    
    private func newImageViewController(number: Int) -> UIViewController {
        switch number {
        case 1:
            return ViewController1()
        case 2:
            return ViewController2()
        case 3:
            return ViewController3()
        case 4:
            return ViewController4()
        case 5:
            return ViewController5()
        default:
            return ViewController1()
        }
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewControllerNavigationDirection = .Forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'coachmarksDelegate' of the new index.
                            self.notifyCoachmarksDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_coachmarksDelegate' that the current page index was updated.
     */
    private func notifyCoachmarksDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.indexOf(firstViewController) {
            print("notifyCoachmarksDelegateOfNewIndex index: \(index)")
            CoachmarksPageViewController.doubleCheckIndex = index
            coachmarksDelegate?.coachmarksPageViewController(self,
                                                             didUpdatePageIndex: index)
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension CoachmarksPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        print("orderedViewControllersCount: \(orderedViewControllersCount) nextIndex: \(nextIndex)")
        guard orderedViewControllersCount != nextIndex else {
            
            print("last item in coachamrks going to dismiss")
            self.dismissViewControllerAnimated(true, completion: nil)
            
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension CoachmarksPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {
        print("swiped")
        if (completed) {
            print("swiped")
            let currentDisplayedViewController = pageViewController.viewControllers![0]
            if currentDisplayedViewController is ViewController1 {
                pageControl.currentPage = 0
            } else if currentDisplayedViewController is ViewController2 {
                pageControl.currentPage = 1
            } else if currentDisplayedViewController is ViewController3 {
                pageControl.currentPage = 2
            } else if currentDisplayedViewController is ViewController4 {
                pageControl.currentPage = 3
            } else if currentDisplayedViewController is ViewController5 {
                pageControl.currentPage = 4
            }
        }
        notifyCoachmarksDelegateOfNewIndex()
    }
    
}

protocol CoachmarksPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter coachmarksPageViewController: the CoachmarksPageViewController instance
     - parameter count: the total number of pages.
     */
    func coachmarksPageViewController(coachmarksPageViewController: CoachmarksPageViewController,
                                      didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter coachmarksPageViewController: the CoachmarksPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func coachmarksPageViewController(coachmarksPageViewController: CoachmarksPageViewController,
                                      didUpdatePageIndex index: Int)
    
}


// ----View controllers of the coachmarks ----//
class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("should be 0")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "coachmarks1")
        view.addSubview(imageView)
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("should be 1")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "coachmarks2")
        view.addSubview(imageView)
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("should be 2")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "coachmarks3")
        view.addSubview(imageView)
    }
}

class ViewController4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("should be 3")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "coachmarks4")
        view.addSubview(imageView)
        CoachmarksPageViewController.loadVC5 = true
    }
}

class ViewController5: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("should be 4")
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "coachmarks5")
        view.addSubview(imageView)
    }
}

