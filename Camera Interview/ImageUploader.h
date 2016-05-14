//
//  ImageUploader.h
//  Camera Interview
//
//  Created by Rush on 8/27/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUploader : NSObject

+(void)uploadPhoto:(NSData *)imageData
    completionBlock:(void(^)(id data))completion;

@end
