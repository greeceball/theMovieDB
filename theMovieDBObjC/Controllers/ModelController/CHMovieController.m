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

+ (void)fetchMovies:(NSString *)searchTerm completion:(void (^)(NSArray<CHMovie *> *_Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *urlComponents = [[NSURLComponents new] initWithURL:baseURL resolvingAgainstBaseURL:true];
    
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:apiKey value:apiValue], [NSURLQueryItem queryItemWithName:searchKey value:searchTerm]];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL];
    
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
        
        NSArray<NSDictionary *> *movieDict = jsonDictionary[@"results"];
        NSMutableArray *arrayToReturn = [[NSMutableArray alloc] init];
        
        for(NSDictionary *currentDict in movieDict){
            CHMovie *movie = [[CHMovie alloc] initWithDictionary:currentDict];
            [arrayToReturn addObject:movie];
        }
        completion(arrayToReturn);
    }] resume];
}

+ (void)fetchPoster:(CHMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *basePosterURL = [NSURL URLWithString:basePosterURLString];
    basePosterURL = [basePosterURL URLByAppendingPathComponent:movie.posterPath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:basePosterURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
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
        
        UIImage *poster = [[UIImage alloc] initWithData:data];
        
        completion(poster);
    }] resume];
}



@end
