
#import <UIKit/UIKit.h>

#define CExpandContentOffset @"contentOffset"

#define KNeedSaveOffset NO//YES//

#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])

#define LOGA(f) NSLog(@"%@",f)
#define LOGFUN NSLog(@"%s | %d | %s",__FILE__,__LINE__,__FUNCTION__)

#define AFTER(s) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(s * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
