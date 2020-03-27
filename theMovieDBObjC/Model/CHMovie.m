//
//  CHMovie.m
//  theMovieDBObjC
//
//  Created by Colby Harris on 3/27/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

#import "CHMovie.h"

@implementation CHMovie

- (instancetype)initWithTitle:(NSString *)title rating:(double)rating shortDescription:(NSString *)shortDescription posterPath:(NSString *)posterPath
{
    self = [super init];
    
    if (self){
        _title = title;
        _rating = rating;
        _shortDescription = shortDescription;
        _posterPath = posterPath;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"original_title"];
    NSString *tempRating = dictionary[@"vote_average"];
    NSString *shortDescription = dictionary[@"overview"];
    NSString *posterPath = dictionary[@"poster_path"];
    
    double rating = [tempRating doubleValue];
    
    return [self initWithTitle:title rating:rating shortDescription:shortDescription posterPath:posterPath];
}
@end
