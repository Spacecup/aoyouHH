//
//  CommonHelper.h


#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject {
    
}

+(uint64_t)getFreeDiskspace;
+(uint64_t)getTotalDiskspace;
+(NSString *)getDiskSpaceInfo;
//将文件大小转化成M单位或者B单位
+(NSString *)getFileSizeString:(NSString *)size;
//经文件大小转化成不带单位ied数字
+(float)getFileSizeNumber:(NSString *)size;
+(NSDate *)makeDate:(NSString *)birthday;
+(NSString *)dateToString:(NSDate*)date;
+(NSString *)timeChange:(NSString *)timeC;
+(NSString *)getTempFolderPathWithBasepath:(NSString *)name;//得到临时文件存储文件夹的路径
+(NSArray *)getTargetFloderPathWithBasepath:(NSString *)name subpatharr:(NSArray *)arr;
+(NSString *)getTargetPathWithBasepath:(NSString *)name subpath:(NSString *)subpath;
+(BOOL)isExistFile:(NSString *)fileName;//检查文件名是否存在
+(NSMutableArray *)getAllFinishFilesListWithPatharr:(NSArray *)patharr;
+ (NSString *)md5StringForData:(NSData*)data;
+ (NSString *)md5StringForString:(NSString*)str;
//传入文件总大小和当前大小，得到文件的下载进度
+(CGFloat) getProgress:(float)totalSize currentSize:(float)currentSize;


@end
