//
//  ExpandDressColloection.m
//  Mreedazzle
//
//  Created by Faridullah on 10/9/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "ExpandDressColloection.h"
#import "UtilityClass.h"
@implementation ExpandDressColloection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)getDataFromProductAPI:(NSString*)option{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.shopstyle.com/api/v2/products?pid=uid0-36072800-63&fts=%@&offset=0&limit=10",option]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
            NSDictionary* products = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             //NSLog(@"Product :%@",[[products valueForKey:@"products"] valueForKey:@"name"]);
             [[NSNotificationCenter defaultCenter] postNotificationName:@"ExpandDressOption" object:self userInfo:[products objectForKey:@"products"]];
         }
     }];
  
    
}

@end
