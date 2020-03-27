//
//  CHMovieController.m
//  theMovieDBObjC
//
//  Created by Colby Harris on 3/27/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

#import "CHMovieController.h"
#import "CHMovie.h"

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const basePosterURLString = @"https://image.tmdb.org/t/p/w500";
static NSString * const apiKey = @"api_key";
static NSString * const apiValue = @"fca5a8c85d8154a8d7591cf4881ab8d1";
static NSString * const searchKey = @"query";


@implementation CHMovieController

+ (void)fetchMovie:(NSString *)searchTerm completion:(void (^)(CHMovie * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    baseURL = [baseURL URLByAppendingPathComponent:apiKey];
    //baseURL = [baseURL URLByAppendingPathComponent:apiValue];
    //baseURL = [baseURL URLByAppendingPathComponent:searchKey];
    //baseURL = [baseURL URLByAppendingPathComponent:searchTerm.lowercaseString];
    
    NSURLComponents *urlComponents = [[NSURLComponents new] initWithURL:baseURL resolvingAgainstBaseURL:true];
    
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"strictMatch" value:@"false"]];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL];
    
    [request addValue:apiValue forHTTPHeaderField:@"api_key"];
    [request addValue:searchKey forHTTPHeaderField:searchTerm];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error fetching JSON Dictionary: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelObject = jsonDictionary[@"results"][0];
        
        CHMovie *movie = [[CHMovie new] initWithDictionary:topLevelObject];
        completion(movie);
        
    }] resume];
    
}

+ (void)fetchPoster:(CHMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *posterPathURL = [NSURL URLWithString:movie.posterPath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:posterPathURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        NSData *posterData = [NSData dataWithContentsOfURL:posterPathURL];
        UIImage *posterImage = [UIImage imageWithData:posterData];
        UIImageView *poster = [[UIImageView alloc] initWithImage:posterImage];
                           
        completion(poster);
    }] resume];
}



@end
