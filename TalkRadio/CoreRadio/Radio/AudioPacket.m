//
//  AudioPacket.m
//  Radio
//
//  Copyright 2011 Yakamoz Labs. All rights reserved.
//

#import "AudioPacket.h"

@implementation AudioPacket

@synthesize data = _data;
@synthesize audioDescription = _audioDescription;

- (id)initWithData:(NSData *)data {
    self = [super init];
    if(self) {
        _data = [data retain];
        _consumedLength = 0;
    }
    
    return self;
}

- (void)dealloc {
    [_data release];
    
    [super dealloc];
}

- (NSUInteger)length {
    return [_data length];
}

- (NSUInteger)remainingLength {
    return ([_data length] - _consumedLength);
}

- (void)copyToBuffer:(void *const)buffer size:(int)size {
    int dataSize = size;
    if((_consumedLength + dataSize) > [self length]) {
        dataSize = (int)([self length] - _consumedLength);
    }
    
    memcpy(buffer, ([_data bytes] + _consumedLength), dataSize);
    _consumedLength += dataSize;
}

@end
