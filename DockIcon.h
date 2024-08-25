#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface DockIcon : NSObject 

@property (strong) NSImage *iconImage;
@property  BOOL *showLabel;
@property (strong) NSWorkspace *workspace;

- (void)setupDockIcon;

- (void)setLabelVisibility:(BOOL *)isVisible;

@end

