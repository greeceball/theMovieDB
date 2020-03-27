//
//  CHMovie.h
//  theMovieDBObjC
//
//  Created by Colby Harris on 3/27/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHMovie : NSObject

@property(nonatomic, copy, readonly)NSString *title;
@property(nonatomic, readonly)double rating;
@property(nonatomic, copy, readonly)NSString *shortDescription;
@property(nonatomic, copy, nullable)NSString *posterPath;

-(instancetype)initWithTitle:(NSString *)title rating:(double)rating shortDescription:(NSString *)shortDescription posterPath:(NSString *)posterPath;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
