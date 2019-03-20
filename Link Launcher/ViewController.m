
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) UIAlertController *addURLAlert;
@property (strong, nonatomic) NSMutableArray<NSString *> *URLs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self savedURLs]) {
        self.URLs = [self savedURLs];
    } else {
        self.URLs = [[NSMutableArray alloc] init];
    }
}

- (IBAction)didTapButton:(id)sender {
    [self showAddAlert];
}

- (void)showAddAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add New Link"
                                                                    message:@"Enter a link you would like to test"
                                                             preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField setPlaceholder:@"http://example.com"];
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    UIAlertAction *add = [UIAlertAction actionWithTitle:@"Add"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    NSString *newURL = self.addURLAlert.textFields[0].text;
                                                    [self.URLs addObject:newURL];
                                                    [self saveURLsinArray:self.URLs];
                                                    // TODO: Add to Table View
                                                }];

    [alert addAction:cancel];
    [alert addAction:add];

    self.addURLAlert = alert;
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSMutableArray *)savedURLs {
    NSArray *urls = [[NSUserDefaults standardUserDefaults] arrayForKey:@"URLS"];
    return [urls mutableCopy];
}

- (void)saveURLsinArray:(NSArray *) array {
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"URLS"];
}


#pragma mark TableView Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.URLs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = self.URLs[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.textLabel setText:url];

    return cell;
}
@end
