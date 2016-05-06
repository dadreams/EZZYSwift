//
//  PDPolygon.m
//  ElectricCarRent
//
//  Created by 彭懂 on 16/1/13.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import "PDPolygon.h"

@implementation PDPolygon

@end


@implementation PDPolygonManager

- (PDPolygon *)createZiDingYiCoverViewOnMapViewWithPointArr:(NSArray *)pointArr andTag:(NSInteger)tag
{
    NSInteger numberOfPoints = [pointArr count];

    CLLocationCoordinate2D points[numberOfPoints];
    for (NSInteger i = 0; i < numberOfPoints; i++) {
        NSString * point = [pointArr objectAtIndex:i];
        NSArray * array = [point componentsSeparatedByString:@","];
        NSString * longi = array[0];
        NSString * latitu = array[1];
        points[i] = CLLocationCoordinate2DMake(latitu.doubleValue, longi.doubleValue);
    }
    PDPolygon * poly = [PDPolygon polygonWithCoordinates:points count:numberOfPoints];
    if (tag == 0) {
        poly.polygonColorType = PolygonColorFanWei;
    } else if (tag == 1) {
        poly.polygonColorType = PolygonColorGreen;
    } else if (tag == 2)
    {
        poly.polygonColorType = PolygonColorYellow;
    } else if (tag > 2) {
        poly.polygonColorType = PolygonColorRed;
    }
    return poly;
}

@end