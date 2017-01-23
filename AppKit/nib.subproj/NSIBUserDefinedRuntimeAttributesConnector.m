//
//  NSIBUserDefinedRuntimeAttributesConnector.m
//  AppKit
//
//  Created by Airy ANDRE on 22/01/2017.
//
//

#import "NSIBUserDefinedRuntimeAttributesConnector.h"

@implementation NSIBUserDefinedRuntimeAttributesConnector
-(void)encodeWithCoder:(NSCoder *)coder {
    NSUnimplementedMethod();
}

-initWithCoder:(NSCoder *)coder
{
    if([coder allowsKeyedCoding]) {
        self = [super initWithCoder: coder];
        NSKeyedUnarchiver *keyed=(NSKeyedUnarchiver *)coder;
        
        keyPaths=[[keyed decodeObjectForKey:@"NSKeyPaths"] retain];
        values=[[keyed decodeObjectForKey:@"NSValues"] retain];
        object=[[keyed decodeObjectForKey:@"NSObject"] retain];
    }
    else {
        [NSException raise:NSInvalidArgumentException format:@"-[%@ %s] is not implemented for coder %@",isa,sel_getName(_cmd),coder];
    }
    return self;
}

-(void)dealloc
{
    [keyPaths release];
    [values release];
    [object release];
    [super dealloc];
}

- (void)instantiateWithObjectInstantiator:(id)inst
{
    
}

- (void)setObject:(id)obj
{
    obj=[obj retain];
    [object release];
    object=obj;
}

- (id)object
{
    return object;
}

- (void)setValues:(id)obj
{
    obj=[obj retain];
    [values release];
    values=obj;
}

- (id)values
{
    return values;
}

- (void)setKeyPaths:(id)obj
{
    obj=[obj retain];
    [keyPaths release];
    keyPaths=obj;
}

- (id)keyPaths
{
    return keyPaths;
}

-(void)replaceObject:original withObject:replacement
{
    if(original==keyPaths) {
        [self setKeyPaths:replacement];
    } else if(original==object) {
        [self setObject:replacement];
    } else if(original==values) {
        [self setValues:replacement];
    } else {
        [super replaceObject: original withObject: replacement];
    }
    
}

-(void)establishConnection
{
    NSUInteger count = [keyPaths count];
    for (NSUInteger i = 0; i < count; ++i) {
        id keyPath = [keyPaths objectAtIndex:i];
        id value = [values objectAtIndex:i];
        [object setValue:value forKeyPath:keyPath];
    }
}

@end
