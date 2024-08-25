#import "DockAppController.h"

@implementation DockAppController

- (instancetype)init {
    self = [super init];
    if (self) {
        _appIcons = [[NSMutableArray alloc] init];
        _workspace = [NSWorkspace sharedWorkspace];  // Initialize the workspace property with the shared instance
        [self setupDockWindow];
    }
    return self;
}

- (void)setupDockWindow {
    // Create a dock window without a title bar or standard window buttons
    NSRect frame = NSMakeRect(0, 0, 400, 100);  // Set size and position of the dock
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
    
    // Add application icons to the dock window
    // TODO: Make this based on saved state
    [self addApplicationIcon:@"GWorkspace" /*withIcon:[NSImage imageNamed:@"NSNetwork"]*/];
    [self addApplicationIcon:@"Terminal" /*withIcon:[NSImage imageNamed:@"NSApplicationIcon"]*/];
    [self addApplicationIcon:@"SystemPreferences" /*withIcon:[NSImage imageNamed:@"NSApplicationIcon"]*/];
    
    [self.dockWindow makeKeyAndOrderFront:nil];
}

- (void)addApplicationIcon:(NSString *)appName /*withIcon:(NSImage *)iconImage*/ {
    NSButton *appButton = [[NSButton alloc] initWithFrame:NSMakeRect([self.appIcons count] * 60, 10, 50, 50)];
    NSImage *iconImage = [self.workspace appIconForApp:appName];
    [appButton setImage:iconImage];
    [appButton setTitle:appName];
    [appButton setBordered:NO];
    [appButton setAction:@selector(iconClicked:)];
    [appButton setTarget:self];
    
    [[self.dockWindow contentView] addSubview:appButton];
    [self.appIcons addObject:appButton];
}

- (void)iconClicked:(id)sender {
    NSButton *clickedButton = (NSButton *)sender;
    NSString *appName = [clickedButton title];
    
    if ([appName isEqualToString:@"GWorkspace"] || [appName isEqualToString:@"Trash"]) {
      NSLog(@"Launching application: %@", appName);
    } else {
      [self.workspace launchApplication:appName];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"Dock.app launched successfully!");
}

@end

