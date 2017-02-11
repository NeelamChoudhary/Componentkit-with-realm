/* This file provided by Facebook is for non-commercial testing and evaluation
 * purposes only.  Facebook reserves all rights not expressly granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "AppDelegate.h"

#import "WildeGuessCollectionViewController.h"
#import "Realm/Realm.h"


//realm changes- Creating model object starts
@interface RandomQuotes : RLMObject

@property(nonatomic, copy) NSString *quote ;
@property(nonatomic, copy) NSString *author;

@end

@implementation RandomQuotes

@end
//realm changes- Creating model object ends


@implementation AppDelegate {
  UIWindow *_window;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    // Test if Realm is integrated
    /* RandomQuotes *myquote = [[RandomQuotes alloc] init];
    myquote.quote = @"Hello";
    myquote.author = @"Neelam";
    NSLog(@"quote is : %@", myquote.quote); */
    
    //Creating model object and assigning values for each field
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    RandomQuotes *randomquote = [[RandomQuotes alloc] init];
    randomquote.quote = @"I have the simplest tastes. I am always satisfied with the best.";
    randomquote.author = @"Oscar Wilde";
    
    //writing data to the Realm DB with transaction block
    [defaultRealm transactionWithBlock:^{
        [defaultRealm addObject:randomquote];
    }];
    
    NSLog(@"one quote written to DB");
    
    RLMResults *result = [RandomQuotes allObjects];
    NSLog(@"%@a", result);
      
    
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  [flowLayout setMinimumInteritemSpacing:0];
  [flowLayout setMinimumLineSpacing:0];

  WildeGuessCollectionViewController *viewController = [[WildeGuessCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];

  [_window setRootViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
  [_window makeKeyAndVisible];
  return YES;
}

@end
