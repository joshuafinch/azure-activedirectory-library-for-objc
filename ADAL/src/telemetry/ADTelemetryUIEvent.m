// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ADTelemetryUIEvent.h"
#import "ADTelemetryEventStrings.h"

@implementation ADTelemetryUIEvent

- (void)setLoginHint:(NSString*)hint
{
    [self setProperty:TELEMETRY_LOGIN_HINT value:[hint adComputeSHA256]];
}

- (void)processEvent:(NSMutableDictionary*)eventToBeDispatched
{
    [super processEvent:eventToBeDispatched];
    
    (void)eventToBeDispatched;
    NSArray* properties = [self getProperties];
    for (NSArray* property in properties)
    {
        if ([property[0] isEqualToString:TELEMETRY_LOGIN_HINT])
        {
            [eventToBeDispatched setObject:property[1] forKey:property[0]];
        }
    }
    
    int UIEventCount = 1;
    if ([eventToBeDispatched objectForKey:TELEMETRY_UI_EVENT_COUNT])
    {
        UIEventCount = [[eventToBeDispatched objectForKey:TELEMETRY_UI_EVENT_COUNT] intValue] + 1;
    }
    [eventToBeDispatched setObject:[NSString stringWithFormat:@"%d", UIEventCount] forKey:TELEMETRY_UI_EVENT_COUNT];
}

@end