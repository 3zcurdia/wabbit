//
//  OBChecksums.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#ifndef NSCrypto_h
#define NSCrypto_h
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSCrypto : NSObject
+(NSCrypto *) shared;
-(NSString *) sha1String: (NSString *)input;
-(NSString *) sha256String: (NSString *)input;
-(NSString *) base64String: (NSString *)input;
-(NSString *) base64Image:(UIImage *)input;
@end

#endif /* NSCrypto_h */
