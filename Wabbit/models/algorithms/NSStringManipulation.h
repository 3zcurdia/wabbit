//
//  NSStringManipulation.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/15/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringManipulation : NSObject
+(NSStringManipulation *) shared;
- (NSString *) textWithNumbersFor: (NSString*)str;
- (NSArray<NSString *> *) matchesFor: (NSString *)regex in: (NSString *)str;
- (NSString *) appendString: (NSString *)orig to: (NSString *)str;
@end
