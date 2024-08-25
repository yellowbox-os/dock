#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "DockIcon.h"

@implementation DockIcon

- (instancetype)initWithImage:(NSImage *)iconImage {
    self = [super init];
    if (self) {
        _iconImage = iconImage;
        _showLabel = YES; // Change this to NO 
        [self setupDockIcon];
    }
    return self;
}

// @property (strong) NSImage *iconImage;
// @property (strong) BOOL *showLabel;
// @property (strong) NSWorkspace *workspace;

- (void)setupDockIcon {
  // Do Stuff
};

- (void)setLabelVisibility:(BOOL *)isVisible {
  self.showLabel = isVisible;
}

@end

