//
//  UIImage+NSData.m
//  TCSMBiOS
//
//  Created by Ivankov Alexey on 10.09.15.
//  Copyright (c) 2015 “Tinkoff Credit Systems” Bank (closed joint-stock company). All rights reserved.
//

#import "UIImage+NSData.h"

@implementation UIImage (NSData)

- (NSData *)data
{
	NSData *data = nil;
	
	data = UIImageJPEGRepresentation(self, 1);
	
	if (data == nil)
	{
		data = UIImagePNGRepresentation(self);
	}
	
	return data;
}

@end
