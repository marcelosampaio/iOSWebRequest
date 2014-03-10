//
//  Movie.h
//  iOSWebRequest
//
//  Created by Marcelo Sampaio on 3/10/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(strong,nonatomic) NSString *movieId;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *year;
@property(strong,nonatomic) NSString *synopsis;
@property(strong,nonatomic) NSString *criticsConsensus;
@property(strong,nonatomic) NSDictionary *posters;
@property(strong,nonatomic) NSDictionary *releaseDates;
@property(strong,nonatomic) NSDictionary *ratings;
@property(strong,nonatomic) NSDictionary *cast;



-(id)initWithMovieId:(NSString *)mId movieTitle:(NSString *)mTitle movieYear:(NSString *)mYear movieSynopsis:(NSString *)mSynopsis movieCriticsConsensus:(NSString *)mCriticsConsensus moviePosters:(NSDictionary *)mPosters movieReleaseDates:(NSDictionary *)mReleaseDates movieRatings:(NSDictionary *)mRatings movieCast:(NSDictionary *)mCast;



@end
