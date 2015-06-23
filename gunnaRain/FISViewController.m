//
//  FISViewController.m
//  gunnaRain
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"
#import <Forecastr.h>

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;


@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    Forecastr *forecastClient = [Forecastr sharedManager];
    forecastClient.apiKey = @"738a9332915dd0d25b3ea15f5ba877d6";
    
    
    // Portland: 45.200 | 122.6819
    // Mumbai: 18.9750 | 72.8258
    
    // NSLog(@"Getting the weather now");
    [forecastClient getForecastForLatitude:18.9750 longitude:72.8258 time:nil exclusions:nil extend:nil success:^(id JSON) {
        // NSLog(@"Got the weather!");
        if ([JSON[@"currently"][@"precipProbability"] integerValue] == 1){
            
            self.weatherLabel.text = @"Yep";
            self.weatherLabel.textColor = [UIColor redColor];
        }
        else if ([JSON[@"currently"][@"precipProbability"] integerValue] == .5){
            self.weatherLabel.text = @"It might rain";
            self.weatherLabel.textColor = [UIColor blackColor];
        }
        else {
            NSLog(@"%@", JSON[@"currently"][@"precipProbability"]);
            self.weatherLabel.text = @"Nope";
            self.weatherLabel.textColor = [UIColor greenColor];
        }
        
    } failure:^(NSError *error, id response) {
        NSLog(@"There was an issue getting the forecast");
    }];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
