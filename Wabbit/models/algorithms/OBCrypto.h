//
//  OBChecksums.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#ifndef OBCrypto_h
#define OBCrypto_h
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OBCrypto : NSObject
+(id) shared;
-(NSString *) sha1String: (NSString *)input;
-(NSString *) sha256String: (NSString *)input;
-(NSString *) base64String: (NSString *)input;
-(NSString *) base64Image:(UIImage *)input;
@end

#endif /* OBCrypto_h */
