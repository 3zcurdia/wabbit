//
//  NSCountry.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/7/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCountry : NSObject
@property(nonatomic) NSString* iso;
@property(nonatomic) NSString* name;
@property(nonatomic) NSArray* languages;
- (instancetype)initWithISO: (NSString*)iso name: (NSString*)name languanges: (NSArray*)langs;
@end
