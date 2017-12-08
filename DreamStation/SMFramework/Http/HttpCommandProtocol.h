@protocol HttpCommandCompleteDelegate <NSObject>
- (void)complete:(id)resultObj;
@end


@protocol HttpCommandProtocol <NSObject>
@required
- (id)execute;
- (void)cancel;
- (NSString *)getUrl;
- (id)result;
- (void)onRequestSuccess:(id)request code:(NSInteger)code;
- (void)onRequestFailed:(id)responesObject;
@end
