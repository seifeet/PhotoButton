//
//  PBImageHelper.h
//
//  Created by AT on 6/17/12.
//

#import <Foundation/Foundation.h>

@interface PBImageHelper : NSObject

+ (BOOL)saveImageToDocuments: (UIImage *) image withName:(const NSString *) name;
+ (UIImage *)loadImageFromDocuments: (const NSString *) name;
+ (BOOL)deleteFileFromDocuments: (const NSString *) name;
    
@end
