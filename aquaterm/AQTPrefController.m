#import "AQTPrefController.h"

@implementation AQTPrefController
+ (AQTPrefController *)sharedPrefController
{
   static AQTPrefController *sharedPrefController = nil;
   if (sharedPrefController == nil) {
      sharedPrefController = [[self alloc] init];
   }   return sharedPrefController;
}

-(id)init
{
   if (self = [super init])
   {
      [NSBundle loadNibNamed:@"Preferences.nib" owner:self];
   }
   return self;
}

-(void)awakeFromNib
{
   [self showPrefs]; 
}

- (void)showPrefs {
   [imageInterpolateLevel selectItemAtIndex:[preferences integerForKey:@"ImageInterpolationLevel"]];
   [shouldAntialiasSwitch setIntValue:[preferences integerForKey:@"ShouldAntialiasDrawing"]];
   [showProcessNameSwitch setIntValue:[preferences integerForKey:@"ShowProcessName"]];
   [showProcessIdSwitch setIntValue:[preferences integerForKey:@"ShowProcessId"]];
   [self updateTitleExample:self];
   [prefWindow makeKeyAndOrderFront:self];
}

- (IBAction)updateTitleExample:(id)sender
{
   [titleExample setStringValue:[NSString stringWithFormat:@"%@%@Figure 1", [showProcessNameSwitch intValue]?@"gnuplot ":@"", [showProcessIdSwitch intValue]?@"(1151) ":@""]];
}

- (IBAction)cancelButtonPressed:(id)sender
{
   [prefWindow orderOut:self];   
}

- (IBAction)OKButtonPressed:(id)sender
{
   [preferences setInteger:[imageInterpolateLevel indexOfSelectedItem] forKey:@"ImageInterpolationLevel"];
   [preferences setInteger:[shouldAntialiasSwitch intValue] forKey:@"ShouldAntialiasDrawing"];
   [preferences setInteger:[showProcessNameSwitch intValue] forKey:@"ShowProcessName"];
   [preferences setInteger:[showProcessIdSwitch intValue] forKey:@"ShowProcessId"];
   [prefWindow orderOut:self];
}

@end