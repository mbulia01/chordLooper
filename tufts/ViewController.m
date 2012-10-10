//
//  ViewController.m
//  tufts
//
//  Created by Chris Beltis on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize currentTitle;
@synthesize playing;

-(IBAction)chooseChord:(id)sender
{   
    currentButton = sender;
    currentButton.titleLabel.font = [UIFont systemFontOfSize:36];
    NSInteger pickerIndex = [pickerView selectedRowInComponent:0];
    NSString *title = [chords objectAtIndex:pickerIndex];
    [sender setTitle:title forState:UIControlStateNormal&UIControlStateHighlighted&UIControlStateSelected];
    [audioQueue removeObjectAtIndex:currentButton.tag];
    [audioQueue insertObject:title atIndex:currentButton.tag];
}

-(IBAction)playOrPause:(id)sender
{   
    if (isPlaying) {
        [sender setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [audioPlayer stop];
        isPlaying = false;
    }
    else if ([audioQueue objectAtIndex:0] != @"") {
        [sender setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [self play];
    }
}

-(void)play
{
    while ([audioQueue objectAtIndex:index] == @"") {
        index++;
        if (index > 7)
        {
            index = 0;
        }
    }
    //button = (UIButton*)[self.view viewWithTag:index];
    //[self changeColor:button :[UIImage imageNamed:@"atbnss0354.gif"]];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], [audioQueue objectAtIndex:index]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer setDelegate:self];
    [audioPlayer play];
    isPlaying = true;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    index++;
    if (index > 7)
    {
        index = 0;
    }
    isPlaying = false;
    [self play];
}

-(void)changeColor:(UIButton*)button:(UIImage*)image
{
    [button setImage:image forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    chords = [[NSMutableArray alloc] init];
    chordsInitArray = [[NSArray alloc] init];
	chordsInitArray = [NSArray arrayWithObjects: @"A",@"Am",@"A#",@"A#m",@"B",@"Bm",@"C",@"Cm",@"C#",@"C#m",@"D",@"Dm",@"D#",@"D#m",@"E",@"Em",@"F",@"Fm",@"F#",@"F#m",@"G",@"Gm",@"G#",@"G#m",nil];
    [chords addObjectsFromArray:chordsInitArray];
    
    audioQueue = [[NSMutableArray alloc] initWithCapacity:8];
    audioQueueInit = [[NSArray alloc] init];
    audioQueueInit = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",nil];
    [audioQueue addObjectsFromArray:audioQueueInit];
    
    [pickerView selectRow:1 inComponent:0 animated:NO];
    
    index = 0;
    isPlaying = false;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	return [chords count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	return [chords objectAtIndex:row];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
