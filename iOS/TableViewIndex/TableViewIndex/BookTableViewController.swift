//
//  BookTableViewController.swift
//  TableViewIndex
//
//  Created by MandyXue on 15/11/13.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController{
    
//    var headers = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","#"]
//    var books = ["实用英语语法","托福核心词汇21天突破","乱序版GRE词汇精选（绿宝书）","乱序版六级词汇（绿宝书）","四级词汇（红宝书）","托福考试备考策略与模拟试题","剑桥BEC真题集","80天攻克雅思核心词汇","太傻单词","新日本语教程（初级）","新日语基础教程（一）学习辅导用书","新日本语教程（初级）同步练习册","新托福考试阅读技能与考点精练（三）","新托福考试阅读特训","新概念英语3","GRE高频词汇句子填空","GRE官方题库范文精讲","新托福全真题库","英语学习三宝典","新托福考试阅读技能与考点精练（二）","新GRE填空教程","新GRE阅读教程","怎样让新托福写作的语言更美国","周立波诙词典","新概念英语4","托福词以类记","新日语基础教程（一）","直通美国","GRE&GMAT阅读难句教程","GRE数学教程","GRE阅读理解教程","新编大学德语","便携版六级词汇（红宝书）","objective-c 程序设计（第4版）","iOS 5 cocos2d 游戏开发实战（第2版）","cocos2d-x手机游戏开发实战","iOS cocos2d 2游戏开发实战（第3版）","iPhone & iPad cocos2d游戏开发实战","iOS 5基础教程","iPhone &iPad cocos 2d Game Dev","Unity 3D 游戏开发","游戏美术：2D艺术与3D建模","windows游戏编程大师技巧（第二版）","iOS 5编程入门经典（第3版）","让云触手可及 微软云计算实践","QuickTime 影音技术实务","QuickTime 6","Discovering QuickTime","苹果培训系列教材 iLife’09","苹果专业培训系列教材Motion 4","vc++ 深入详解","unix 环境高级编程","深入浅出 数据分析","光电子技术入门","软件精英是这样炼成的","C Primer Plus(第五版)中文版","Final Cut Pro 2","Design Pattern ","管理高手Project2003 项目管理应用","月亮宝石（上部）","此时此地","野蛮生长","上海 影像 都市","看懂世界格局的第一本书","当代中国外交简史","凡人可成佛","气场的秘密","你是那人间四月天","灿烂千阳","1844年经济学哲学手稿","21世纪大学英语英汉互译教程","视听说教程（第二版）学生用书 4","剑桥国际商务英语","跨文化商务交际","大学英语阅读教程 3","跨文化交流入门","中级翻译教程","离散数学结构（第6版 影印版）","离散数学结构（第5版 翻译版）","大学英语阅读教程 4","辩证唯物主义和历史唯物主义原理","软件项目管理实践","计算机科学导论（第3版）","Essential C++ 中文版","软件项目管理实践 中文版","现代通信网技术","计算机组成与结构","计算机系统结构","计算机组成与结构（第4版）","计算机系统结构学习指导与题解","计算机组成原理与系统结构实验教程","世界大战与局部战争研究","数据库系统概念（原书第五版）","数据库系统概念（拆分版）","程序设计语言 编译原理（第3版）","一个操作系统的实现","计算机网络与互联网（第四版）","大学生心理探秘","马基（2013版）","马基（2010版）","毛概（2013版）","毛概（2010版）","艺术与传播","Design Patterns Slides","软件测试基础教程（英文版 第2版）","高级软件测试技术","软件测试技术基础","计算机图形学基础教程（第2版）","计算机图形学（第3版）","算法设计与分析基础（第3版 影印版）","计算机网络（第5版）","计算机网络（第4版）","操作系统概念（第7版 英文版）","操作系统概念（第7版 中文版）","Java 编程思想","编译原理及实践","软件工程实践者的研究方法（原书第6版）","软件工程实践者的研究方法（原书第7版）本科教学版","数据结构、算法与应用 —c++语言描述","c++数据结构与程序设计","软件工程实践者之路（第6版）","算法设计与分析基础（第2版 影印版）","c程序设计（第三版）","汇编语言（第2版）","IBM-PC汇编语言程序设计（第2版）","IBM-PC汇编语言程序设计（第2版）","大学生数学竞赛试题研究生入学考试难题 解析选编","微积分 第三版 上册","微积分 第三版 下册","数学模型","概率统计（第五版）","概率统计（第四版）","微积分 第三版 下册 同步辅导及习题全解"]
    var headers = ["A","B","J","K"]
    var books = ["啊0","啊1","啊2","啊3","啊4","啊5","啊6","本子0","本子1","本子2","本子3","本子4","本子5","本子6","计算机0","计算机1","计算机2","计算机3","计算机4","计算机5","计算机6","跨文化0","跨文化1","跨文化2","跨文化3","跨文化4","跨文化5","跨文化6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        books = books.sort({
//            for {
//                
//            }
//        }())

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    //section number
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headers.count
    }
    
    //section title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    //section cell number
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    //index title
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return headers
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        var currentIndex = 0
        for head in headers {
            if head == getFirstLetter(title){
                break
            }
            currentIndex++
        }
        return currentIndex
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "BookCellIdentifier"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        cell.textLabel?.text = books[indexPath.section * 7 + indexPath.item]
        return cell
    }
    
    // MARK: - Get first letter
    
    func getFirstLetter(bookName: String?) -> String?{
        if bookName != nil {
            let mutableString = NSMutableString(string: bookName!) as CFMutableString
            if CFStringTransform(mutableString, nil, kCFStringTransformMandarinLatin, false){
                if CFStringTransform(mutableString, nil, kCFStringTransformMandarinLatin, false){
                    let tempName = mutableString as String
                    let firstLetter = tempName.capitalizedString.substringFromIndex(tempName.startIndex.advancedBy(0))
                    return firstLetter
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
