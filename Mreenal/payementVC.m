//
//  payementVC.m
//  Mreedazzle
//
//  Created by Faridullah on 10/9/16.
//  Copyright © 2016 Xpired. All rights reserved.
//

#import "payementVC.h"
#import "DBManager.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface payementVC ()
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@end

@implementation payementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productArray_=[[NSMutableArray alloc] init];
    productArray_=[[DBManager getSharedInstance] allProudcts];
    
    //NSLog(@"%@",productArray_);
    [self.productTable reloadData];
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableView Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return productArray_.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"productCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        
    }
    UIImageView *pro_image=(UIImageView*)[cell viewWithTag:1];
    UILabel *pro_name=(UILabel*)[cell viewWithTag:2];
    UILabel *pro_price=(UILabel*)[cell viewWithTag:3];
    UILabel *pro_quantity=(UILabel*)[cell viewWithTag:4];
    UIButton *deleteBtn=(UIButton*)[cell viewWithTag:5];
    deleteBtn.tag=[[[productArray_  objectAtIndex:indexPath.section] valueForKey:@"proId"] integerValue];
    [deleteBtn addTarget:self
               action:@selector(deleteProductRecord:)
     forControlEvents:UIControlEventTouchUpInside];
    [pro_image sd_setImageWithURL:[NSURL URLWithString:[[productArray_ objectAtIndex:indexPath.section]  valueForKey:@"pro_image"]]
                 placeholderImage:[UIImage imageNamed:@""]];
    NSString* finish = [[[[productArray_ objectAtIndex:indexPath.section] valueForKey:@"pro_name"] componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
    pro_name.text=[NSString stringWithFormat:@"Name: %@",finish];
    pro_price.text=[NSString stringWithFormat:@"Price: $%@",[[productArray_ objectAtIndex:indexPath.section] valueForKey:@"pro_price"]];
    pro_quantity.text=[NSString stringWithFormat:@"Quantity:%@",[[productArray_ objectAtIndex:indexPath.section] valueForKey:@"pro_qunatity"]];
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}
- (IBAction)deleteProductRecord:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSInteger proId = button.tag;
    [[DBManager getSharedInstance] deleteProductRecord:[NSString stringWithFormat:@"%ld",(long)proId]];
    productArray_=[[NSMutableArray alloc] init];
    productArray_=[[DBManager getSharedInstance] allProudcts];
    [self.productTable reloadData];
}
- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)checkOutAction:(id)sender {
    // Remove our last completed payment, just for demo purposes.
    if (productArray_.count>0) {
    self.resultText = nil;
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
        NSMutableArray *items=[[NSMutableArray alloc] init];
for (int i=0; i<productArray_.count; i++) {
        NSString* finish = [[[[productArray_ objectAtIndex:i] valueForKey:@"pro_name"] componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
        PayPalItem *item1 = [PayPalItem itemWithName:finish
                    withQuantity:1
                    withPrice:[NSDecimalNumber decimalNumberWithString:[[productArray_ objectAtIndex:i] valueForKey:@"pro_price"]]
                    withCurrency:@"USD"
                    withSku:[NSString stringWithFormat:@"Hip-0003%d",i]];
                    [items addObject:item1];
        }
   
  
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"5.99"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"2.50"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Mreedazzle clothing";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig delegate:self];
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [self presentViewController:paymentViewController animated:YES completion:nil];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:MSG_ALERT_TITLE
                                                        message:@"No item for checkout."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];

    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}
@end
