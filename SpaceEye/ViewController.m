//  ViewController.m
//  SpaceEye
//
//  Created by mac on 12/26/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize PauseResumeIsACTIVE = PauseResumeIsACTIVE;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting a space-like background to create a space theme
    
    self.view.backgroundColor = [UIColor blackColor];
    
    FLAnimatedImageView *background = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"stars2-2.gif" ofType:nil]];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:fileURL]];
    
    background.animatedImage = image;
    [self.view addSubview:background];
    
    //creating the planets and other objects as buttons
    sun = [[SunView alloc] initWithFrame:CGRectMake(0, 0, 25, 22)];
    sun.center = CGPointMake(self.view.frame.size.width/2-10, self.view.frame.size.height/2+5);
    [self.view addSubview:sun];
    
    
    //Mercurry's Orbit:
    mercurry = [[MercurryView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    mercurry.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:mercurry];
    [self PlanetRotation:mercurry speed:0.241];
    mercurry.layer.anchorPoint = CGPointMake(4,1);
    
    //Venus's Orbit:a
    venus = [[VenusView alloc] initWithFrame:CGRectMake(0, 0, 20, 12)];
    venus.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:venus];
    [self PlanetRotation:venus speed:0.615];
    venus.layer.anchorPoint = CGPointMake(0.5, -5);// changing the posisition and distance of the planets in orbit around the sun
    
    
    //Earth's Orbit:
    earth = [[EarthandMoonView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    earth.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:earth];
    [self PlanetRotation:earth speed:1];
    earth.layer.anchorPoint = CGPointMake(7, -0.5);// changing the posisition and distance of the planets in orbit around the sun
    
    
    //Mars's Orbit:
    mars = [[MarsView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    mars.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:mars];
    [self PlanetRotation:mars speed:1.880];
    mars.layer.anchorPoint = CGPointMake(2.5, -13); // changing the posisition and distance of the planets in orbit around the sun
    
    
    //Jupiter's Orbit:
    jupiter = [[JupiterView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    jupiter.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:jupiter];
    [self PlanetRotation:jupiter speed:1.867];
    jupiter.layer.anchorPoint = CGPointMake(4, -19);// changing the posisition and distance of the planets in orbit around the sun
    
    
    //Saturn's Orbit:
    saturn = [[SaturnView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    saturn.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:saturn];
    [self PlanetRotation:saturn speed:29.461];
    saturn.layer.anchorPoint = CGPointMake(-20, -3);// changing the posisition and distance of the planets in orbit around the sun
    
    
    //Uranus Orbit:
    uranus = [[UranusView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    uranus.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:uranus];
    [self PlanetRotation:uranus speed:84.030];
    uranus.layer.anchorPoint = CGPointMake(24,15);// changing the posisition and distance of the planets in orbit around the sun
    
    //Neptune's Orbit:
    neptune = [[NeptuneView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    neptune.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:neptune];
    [self PlanetRotation:neptune speed:164.815];
    neptune.layer.anchorPoint = CGPointMake(-5, 26);// changing the posisition and distance of the planets in orbit around the sun
    
    
    //Pluto's Orbit:
    pluto = [[PlutoView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    pluto.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview: pluto];
    pluto.layer.anchorPoint = CGPointMake(0.5, 28);// changing the posisition and distance of the planets in orbit around the sun
    
    //PAUSE - RESUME BUTTON!!
    PauseRes = [UIButton buttonWithType:UIButtonTypeCustom];
    [PauseRes addTarget:self action:@selector(PauseResumeAnimation) forControlEvents:UIControlEventTouchUpInside];
    [PauseRes setTitle:@"Pause/Resume" forState:UIControlStateNormal];
    PauseRes.frame = CGRectMake(480, 5.5, 150, 20);
    [self.view addSubview:PauseRes];

    
    //PREDICT BUTTON!!
    Predict = [UIButton buttonWithType:UIButtonTypeCustom];
    [Predict addTarget:self action:@selector(PredictPosition) forControlEvents:UIControlEventTouchUpInside];
    [Predict setTitle:@"PREDICT" forState:UIControlStateNormal];
    Predict.frame = CGRectMake(630, 5.5, 100, 20);
    [self.view addSubview:Predict];
    

    
    [sun addTarget:self action:@selector(objectPressed:) forControlEvents:UIControlEventTouchUpInside];
    }

-(void)objectPressed:(UIButton *)Sender
{
        NSLog(@"this is the sun");
    
}


-(void)PlanetRotation:(UIView*)planet speed:(float)period
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 /* full rotation*/ * 1/period * 1 ];//multiply more to add speed
    rotationAnimation.duration = 15;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount =  HUGE_VALF;
    //rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [planet.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)PauseResumeAnimation
{
    if (PauseResumeIsACTIVE)
    {
        self.PauseResumeIsACTIVE = !self.PauseResumeIsACTIVE;
        
        CALayer *clayer = self.view.layer;
        CFTimeInterval pausedTime = [clayer convertTime:CACurrentMediaTime() fromLayer:nil];
        clayer.speed = 0.0;
        clayer.timeOffset = pausedTime;
    }
    else
    {
        self.PauseResumeIsACTIVE = !self.PauseResumeIsACTIVE;
        CALayer *clayer = self.view.layer;
        if(clayer.timeOffset != 0) {
            CFTimeInterval paused_time = [clayer timeOffset];
            clayer.speed = 1.0f;
            clayer.timeOffset = 0.0f;
            clayer.beginTime = 0.0f;
            CFTimeInterval time_since_pause = [clayer convertTime:CACurrentMediaTime() fromLayer:nil] - paused_time;
            clayer.beginTime = time_since_pause;
        }

    }
   
}

-(void)PredictPosition
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
