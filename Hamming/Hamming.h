//
//  Hamming.h
//  Hamming
//
//  Created by Hugo Bastien on 2014-03-27.
//  Copyright (c) 2014 Hugo Bastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hamming : NSObject

+ (NSUInteger)compute:(NSString *)aFragment against:(NSString *)anotherFragment;

@end
