#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface DockAppController : NSObject <NSApplicationDelegate>

@property (strong) NSWindow *dockWindow;
@property (strong) NSMutableArray *appIcons;

- (void)setupDockWindow;
- (void)addApplicationIcon:(NSString *)appName withIcon:(NSImage *)iconImage;
- (void)iconClicked:(id)sender;

@end

