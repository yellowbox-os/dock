#import "DockAppController.h"
#import "DockIcon.h"

@implementation DockAppController

- (instancetype)init {
    self = [super init];
    if (self) {
        _dockedIcons = [[NSMutableArray alloc] init];
        _undockedIcons = [[NSMutableArray alloc] init];
        _workspace = [NSWorkspace sharedWorkspace];  // Initialize the workspace property with the shared instance
        _iconSize = 64;
        _activeLight = 16;
        _padding = 16;
        [self setupDockWindow];
    }
    return self;
}

- (void)setupDockWindow {

    // TODO: Calculate based on state. Will hard code for now
    CGFloat totalIcons = 5;
    // Create a dock window without a title bar or standard window buttons 
    CGFloat dockWidth = (self.padding * 2 + totalIcons * self.iconSize);
    // Get the main screen (primary display)
    NSScreen *mainScreen = [NSScreen mainScreen];
    NSRect viewport = [mainScreen frame];
    CGFloat x = (viewport.size.width / 2) - (dockWidth / 2);
    NSRect frame = NSMakeRect(x, 0, dockWidth, 8 + self.activeLight + self.iconSize);  // Set size and position of the dock (x, y, w, h)
    self.dockWindow = [[NSWindow alloc] initWithContentRect:frame
                                                  styleMask:NSWindowStyleMaskBorderless
                                                    backing:NSBackingStoreBuffered
                                                      defer:NO];
    [self.dockWindow setTitle:@"Dock"];
    [self.dockWindow setLevel:NSFloatingWindowLevel];
    [self.dockWindow setOpaque:NO];
    [self.dockWindow setBackgroundColor:[NSColor clearColor]];
    
    // Set the dock window content view
    NSView *contentView = [self.dockWindow contentView];
    
    // Add default applications icons to the dock window
    [self addApplicationIcon:@"GWorkspace" withDockedStatus:YES];
    [self addApplicationIcon:@"Terminal" withDockedStatus:YES];
    [self addApplicationIcon:@"SystemPreferences" withDockedStatus:YES];
    [self addApplicationIcon:@"Ycode" withDockedStatus:YES];
    [self addApplicationIcon:@"Chess" withDockedStatus:YES];
    
    // TODO: Fetch Docked Apps from Prefs

    // TODO: Create Divider

    // TODO: Fetch Running Apps from Workspace
    
    [self.dockWindow makeKeyAndOrderFront:nil];
}

- (void)addApplicationIcon:(NSString *)appName withDockedStatus:(BOOL)isDocked {
    NSButton *appButton = [self generateIcon:appName];
    [[self.dockWindow contentView] addSubview:appButton];
    if(isDocked) {
      [self.dockedIcons addObject:appButton];
    } else {
      [self.undockedIcons addObject:appButton];
    }
}

- (void)addDivider {}
- (void)dockIcon:(NSString *)appName {}
- (void)undockIcon:(NSString *)appName {}

- (NSRect)generateLocation:(NSString *)dockPosition  {
    if([dockPosition isEqualToString:@"Left"]) {
    } else if([dockPosition isEqualToString:@"Right"]) {
    } else {
      // If unset we default to "Bottom"
      NSRect bottomLocation = NSMakeRect([self.dockedIcons count] * self.iconSize + (self.padding), self.activeLight, self.iconSize, self.iconSize);
      return bottomLocation;
      //NSMakeRect([self.appIcons count] * 60, 10, 50, 50);
    }
}

- (NSButton *)generateIcon:(NSString *)appName  {
    NSRect location = [self generateLocation:@"Bottom"];
    //NSButton *appButton = [[NSButton alloc] initWithFrame:NSMakeRect([self.dockedIcons count] * 60, 10, 50, 50)];
    NSButton *appButton = [[NSButton alloc] initWithFrame:location];
    NSImage *iconImage = [self.workspace appIconForApp:appName];
    [appButton setImage:iconImage];
    [appButton setTitle:appName];
    [appButton setBordered:NO];
    [appButton setAction:@selector(iconClicked:)];
    [appButton setTarget:self];

    return appButton;
}

- (void)iconClicked:(id)sender {
    NSButton *clickedButton = (NSButton *)sender;
    NSString *appName = [clickedButton title];
    
    if ([appName isEqualToString:@"GWorkspace"] || [appName isEqualToString:@"Trash"]) {
      NSLog(@"Launching application: %@", appName);
    } else if ([appName isEqualToString:@"Dock"]) {

    } else {
      [self.workspace launchApplication:appName];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"Dock.app launched successfully!");
}

@end

