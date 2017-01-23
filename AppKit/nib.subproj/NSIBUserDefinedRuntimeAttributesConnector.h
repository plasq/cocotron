//
//  NSIBUserDefinedRuntimeAttributesConnector.h
//  AppKit
//
//  Created by Airy ANDRE on 22/01/2017.
//
//

#import <Foundation/Foundation.h>
#import <AppKit/NSRaise.h>
#import <AppKit/NSNibConnector.h>

@interface NSIBUserDefinedRuntimeAttributesConnector : NSNibConnector
{
    NSArray *keyPaths;
    NSArray *values;
    id object;
}

- (void)instantiateWithObjectInstantiator:(id)inst;
- (void)setObject:(id)object;
- (id)object;
- (void)setValues:(id)values;
- (id)values;
- (void)setKeyPaths:(id)keyPaths;
- (id)keyPaths;

@end
