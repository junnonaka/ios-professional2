//
//  LocalState.swift
//  Banky2
//
//  Created by 野中淳 on 2022/02/05.
//

import Foundation

public class LocalState{
    
    private enum Keys:String{
        case hasOnbording
    }
    
    public static var hasOnborded:Bool{
        get{
            return UserDefaults.standard.bool(forKey: Keys.hasOnbording.rawValue)
        }
        set(newValue){
            UserDefaults.standard.set(newValue,forKey: Keys.hasOnbording.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}
