//
//  BUIView.m
//  sample
//
//  Created by 张玺 on 12-9-10.
//  Copyright (c) 2012年 张玺. All rights reserved.
//

#import "BUIView.h"
#import <objc/runtime.h>
@implementation UIView(BUIView)


const char oldDelegateKey;
const char completionHandlerKey;

#pragma -mark UIAlerView

-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIAlertView *alert = (UIAlertView *)self;
    if(completionHandler != nil)
    {
        objc_setAssociatedObject(self, &oldDelegateKey, alert.delegate, OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, &completionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
        alert.delegate = self;
    }
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert = (UIAlertView *)self;
    void (^theCompletionHandler)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &completionHandlerKey);
    
    if(theCompletionHandler == nil)
        return;
    
    theCompletionHandler(buttonIndex);
    alert.delegate = objc_getAssociatedObject(self, &oldDelegateKey);
}


#pragma -mark UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^theCompletionHandler)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &completionHandlerKey);
    
    if(theCompletionHandler == nil)
        return;
    
    theCompletionHandler(buttonIndex);
    UIActionSheet *sheet = (UIActionSheet *)self;
    
    sheet.delegate = objc_getAssociatedObject(self, &oldDelegateKey);
}


-(void)config:(void(^)(NSInteger buttonIndex))completionHandler
{
    if(completionHandler != nil)
    {
        
        id oldDelegate = objc_getAssociatedObject(self, &oldDelegateKey);
        if(oldDelegate == nil)
        {
            objc_setAssociatedObject(self, &oldDelegateKey, oldDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
        
        UIActionSheet *sheet = (UIActionSheet *)self;
        oldDelegate = sheet.delegate;
        sheet.delegate = self;
        objc_setAssociatedObject(self, &completionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
    }
}
-(void)showInView:(UIView *)view
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showInView:view];
}

-(void)showFromToolbar:(UIToolbar *)view
 withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromToolbar:view];
}

-(void)showFromTabBar:(UITabBar *)view
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromTabBar:view];
}

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromRect:rect inView:view animated:animated];
}

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromBarButtonItem:item animated:animated];
}

@end


@implementation UIImagePickerController(YSBlock)
@dynamic photoPickedBlock,cancelBlock;
const char photoPickedBlockKey;
const char cancelBlockKey;

- (void)setPhotoPickedBlock:(YSPhotoPickedBlock)photoPickedBlock
{
    objc_setAssociatedObject(self, &photoPickedBlockKey, photoPickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (YSPhotoPickedBlock)photoPickedBlock
{
    return objc_getAssociatedObject(self, &photoPickedBlockKey);
}

- (void)setCancelBlock:(YSCancelBlock)cancelBlock
{
    objc_setAssociatedObject(self, &cancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (YSCancelBlock)cancelBlock
{
    return objc_getAssociatedObject(self, &cancelBlockKey);
}

+ (void)photoPickerSelectTypeAndShowWithPresentVC:(UIViewController *)presentVC
                                                        onPhontePicked:(YSPhotoPickedBlock)photoPicked
                                                              onCancel:(YSCancelBlock)cancelled
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
#if __has_feature(objc_arc)

#else
    [actionSheet autorelease];
#endif
    NSMutableArray *types = [NSMutableArray array];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
        [types addObject:[NSNumber numberWithInt:UIImagePickerControllerSourceTypeCamera]];
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", @"")];
	}
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
        [types addObject:[NSNumber numberWithInt:UIImagePickerControllerSourceTypePhotoLibrary]];
		[actionSheet addButtonWithTitle:NSLocalizedString(@"Photo library", @"")];
	}
    if (!types.count) {
        return;
    }
    else if(types.count == 1)
    {
        [self photoPickerWithSourceType:[types[0] intValue] presentVC:presentVC onPhontePicked:photoPicked onCancel:cancelled];
    }
    else
    {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
        [actionSheet showInView:presentVC.view withCompletionHandler:^(NSInteger buttonIndex) {
            if (buttonIndex < types.count) {
                [self photoPickerWithSourceType:[types[buttonIndex] intValue] presentVC:presentVC onPhontePicked:photoPicked onCancel:cancelled];
            }
        }];
    }
}

+ (UIImagePickerController *)photoPickerWithSourceType:(UIImagePickerControllerSourceType)type
                                             presentVC:(UIViewController *)presentVC
                                        onPhontePicked:(YSPhotoPickedBlock)photoPicked
                                              onCancel:(YSCancelBlock)cancelled
{
    if(![UIImagePickerController isSourceTypeAvailable:type] || !presentVC)
	{
        return nil;
    }
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
#if __has_feature(objc_arc)

#else
    [controller autorelease];
#endif
    controller.sourceType = type;
    controller.allowsEditing = YES;
    [controller presentFromController:presentVC
                       onPhontePicked:photoPicked onCancel:cancelled];
    return nil;
}
- (void)presentFromController:(UIViewController *)presentVC
               onPhontePicked:(YSPhotoPickedBlock)photoPicked
                     onCancel:(YSCancelBlock)cancelled
{
    self.delegate = self;
    [self setPhotoPickedBlock:photoPicked];
    [self setCancelBlock:cancelled];
    [presentVC presentModalViewController:self animated:YES];
}
#pragma mark -delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage)
        editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerOriginalImage];

    if (self.photoPickedBlock) {
        self.photoPickedBlock(editedImage);
    }
	[picker dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [picker dismissModalViewControllerAnimated:YES];
}

@end
