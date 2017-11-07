//
//  OBJsonParse.h
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBJsonParse : NSObject
+(id) shared;
- (NSArray *) parseAllCountriesFrom: (NSData*)jsonData;
@end
