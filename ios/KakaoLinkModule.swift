//
//  KakaoLinkModule.swift
//  Mom
//
//  Created by 양수민 on 2021/01/11.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation;
import KakaoSDKLink;
import KakaoSDKCommon
import KakaoSDKTemplate

@objc(KakaoLinkModule)
class KakaoLinkModule: NSObject {
  @objc
  func initKakao() -> Void{
    KakaoSDKCommon.initSDK(appKey: "AppKey 지정")
  }
  

  func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
    let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : [];
    if JSONSerialization.isValidJSONObject(value) {
      do {
        let data = try JSONSerialization.data(withJSONObject:value, options:options);
        if let jsonString = String(data: data, encoding: String.Encoding.utf8) {
          return jsonString
        }
        
      } catch {
        print("JSON serialization failed: \(error)")
        
      }
      
    };
    return ""
    
  }

  @objc(sendScrapMessage: options:)
  func sendScrapMessage(contents:NSDictionary, options: NSDictionary) -> Void {
     // Date is ready to use!

    var param = [String: String]();
    if let content = options as? [String:String] {
      param = content
    }
    
    let title = String(describing :contents["title"]!);
    let description = String(describing :contents["description"]!);
    let imageUrl = String(describing : contents["imageUrl"]!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let mobileWebUrl = String(describing :contents["mobileWebUrl"]!);
    let webUrl = String(describing :contents["webUrl"]!);
    let buttonTitle = String(describing :contents["buttonTitle"]!);
    
    let link = Link(webUrl: URL(string: webUrl),
                    mobileWebUrl: URL(string:mobileWebUrl),
                    androidExecutionParams: param,
                    iosExecutionParams: param);
//    let appLink = Link(androidExecutionParams: param,
//                        iosExecutionParams: param)
//    let button1 = Button(title: "웹으로 보기", link: link)
//    let button2 = Button(title: "앱으로 보기", link: appLink)

//    let social = Social(likeCount: 286,
//                        commentCount: 45,
//                        sharedCount: 845)
    
    let content = Content(title: title,
                          imageUrl:URL(string:imageUrl)!,
                            description: description,
                            link: link)
//    let feedTemplate = FeedTemplate(content: content, social: social, buttons: [button1, button2])
    let feedTemplate = FeedTemplate(content: content,buttonTitle: buttonTitle)

    //메시지 템플릿 encode
    if let feedTemplateJsonData = (try? SdkJSONEncoder.custom.encode(feedTemplate)) {

    //생성한 메시지 템플릿 객체를 jsonObject로 변환
        if let templateJsonObject = SdkUtils.toJsonObject(feedTemplateJsonData) {
            LinkApi.shared.defaultLink(templateObject:templateJsonObject) {(linkResult, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("defaultLink(templateObject:templateJsonObject) success.")

                    //do something
                    guard let linkResult = linkResult else { return }
                    UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
                }
            }
        }
    }

    }

}
