//
//  MIHSortTool.m
//  Algorithm
//
//  Created by konghui on 2020/12/17.
//

#import "MIHSortTool.h"

static NSMutableArray *datas;

@implementation MIHSortTool

+ (NSMutableArray *)sortDatas:(NSMutableArray *)unsortedDatas{
//    return [self sortDatas:unsortedDatas withType:MIHSortTypeQuick];
    return [self sortDatas:unsortedDatas withType:MIHSortTypeShell];
}

+ (NSMutableArray *)sortDatas:(NSMutableArray *)unsortedDatas
                     withType:(MIHSortType)type{
    switch (type) {
        case MIHSortTypeBubble:
            return [self bubbleSortDatas:unsortedDatas];
        case MIHSortTypeSelect:
            return [self selectSortDatas:unsortedDatas];
        case MIHSortTypeInsert:
            return [self insertSortDatas:unsortedDatas];
        case MIHSortTypeShell:
            return [self shellSortDatas:unsortedDatas];
        case MIHSortTypeQuick:
            return [self quickSortDatas:unsortedDatas];
        case MIHSortTypeMerge:
            return [self mergeSortDatas:unsortedDatas];
        case MIHSortTypeCount:
            return [self countSortDatas:unsortedDatas];
        case MIHSortTypeBucket:
            return [self bucketSortDatas:unsortedDatas];
        case MIHSortTypeRadix:
            return [self radixSortDatas:unsortedDatas];
    }
}


/**
 *  冒泡排序是通过比较两个相邻元素的大小实现排序，如果前一个元素大于后一个元素，就交换这两个元素。这样就会让每一趟冒泡都能找到最大一个元素并放到最后。
 *  时间复杂度O(n²)
 */
+ (NSMutableArray *)bubbleSortDatas:(NSMutableArray *)unsortedDatas{
    for (int i = 0; i < unsortedDatas.count - 1; i ++) {
        BOOL changeSign = NO;
        for (int j = 0; j < unsortedDatas.count - 1 - i; j ++) {
            if ([unsortedDatas[j + 1] intValue] < [unsortedDatas[j] intValue]) {
                NSNumber *tmp = unsortedDatas[j];
                unsortedDatas[j] = unsortedDatas[j+1];
                unsortedDatas[j + 1] = tmp;
                changeSign = YES;
            }
        }
        if (changeSign == NO) {
            break;
        }
    }
    return unsortedDatas;
}


/**
 *  选择排序的思想是，依次从「无序列表」中找到一个最小的元素放到「有序列表」的最后面。
 *  时间复杂度O(n²)
 */
+ (NSMutableArray *)selectSortDatas:(NSMutableArray *)unsortedDatas{
    for (int i = 0; i < unsortedDatas.count - 1; i ++) {
        int minIndex = i;
        for (int j = i + 1; j < unsortedDatas.count; j ++) {
            if ([unsortedDatas[j] intValue] < [unsortedDatas[minIndex] intValue]) {
                minIndex = j;
            }
        }
        if (minIndex != i) {
            NSNumber *tmp = unsortedDatas[i];
            unsortedDatas[i] = unsortedDatas[minIndex];
            unsortedDatas[minIndex] = tmp;
        }
    }
    return unsortedDatas;
}


/**
 *  在整个排序过程，分成两组，逐步遍历后一组中元素插入到前一组中，最终构成一个有序序列：
 *  时间复杂度O(n²)
 */
+ (NSMutableArray *)insertSortDatas:(NSMutableArray *)unsortedDatas{
    for (int i = 1; i < unsortedDatas.count; i ++) {
        NSNumber *insertNum = unsortedDatas[i];
//        for (int j = i - 1; j >= 0; j --) {
//            if ([insertNum intValue] < [unsortedDatas[j] intValue]) {
//                unsortedDatas[j + 1] = unsortedDatas[j];
//                if (j == 0) {
//                    unsortedDatas[j] = insertNum;
//                }
//            }else{
//                unsortedDatas[j + 1] = insertNum;
//                break;
//            }
//        }
        int preIndex = i - 1;
        while (preIndex >= 0 && [insertNum intValue] < [unsortedDatas[preIndex] intValue]) {
            unsortedDatas[preIndex + 1] = unsortedDatas[preIndex];
            preIndex --;
        }
        unsortedDatas[preIndex + 1] = insertNum;
    }
    
    return unsortedDatas;
}


/**
 *  它的核心思想是把一个序列分组，对分组后的内容进行插入排序，这里的分组只是逻辑上的分组，不会重新开辟存储空间。它其实是插入排序的优化版，插入排序对基本有序的序列性能好，希尔排序利用这一特性把原序列分组，对每个分组进行排序，逐步完成排序
 *  时间复杂度：希尔排序的时间复杂度与增量序列的选取有关，例如希尔增量最坏时间复杂度为O(n²)，而Hibbard增量的希尔排序的最坏时间复杂度为O(n3/2)，希尔排序时间复杂度的下界是n*log2n
 */
+ (NSMutableArray *)shellSortDatas:(NSMutableArray *)unsortedDatas{
    int gap = (int)unsortedDatas.count;
    while (gap / 2 != 0) {
        gap = gap / 2;
        for (int i = gap; i < unsortedDatas.count; i ++) {
//            NSNumber *currentNum = unsortedDatas[i];
//            for (int j = i - gap; j >= 0; j = j - gap) {
//                if ([currentNum intValue] < [unsortedDatas[j] intValue]) {
//                    unsortedDatas[j + gap] = unsortedDatas[j];
//                    if (j - gap < 0) {
//                        unsortedDatas[j] = currentNum;
//                    }
//                }else{
//                    unsortedDatas[j + gap] = currentNum;
//                    break;
//                }
//            }
            for (int j = i - gap; j >= 0 && ([unsortedDatas[j] intValue] > [unsortedDatas[j + gap] intValue]); j -= gap) {
                NSNumber *tmp = unsortedDatas[j];
                unsortedDatas[j] = unsortedDatas[j + gap];
                unsortedDatas[j + gap] = tmp;
            }
        }
    }
    return unsortedDatas;
}


/*
 *  快速排序的核心思想是对待排序序列通过一个「支点」（支点就是序列中的一个元素，别把它想的太高大上）进行拆分，使得左边的数据小于支点，右边的数据大于支点。然后把左边和右边再做一次递归，直到递归结束。支点的选择也是一门大学问，我们以 （左边index + 右边index）/ 2 来选择支点。
 快速排序使用一个高效的方法做数据拆分。
 用一个指向左边的游标 i，和指向右边的游标 j，逐渐移动这两个游标，直到左边找到大于支点的元素，右边找到小于支点的元素, 停止移动游标，交换，交换完后 i++，j--（对下一个元素进行比较），直到 i>=j，停止移动。
 *  时间复杂度O(nlogn)
 */
+ (NSMutableArray *)quickSortDatas:(NSMutableArray *)unsortedDatas{
    [self quickSortDatas:unsortedDatas beginIndex:0 endIndex:(int)(unsortedDatas.count - 1)];
    return unsortedDatas;
}
+ (void)quickSortDatas:(NSMutableArray *)unsortedDatas beginIndex:(int)begin endIndex:(int)end{
    int i = begin, j = end, mid = (begin + end) / 2;
    NSNumber *pivot = unsortedDatas[mid];
    while (i < j) {
        while ([unsortedDatas[i] intValue] < [pivot intValue]) {
            i ++;
        }
        while ([unsortedDatas[j] intValue] > [pivot intValue]) {
            j --;
        }
        if (i <= j) {
            if (i != j) {
                NSNumber *tmp = unsortedDatas[j];
                unsortedDatas[j] = unsortedDatas[i];
                unsortedDatas[i] = tmp;
            }
            
            i ++;
            j --;
        }
    }
    if (j > begin) {
        [self quickSortDatas:unsortedDatas beginIndex:begin endIndex:j];
    }
    if (i < end) {
        [self quickSortDatas:unsortedDatas beginIndex:i endIndex:end];
    }
}


/**
 *  归并排序，采用分治思想，先把待排序序列拆分成一个个子序列，直到子序列只有一个元素，停止拆分，然后对每个子序列进行边排序边合并。
 *  时间复杂度O(nlogn)
 */
+ (NSMutableArray *)mergeSortDatas:(NSMutableArray *)unsortedDatas{
    [self mergeSortDatas:unsortedDatas beginIndex:0 endIndex:(int)unsortedDatas.count];
    return unsortedDatas;
}
+ (void)mergeSortDatas:(NSMutableArray *)unsortedDatas beginIndex:(int)begin endIndex:(int)end{
    int mid = (begin + end) / 2;
    if (begin == mid) {
        return;
    }
    if (begin < mid) {
        [self mergeSortDatas:unsortedDatas beginIndex:begin endIndex:mid];
    }
    if (mid < end) {
        [self mergeSortDatas:unsortedDatas beginIndex:mid endIndex:end];
    }
    for (int i = mid; i < end; i ++) {
        for (int j = i - 1; j >= begin && ([unsortedDatas[j] intValue] > [unsortedDatas[j + 1] intValue]); j --) {
            NSNumber *tmp = unsortedDatas[j + 1];
            unsortedDatas[j + 1] = unsortedDatas[j];
            unsortedDatas[j] = tmp;
        }
    }
}

//如果不考虑传入数组和返回数组地址不同
//+ (NSMutableArray *)mergeSortDatas:(NSMutableArray *)unsortedDatas{
//    if (unsortedDatas.count == 1) {
//        return unsortedDatas;
//    }
//
//    NSUInteger mid = unsortedDatas.count / 2;
//    NSMutableArray *leftArray = [self mergeSortDatas:[[unsortedDatas subarrayWithRange:NSMakeRange(0, mid)] mutableCopy]];
//    NSMutableArray *rightArray = [self mergeSortDatas:[[unsortedDatas subarrayWithRange:NSMakeRange(mid, unsortedDatas.count - mid)] mutableCopy]];
//
//    NSInteger leftIndex = 0;
//    NSInteger rightIndex= 0;
//    NSMutableArray *sortedDatas = [[NSMutableArray alloc] initWithCapacity:unsortedDatas.count];
//    while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
//        if ([leftArray[leftIndex] intValue] <= [rightArray[rightIndex] intValue]) {
//            [sortedDatas addObject:leftArray[leftIndex]];
//            leftIndex ++;
//        }else{
//            [sortedDatas addObject:rightArray[rightIndex]];
//            rightIndex ++;
//        }
//    }
//    if (leftIndex < leftArray.count) {
//        [sortedDatas addObjectsFromArray:[leftArray subarrayWithRange:NSMakeRange(leftIndex, leftArray.count - leftIndex)]];
//    }
//    if (rightIndex < rightArray.count) {
//        [sortedDatas addObjectsFromArray:[rightArray subarrayWithRange:NSMakeRange(rightIndex, rightArray.count - rightIndex)]];
//    }
//    return sortedDatas;
//}


/**
 *  计数排序的核心思想是把一个无序序列 A 转换成另一个有序序列 B，从 B 中逐个“取出”所有元素，取出的元素即为有序序列
 *  时间负责度O(n+k)
 */
+ (NSMutableArray *)countSortDatas:(NSMutableArray *)unsortedDatas{
    NSNumber *maxNum = [unsortedDatas firstObject], *minNum = [unsortedDatas firstObject];
    for (int i = 1; i < unsortedDatas.count; i ++) {
        if ([unsortedDatas[i] intValue] > [maxNum intValue]) {
            maxNum = unsortedDatas[i];
        }else if ([unsortedDatas[i] intValue] < [minNum intValue]) {
            minNum = unsortedDatas[i];
        }
    }
    
    int countArraySize = [maxNum intValue] - [minNum intValue] + 1;
    NSMutableArray *countArray = [[NSMutableArray alloc] initWithCapacity:countArraySize];
    for (int i = 0; i < countArraySize; i ++) {
        [countArray addObject:@(0)];
    }
    
    for (int i = 0; i < unsortedDatas.count; i ++) {
        int index = [unsortedDatas[i] intValue] - [minNum intValue];
        NSNumber *indexNum = countArray[index];
        countArray[index] = @([indexNum intValue] + 1);
    }
    
    NSMutableArray *sortedDatas = [[NSMutableArray alloc] initWithCapacity:unsortedDatas.count];
    for (int i = 0; i < countArray.count; i ++) {
        int numValue = [countArray[i] intValue];
        while (numValue > 0) {
            [sortedDatas addObject:@([minNum intValue] + i)];
            numValue --;
        }
    }
    
    return sortedDatas;
}


/**
 *  排序前需要确定桶的个数，和确定桶中元素的取值范围
 *  时间复杂度最好为 O( n + k )，最坏为 O（n * n）
 */
+ (NSMutableArray *)bucketSortDatas:(NSMutableArray *)unsortedDatas{
    int defaultBucketsNum = 3;
    return [self bucketSortDatas:unsortedDatas withBucketsNum:defaultBucketsNum];
}
+ (NSMutableArray *)bucketSortDatas:(NSMutableArray *)unsortedDatas withBucketsNum:(int)bucketsNum{
    NSNumber *maxNum = [unsortedDatas firstObject], *minNum = [unsortedDatas firstObject];
    for (int i = 1; i < unsortedDatas.count; i ++) {
        if ([unsortedDatas[i] intValue] > [maxNum intValue]) {
            maxNum = unsortedDatas[i];
        }else if ([unsortedDatas[i] intValue] < [minNum intValue]) {
            minNum = unsortedDatas[i];
        }
    }
    
    NSMutableArray *bucketsArray = [[NSMutableArray alloc] initWithCapacity:bucketsNum];
    for (int i = 0; i < bucketsNum; i ++) {
        [bucketsArray addObject:[NSMutableArray array]];
    }
    
    double space = ([maxNum intValue] - [minNum intValue] + 1) * 1. / bucketsNum;
    for (int i = 0; i < unsortedDatas.count; i ++) {
        NSNumber *currentNum = unsortedDatas[i];
        int index = floor(([currentNum intValue] - [minNum intValue]) / space);
        NSMutableArray *currentBucketArray = bucketsArray[index];
        //插入
        int insertIndex = 0;
        for (int j = (int)currentBucketArray.count - 1; j >= 0; j --) {
            if ([currentBucketArray[j] intValue] <= [currentNum intValue]) {
                insertIndex = j + 1;
                break;
            }
        }
        [currentBucketArray insertObject:currentNum atIndex:insertIndex];
    }
    
    NSMutableArray *sortedDatas = [[NSMutableArray alloc] initWithCapacity:unsortedDatas.count];
    for (int i = 0; i < bucketsArray.count; i ++) {
        [sortedDatas addObjectsFromArray:bucketsArray[i]];
    }
    
    return sortedDatas;
}


/**
 *  基数排序是从待排序序列找出可以作为排序的「关键字」，按照「关键字」进行多次排序，最终得到有序序列。
 */
+ (NSMutableArray *)radixSortDatas:(NSMutableArray *)unsortedDatas{
    int maxNum = [[unsortedDatas firstObject] intValue];
    for (int i = 0; i < unsortedDatas.count; i ++) {
        if ([unsortedDatas[i] intValue] > maxNum) {
            maxNum = [unsortedDatas[i] intValue];
        }
    }
    int cycleCount = 1;
    while (maxNum / 10 != 0) {
        cycleCount ++;
        maxNum = maxNum / 10;
    }

    NSMutableArray *buckets = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i ++) {
        [buckets addObject:[NSMutableArray array]];
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithArray:unsortedDatas];
    for (int i = 0; i < cycleCount; i ++) {
        for (int j = 0; j < results.count; j ++) {
            NSNumber *currentNum = results[j];
            int index = ([currentNum intValue] / ((int)pow(10, i))) % 10;
            NSMutableArray *bucket = buckets[index];
            [bucket addObject:currentNum];
        }
        
        [results removeAllObjects];
        
        [buckets enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull bucket, NSUInteger idx, BOOL * _Nonnull stop) {
            [results addObjectsFromArray:bucket];
            [bucket removeAllObjects];
        }];
    }
    
    return results;
}

@end
