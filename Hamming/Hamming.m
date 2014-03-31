//
//  Hamming.m
//  Hamming
//
//  Created by Hugo Bastien on 2014-03-27.
//  Copyright (c) 2014 Hugo Bastien. All rights reserved.
//

#import "Hamming.h"

@interface Hamming ()

@property (nonatomic, strong) NSString *aFragment;
@property (nonatomic, strong) NSString *anotherFragment;

@end

@implementation Hamming

+ (NSUInteger)compute:(NSString *)aFragment against:(NSString *)anotherFragment {
    Hamming *hamming = [[self alloc] initWithFragment:aFragment andAnotherFragment:anotherFragment];
    return [hamming distance];
}

- (instancetype)initWithFragment:(NSString *)aFragment andAnotherFragment:(NSString *)anotherFragment {
    self = [super init];
    
    if (self) {
        self.aFragment = aFragment;
        self.anotherFragment = anotherFragment;
    }
    
    return self;
}

- (NSUInteger)distance {
    return [self countOfMutations];
}

- (NSUInteger)countOfMutations {
    NSUInteger mutations = 0;
    for (NSUInteger i = 0; i < [self shortestFragment]; i++) {
        if ([self mutationAtPosition:i]) {
            mutations++;
        }
    }
    return mutations;
}

- (BOOL)mutationAtPosition:(NSUInteger)position {
    return [self.aFragment characterAtIndex:position] !=
            [self.anotherFragment characterAtIndex:position];
}

- (NSUInteger)shortestFragment {
    return MIN([self.aFragment length], [self.anotherFragment length]);
}

@end
