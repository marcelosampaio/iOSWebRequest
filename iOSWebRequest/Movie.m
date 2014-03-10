//
//  Movie.m
//  iOSWebRequest
//
//  Created by Marcelo Sampaio on 3/10/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "Movie.h"

@implementation Movie

@synthesize criticsConsensus,movieId,synopsis,title,year,posters,releaseDates,ratings,cast;

-(id)initWithMovieId:(NSString *)mId movieTitle:(NSString *)mTitle movieYear:(NSString *)mYear movieSynopsis:(NSString *)mSynopsis movieCriticsConsensus:(NSString *)mCriticsConsensus moviePosters:(NSDictionary *)mPosters movieReleaseDates:(NSDictionary *)mReleaseDates movieRatings:(NSDictionary *)mRatings movieCast:(NSDictionary *)mCast
{
    self=[super init];
    if (self) {
        movieId=mId;
        title=mTitle;
        year=mYear;
        synopsis=mSynopsis;
        criticsConsensus=mCriticsConsensus;
        posters=mPosters;
        releaseDates=mReleaseDates;
        ratings=mRatings;
        cast=mCast;
    }
    return self;
}
@end