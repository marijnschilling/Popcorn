//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoader : NSObject
    - (void)fetchDataFor:(NSURLRequest *)request withSuccess:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSError *error))failure;

@end