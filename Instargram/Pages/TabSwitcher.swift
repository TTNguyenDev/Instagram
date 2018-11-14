//
//  TabSwitcher.swift
//  Instargram
//
//  Created by TT Nguyen on 11/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class TabSwitcher: UIViewController, UITabBarControllerDelegate {
    var Switcher: UITabBarController!
    
    let home: Home = {
        let home = Home()
        home.tabBarItem.image = #imageLiteral(resourceName: "icons8-home-page-24")
        home.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return home
    }()
    
    let search: Discover = {
        let search = Discover()
        search.tabBarItem.image = #imageLiteral(resourceName: "icons8-search-24")
        search.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return search
    }()
    
    let photos: Photos = {
        let photos = Photos()
        photos.tabBarItem.image = #imageLiteral(resourceName: "icons8-instagram-old-26")
        photos.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return photos
    }()
    
    let notification: Notification = {
        let notification = Notification()
        notification.tabBarItem.image = #imageLiteral(resourceName: "icons8-heart-outline-24")
        notification.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return notification
    }()
    
    let account: Profile = {
        let account = Profile()
        account.tabBarItem.image = #imageLiteral(resourceName: "icons8-user-24")
        account.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return account
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabSwitcher()
    }
    
    fileprivate func createTabSwitcher() {
        Switcher = UITabBarController()
        
        let HomeNav = UINavigationController(rootViewController: home)
        let SearchNav = UINavigationController(rootViewController: search)
        let PhotosNav = UINavigationController(rootViewController: photos)
        let NotiNav = UINavigationController(rootViewController: notification)
        let AccNav = UINavigationController(rootViewController: account)
        
        HomeNav.navigationBar.topItem?.title = "Home"
        SearchNav.navigationBar.topItem?.title = "Discover"
        PhotosNav.navigationBar.topItem?.title = "Photos"
        NotiNav.navigationBar.topItem?.title = "Notification"
        AccNav.navigationBar.topItem?.title = "Profile"
        
        Switcher.viewControllers = [HomeNav, SearchNav, PhotosNav, NotiNav, AccNav]
        Switcher.tabBar.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        self.view.addSubview(Switcher.view)
    }
    
}
