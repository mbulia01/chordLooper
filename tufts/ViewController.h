//
//  ViewController.h
//  tufts
//
//  Created by Max Bulian on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, AVAudioPlayerDelegate>
{
    NSMutableArray *chords; //contains chords that can be chosen
    NSMutableArray *audioQueue; //contains chords that will be played in order
    NSMutableArray *buttons;
    NSArray *chordsInitArray;
    NSArray *audioQueueInit;
    IBOutlet UIPickerView *pickerView;
    IBOutlet UIButton *currentButton;
    AVAudioPlayer *audioPlayer;
    NSUInteger index;
    UIButton *button;
    bool isPlaying;
}

@property (nonatomic, readonly, retain) NSString *currentTitle;
@property(readonly, getter=isPlaying) BOOL playing;

-(IBAction)chooseChord:(id)sender;
-(IBAction)playOrPause:(id)sender;


@end
