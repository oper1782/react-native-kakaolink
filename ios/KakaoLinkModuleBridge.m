//
//  KakaoLinkModuleBridge.m
//  Mom
//
//  Created by 양수민 on 2021/01/11.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(KakaoLinkModule, NSObject)

RCT_EXTERN_METHOD(sendScrapMessage:(NSDictionary *)contents options:(NSDictionary *)options)
RCT_EXTERN_METHOD(initKakao)

@end
