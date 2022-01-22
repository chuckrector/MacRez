#import "Cocoa/Cocoa.h"

int main(int argc, char **argv)
{
    NSLog(@"What I am trying to get:");
    NSLog(@"3072 x 1920\n\n");

    NSLog(@"What I am actually getting:");

    NSArray *screens = [NSScreen screens];
    NSScreen *mainScreen = [NSScreen mainScreen];
    for (int i = 0; i < [screens count]; ++i)
    {
        NSScreen *screen = [screens objectAtIndex: i];
        NSLog(@"Screen #%d", i);

        NSRect visibleFrame = [screen visibleFrame];
        NSLog(@"NSStringFromRect %@", NSStringFromRect(visibleFrame));
        NSLog(@"convertRectToBacking %@", NSStringFromRect([screen convertRectToBacking:visibleFrame]));

        NSDictionary *description = [screen deviceDescription];
        NSSize deviceSize = [[description objectForKey:NSDeviceSize] sizeValue];
        CGSize screenSize = CGDisplayScreenSize(
            [[description objectForKey:@"NSScreenNumber"] unsignedIntValue]);
        NSLog(@"NSDeviceSize %f x %f", deviceSize.width, deviceSize.height);
        NSLog(@"CGDisplayScreenSize %f x %f", screenSize.width, screenSize.height);
    }

    return 0;
}