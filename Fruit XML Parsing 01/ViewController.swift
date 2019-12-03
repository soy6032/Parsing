//
//  ViewController.swift
//  Fruit XML Parsing 01
//
//  Created by 김종현 on 2019/12/03.
//  Copyright © 2019 김종현. All rights reserved.
//  XCode 10.3

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    // 파싱 데이터를 저장할 자료구조
    var item:[String:String] = [:]
    var elements:[[String:String]] = []
    
    // 현재의 tag 저장
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml")
        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        let url = NSURL(string: strURL)
        
        if url != nil {
           // Pasing 시작
            let myParser = XMLParser(contentsOf: url! as URL)
            myParser?.delegate = self
            
            // Parsing Started!!!
            if (myParser?.parse())! {
                print("Parsing succed!")
                print(elements)
                
            } else {
                print("Parsing failed!")
            }
            
        } else {
            print("file load error")
        }
    }
    
    // XMLParser delegate Method
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        //print(currentElement)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // white char 제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //print(data)
        if !data.isEmpty {
            item[currentElement] = data
            //print(item)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            elements.append(item)
        }
    }
}

