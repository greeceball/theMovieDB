//
//  CHMovieController.h
//  theMovieDBObjC
//
//  Created by Colby Harris on 3/27/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CHMovie;

@interface CHMovieController : NSObject

+(void)fetchMovie:(NSString *)searchTerm completion:(void(^)(CHMovie * _Nullable))completion;

+(void)fetchPoster:(CHMovie *)movie completion:(void(^)(UIImage * _Nullable))completion;


@end

NS_ASSUME_NONNULL_END
