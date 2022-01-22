/*
https://gist.github.com/bellbind/27220148ea752335259dfce63f43bd5d
https://stackoverflow.com/questions/53595111/how-to-get-the-physical-display-resolution-on-macos
*/

#include <stdio.h>
#include <CoreGraphics/CGDisplayConfiguration.h>

typedef struct
{
    uint32_t ModeNumber;
    uint32_t Flags;
    uint32_t Width;
    uint32_t Height;
    uint32_t Depth;
    uint8_t Unknown[170];
    uint16_t Frequency;
    uint8_t MoreUnknown[16];
    float Density;
} display_mode;

void CGSGetCurrentDisplayMode(CGDirectDisplayID DirectDisplayId, int *ModeIndex);
void CGSGetNumberOfDisplayModes(CGDirectDisplayID DirectDisplayId, int *ModeCount);
void CGSGetDisplayModeDescriptionOfLength(CGDirectDisplayID DirectDisplayId, int Index, display_mode *Mode, int Length);

int
main(int ArgCount, char **Args)
{
    CGDirectDisplayID DirectDisplayId = CGMainDisplayID();

    int CurrentModeIndex;
    CGSGetCurrentDisplayMode(DirectDisplayId, &CurrentModeIndex);

    display_mode Mode;
    CGSGetDisplayModeDescriptionOfLength(DirectDisplayId, CurrentModeIndex, &Mode, sizeof(Mode));
    printf("%5d x %-5d (current)\n", Mode.Width, Mode.Height);

    int ModeCount;
    CGSGetNumberOfDisplayModes(DirectDisplayId, &ModeCount);

    int MaxNativePixelWidth = 0;
    int MaxNativePixelHeight = 0;
    int NativeModeIndex = -1;

    for(int ModeIndex = 0;
        ModeIndex < ModeCount;
        ++ModeIndex)
    {
        CGSGetDisplayModeDescriptionOfLength(DirectDisplayId, ModeIndex, &Mode, sizeof(Mode));
        if(Mode.Flags & 0x02000000)
        {
            if((Mode.Width > MaxNativePixelWidth) || (Mode.Height > MaxNativePixelHeight))
            {
                MaxNativePixelWidth = Mode.Width;
                MaxNativePixelHeight = Mode.Height;
                NativeModeIndex = ModeIndex;
            }
        }
    }

    if(NativeModeIndex >= 0)
    {
        printf("%5d x %-5d (native)\n", MaxNativePixelWidth, MaxNativePixelHeight);
    }
    else
    {
        printf("The native resolution could not be found.\n");
    }

    return 0;
}