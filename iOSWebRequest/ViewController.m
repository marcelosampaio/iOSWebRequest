//
//  ViewController.m
//  iOSWebRequest
//
//  Created by Marcelo Sampaio on 3/3/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"

// API KEY
#define API_KEY @"hv8qvmkydbcg4scman5wqjqc"

// URL CONSTANTS
#define URL_TOP_BOX @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=10&country=us&apikey="
#define URL_UPCOMING @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?page_limit=10&page=1&country=us&apikey="
#define URL_CRIEPORTAL_FILE @"http://www.crieportal.com/teste.txt"
#define URL_CRIEPORTAL_SITE @"http://www.crieportal.com"

@interface ViewController ()

@end

@implementation ViewController

@synthesize option,goButton,resulttext;
// URL Request
@synthesize data;
@synthesize tableView;
@synthesize moviesDownloaded;

#pragma mark - Initial Procedures
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.resulttext.text=@"";
    self.urlTextString.text=URL_CRIEPORTAL_SITE;
}

#pragma mark - UI Actions

- (IBAction)accessWebService:(UIButton *)sender
{
    NSLog(@"access web service with %@",self.urlTextString.text);
    
    NSURL *url=[NSURL URLWithString:self.urlTextString.text];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    int dummy=0;
    if (dummy==1)
    {
        NSLog(@"dummy!!!! it will not happen! Somente para evitar WARNING no projeto. %@",conn);
    }

    
    
}


- (IBAction)optionSelected:(UISegmentedControl *)sender
{
    if (self.option.selectedSegmentIndex==0) {
        self.urlTextString.text=URL_CRIEPORTAL_SITE;
    } else if (self.option.selectedSegmentIndex==1) {
        self.urlTextString.text=URL_CRIEPORTAL_FILE;
    } else {
        NSMutableString *url=[NSMutableString stringWithFormat:@"%@",URL_TOP_BOX];
        [url appendFormat:@"%@",API_KEY];
        self.urlTextString.text=url;
    }
}

#pragma mark - URL Request And Connection
// Step 1 - Initializing and getting ready to receive data
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data=[[NSMutableData alloc] init];
}

// Step 2 - Get the downloaded bits
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [self.data appendData:theData];
}

// Step 3 - Finished loading data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *e = nil;
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
    
    if (!dic1) {
        return;
    }
    NSDictionary *movies=[dic1 objectForKey:@"movies"];
    // looping internal dictionaries
    self.moviesDownloaded=[[NSMutableArray alloc]init];
    for(NSDictionary *elements in movies)
    {
        // Create object's array (containing movies)
        NSString *movieId=[NSString stringWithFormat:@"%@",[elements objectForKey:@"id"]];
        NSString *movieTitle=[NSString stringWithFormat:@"%@",[elements objectForKey:@"title"]];
        NSString *movieYear=[NSString stringWithFormat:@"%@",[elements objectForKey:@"year"]];
        NSString *movieSynopsis=[NSString stringWithFormat:@"%@",[elements objectForKey:@"synopsis"]];
        NSString *movieCriticsConsensus=[NSString stringWithFormat:@"%@",[elements objectForKey:@"critics_consensus"]];
        NSDictionary *moviePosters=[elements objectForKey:@"posters"];
        NSDictionary *movieReleaseDates=[elements objectForKey:@"release_dates"];
        NSDictionary *movieRatings=[elements objectForKey:@"ratings"];
        NSDictionary *movieCast=[elements objectForKey:@"abridged_cast"];
        
        [self.moviesDownloaded addObject:[[Movie alloc]initWithMovieId:movieId movieTitle:movieTitle movieYear:movieYear movieSynopsis:movieSynopsis movieCriticsConsensus:movieCriticsConsensus moviePosters:moviePosters movieReleaseDates:movieReleaseDates movieRatings:movieRatings movieCast:movieCast]];
        
    }
    [self.tableView reloadData];
    
}


#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.moviesDownloaded count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Movie *movie=[self.moviesDownloaded objectAtIndex:indexPath.row];
    
    cell.textLabel.text=movie.title;
    NSString *poster=[movie.posters objectForKey:@"original"];
    
    NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:poster]];
    
    cell.imageView.image=[UIImage imageWithData:data2];

    
    
    return cell;
}

//
//// Passing nycTableViewController parameter
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        self.nycSubTableViewController.detailItem = [self.nycSource objectAtIndex:indexPath.row];
//    }
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail2"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        [[segue destinationViewController] setDetailItem:[self.nycSource objectAtIndex:indexPath.row]];
//        
//    }
//}
//
//






/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */





#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
