//
//  OUConversationViewController.h
//  
//
//  Created by Tyler Kuster on 5/10/15.
//
//

#import "JSQMessages.h"
#import "JSQMessagesViewController.h"
#import "DemoModelData.h"

@interface OUConversationViewController : JSQMessagesViewController// <JSQMessagesCollectionViewDataSource, JSQMessagesCollectionViewDelegateFlowLayout>

@property (strong, nonatomic) DemoModelData *demoData;

@end
