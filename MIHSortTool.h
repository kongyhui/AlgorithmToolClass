//
//  MIHSortTool.h
//  Algorithm
//
//  Created by konghui on 2020/12/17.
//

#import <Foundation/Foundation.h>

/**
 *  参考文章链接
 *  https://cloud.tencent.com/developer/article/1485910
 *      
 */

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MIHSortType) {
    MIHSortTypeBubble,  //冒泡
    MIHSortTypeSelect,  //选择
    MIHSortTypeInsert,  //插入
    MIHSortTypeShell,   //希尔
    MIHSortTypeQuick,   //快速
    MIHSortTypeMerge,   //归并
    MIHSortTypeCount,   //计数
    MIHSortTypeBucket,  //桶
    MIHSortTypeRadix,   //基数
};

@interface MIHSortTool : NSObject

+ (NSMutableArray *)sortDatas:(NSMutableArray *)unsortedDatas;

+ (NSMutableArray *)sortDatas:(NSMutableArray *)unsortedDatas
                     withType:(MIHSortType)type;

@end

NS_ASSUME_NONNULL_END
