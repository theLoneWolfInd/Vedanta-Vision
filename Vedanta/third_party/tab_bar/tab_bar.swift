//
//  tab_bar.swift
//  Vedanta
//
//  Created by Dishant Rajput on 14/09/22.
//

import UIKit

class tab_bar: UITabBarController {

    let selectedColor   = UIColor.red//UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 86.0/255.0, alpha: 1)
    let unselectedColor = UIColor.init(red: 22.0/255.0, green: 12.0/255.0, blue: 86.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        tabBar.tintColor = .red
        
        let myTabBarItem2 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "vedanta_red")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        myTabBarItem2.selectedImage = UIImage(named: "vedanta_blue")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        
        myTabBarItem2.title = ""
        
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
//        UITabBar.appearance().barTintColor = UIColor.black // your color
        
//        tabBar.items?.index(before: 2)
        
//        tabBar.selectedItem
//        tabBar.barTintColor = .red
        
//        if
        
//        self.tabBar[0].bac
        
//        let numberOfItems = CGFloat(tabBar.items!.count)
//        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
//        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.red, size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
//
//        // remove default border
//        tabBar.frame.size.width = self.view.frame.width + 4
//        tabBar.frame.origin.x = 0
//        
//        var tab1 : UITabBarItem = self.tabBar.items![0] as UITabBarItem
//        tab1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: (UITabBarItem?)) {
        if item == (self.tabBar.items!)[0]{
           //Do something if index is 0
            print("one")
            
            let tab1 : UITabBarItem = self.tabBar.items![0] as UITabBarItem
                    tab1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .normal)
            
//            tab1.
            
        }
        else if item == (self.tabBar.items!)[1]{
           //Do something if index is 1
            print("two")
            
            let tab1 : UITabBarItem = self.tabBar.items![0] as UITabBarItem
                    tab1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .normal)
        }
    }

}

extension UIImage {

   class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
   }
}
