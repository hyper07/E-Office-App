//
//  DataManage.swift
//  TalkTalk
//
//  Created by Danielle Ahn on 9/23/18.
//  Copyright © 2018 Kibaek Kim. All rights reserved.
//

import UIKit




fileprivate func parseDate(_ str : String) -> Date {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    return dateFormat.date(from: str)!
}

fileprivate func firstDayOfMonth(date : Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
}


class DataManage: NSObject {

   
    static let sharedInstance = DataManage()
    var chatroom: [String] = ["E-Approval(#1122)", "Voucher(#1232)", "PO/Payment(#4221)", "PO/Payment(#4224)","CSR(#MM18-2423)", "RSR(#2322)"]
    var selectedvalue = ""
    var newChat = false
    var selectedChatname = ""
    var selectedToDoTitle = ""
    var selectedRow = -1
    var appprovedToDoTitle = ""
    
    /*
    var headlines = [
        Headline(id: 1, date: parseDate("2018-08-15"), title: "E-Approval(#1233)", text: "For new employee, purchase 5 computer and 10 monitors.", image: "E-Approval"),
        Headline(id: 2, date: parseDate("2018-08-26"), title: "PO/Payment(#4224)", text: "Purchase requst mold for item KISS01, KISS02, KISS03.", image: "PoPayment"),
        Headline(id: 3, date: parseDate("2018-08-26"), title: "Expense(#2312)", text: "Business Trip Expense for traveling Asia to support SAP MM Setup", image: "Expense"),
        Headline(id: 4, date: parseDate("2018-08-27"), title: "Expense(#2421)", text: "IT Team Dinner for New Employees. 12 Employees attended and Controller attended", image: "Expense"),
        Headline(id: 5, date: parseDate("2018-09-01"), title: "Voucher(#2432)", text: "For wireless extender setup at HQ building. 12 Netgear extender will be purcased from Amazon.", image: "Voucher")
    ]
    */
   /*
    var headlinesDemo = [
    Headline(id: 1, date: parseDate("2018-08-15"), title: "E-Approval(#1233)", text: "For new employee, purchase 5 computer and 10 monitors.", image: "E-Approval"),
    Headline(id: 2, date: parseDate("2018-08-26"), title: "PO/Payment(#4224)", text: "Purchase requst mold for item KISS01, KISS02, KISS03.", image: "PoPayment"),
    Headline(id: 3, date: parseDate("2018-08-26"), title: "Expense(#2412)", text: "Business Trip Expense for traveling Asia to support SAP MM Setup", image: "Expense"),
    Headline(id: 4, date: parseDate("2018-08-27"), title: "Expense(#2421)", text: "IT Team Dinner for New Employees. 12 Employees attended and Controller attended", image: "Expense"),
    Headline(id: 5, date: parseDate("2018-09-01"), title: "Voucher(#2432)", text: "For wireless extender setup at HQ building. 12 Netgear extender will be purcased from Amazon.", image: "Voucher"),
    ]
   */
    var StringTwo = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor arcu sed finibus accumsan. Vivamus cursus, ligula non fringilla vehicula, ante mauris suscipit magna, eu varius lacus mauris accumsan risus. Sed imperdiet, mi vitae condimentum consectetur, ipsum metus dictum est, eu ornare velit nulla in ipsum. Ut iaculis lorem vel felis suscipit, feugiat venenatis lectus elementum. Nunc ut vestibulum erat. Cras justo orci, volutpat convallis neque nec, auctor malesuada odio."
    var StringOne = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porttitor arcu sed finibus accumsan. Vivamus cursus, ligula non fringilla vehicula, ante mauris suscipit magna, eu varius lacus mauris accumsan risus. Sed imperdiet, mi vitae condimentum consectetur, ipsum metus dictum est, eu ornare velit nulla in ipsum. Ut iaculis lorem vel felis suscipit, feugiat venenatis lectus elementum. Nunc ut vestibulum erat. Cras justo orci, volutpat convallis neque nec, auctor malesuada odio. Sed in mauris non massa molestie elementum. In pretium, nisi ut pellentesque ornare, eros tortor ultrices lacus, non tristique massa orci id orci. Ut sodales ante et sagittis venenatis. Morbi nec augue euismod, commodo lorem non, euismod nulla. Nullam lobortis blandit dui, id egestas arcu sagittis ac.  Sed ut dapibus sapien, sit amet rutrum eros. \n Cras sit amet augue quis lacus pellentesque posuere. In elementum dui magna, a tincidunt nunc viverra nec. Suspendisse potenti. Sed elementum justo a neque hendrerit, a rutrum ante fringilla. Maecenas pulvinar interdum nisl, et ultrices arcu fermentum sed. Nulla imperdiet dui accumsan ipsum sodales tempor. Morbi interdum metus ac mi accumsan pulvinar. Phasellus placerat lobortis velit vitae iaculis. Nam fermentum tempus augue eget faucibus. Mauris imperdiet id erat ut convallis. Proin in dapibus libero, ut accumsan ante. \n Phasellus suscipit mauris nec elit lacinia, nec lacinia dui porttitor. Integer commodo elementum metus, vitae molestie arcu sodales non. Suspendisse auctor eleifend nibh, vel tincidunt diam accumsan ac. Aenean eget augue et nunc imperdiet vulputate eget ac lorem. Ut porttitor suscipit sodales. Pellentesque malesuada fermentum elit, quis semper tortor scelerisque ac. Ut rutrum nibh at cursus interdum. Aenean in velit vel massa pharetra tempus nec aliquam lorem. Nullam fermentum venenatis ipsum, sed congue neque. In posuere, tellus a feugiat sagittis, lorem nulla scelerisque magna, non venenatis urna velit in justo. Suspendisse eget convallis sapien, eget porttitor massa. \n Vestibulum sed facilisis tortor. Mauris lobortis tellus eu nisi rutrum suscipit. Cras ullamcorper dolor ac libero molestie scelerisque. Nullam et vulputate purus. Quisque quis cursus nunc. Vivamus laoreet mi id leo vulputate suscipit. Donec vestibulum diam a dolor hendrerit accumsan. Integer auctor metus a elit dignissim, vel luctus leo fermentum. Quisque ac fermentum diam. Donec tempor consectetur mauris, in feugiat nibh aliquam sit amet. Aenean porttitor in mi vel tincidunt. Vivamus condimentum odio eget ante hendrerit, ut scelerisque augue consectetur. Vivamus dictum non tortor at pellentesque. Vestibulum aliquam eros ut nulla eleifend rhoncus. Vivamus vitae massa sed orci rhoncus laoreet.  Duis commodo sagittis tortor a rutrum. Phasellus vel lacinia velit. Aliquam congue rutrum justo, non euismod quam elementum vel. Nullam nec tortor felis. Integer nec ornare massa, id interdum nibh. Etiam odio nisi, venenatis et consequat finibus, suscipit et nisl. Donec a libero nec leo pretium lobortis eget et magna. In quis ipsum eu turpis lacinia condimentum. Aenean malesuada et sapien sed scelerisque. \n Etiam interdum nibh ac nulla sodales interdum. Etiam elementum mollis leo, vitae tincidunt magna commodo nec. Vestibulum hendrerit, nisi id laoreet feugiat, dolor sapien iaculis velit, vel eleifend nisl risus sed massa. Nulla sem metus, iaculis at neque id, ultricies semper nunc. Cras justo nulla, bibendum sit amet iaculis sed, condimentum efficitur magna. Nam mi erat, finibus quis felis nec, vulputate varius risus. Curabitur blandit elit eu mauris porttitor, nec luctus purus interdum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; \n Duis malesuada cursus nibh, eu suscipit dolor viverra sit amet. Integer mattis tortor dui, quis feugiat ex finibus sed. Cras sagittis nisi nisl, sed tempor mi efficitur ut. Quisque in tortor sit amet turpis eleifend bibendum.Morbi ullamcorper ligula nec vehicula maximus. Nulla nibh felis, tempor nec laoreet sed, consectetur non quam. Integer sodales arcu enim, id imperdiet nisi aliquet sit amet. Quisque ullamcorper massa sed magna aliquam mattis. \n Aliquam maximus tempor ex, sit amet rutrum arcu mattis sit amet. Ut eleifend interdum aliquam. Sed accumsan nibh in est commodo maximus. Sed lacinia porta mi ac feugiat. Nulla sed eros commodo, tincidunt dolor sed, rhoncus felis. Donec ut facilisis neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla quis mi eu tellus tincidunt mollis non tincidunt sem. Integer tempus ex sagittis gravida elementum. Duis tempor facilisis semper."
    
    //override init() {
    //    super.init()
       
    //}
    
    //## for Present view Controller porgrammatically
    //let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC")
    //self.present(controller, animated: true, completion: nil)
    
    // Safe Present
    //if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
    //{
    //    present(vc, animated: true, completion: nil)
    //}
    
    //## for Push view Controller porgrammatically
    //let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as UIViewController
    //navigationController?.pushViewController(vc, animated: true)
    
    // Safe Push VC
    //if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? JunctionDetailsVC {
    //    if let navigator = navigationController {
    //        navigator.pushViewController(viewController, animated: true)
    //    }
    //}
    
    
    // ## for view controll
    //func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    
    //if Globals.USER_ID == nil{
    //    let loginScreen = storyBoard.instantiateViewControllerWithIdentifier("LoginVC")
    //    self.window?.rootViewController = loginScreen
    
    //}else{
    //    let mainScreen = storyBoard.instantiateViewControllerWithIdentifier("ViewController")
    //    self.window?.rootViewController = mainScreen
    //}
    //   return true
    //}
    
    //func logout() {
    //    if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
    //        Globals.USER_ID = nil
    //        appDelegate.window?.rootViewController = loginScreen
    //    }
    //}
    
    //## for timer
    //DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
    
    //})
    

    
    
}
