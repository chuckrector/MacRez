#import "Cocoa/Cocoa.h"

int main(int argc, char **argv)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [NSApplication sharedApplication];
    NSUInteger windowStyle = NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask;
    NSRect windowRect = NSMakeRect(100, 100, 400, 400);
    NSWindow * window = [[NSWindow alloc] initWithContentRect:windowRect
                                          styleMask:windowStyle
                                          backing:NSBackingStoreBuffered
                                          defer:NO];
    [window autorelease];
    NSWindowController * windowController = [[NSWindowController alloc] initWithWindow:window];
    [windowController autorelease];
    NSTextView * textView = [[NSTextView alloc] initWithFrame:windowRect];
    [textView autorelease];
    [window setContentView:textView];
    NSArray *screenArray = [NSScreen screens];
    NSScreen *mainScreen = [NSScreen mainScreen];
    unsigned screenCount = [screenArray count];
    unsigned index  = 0;
    for (index; index < screenCount; index++)
    {
        NSScreen *screen = [screenArray objectAtIndex: index];
        NSRect screenRect = [screen visibleFrame];
        NSString *mString = ((mainScreen == screen) ? @"Main" : @"not-main");
        NSString *res = [NSString stringWithFormat:@"Screen #%d (%@) Frame: %@", index, mString, NSStringFromRect(screenRect)];
        [textView insertText:res];
    }
    [window orderFrontRegardless];
    [NSApp run];
    [pool drain];
    return 0;
}