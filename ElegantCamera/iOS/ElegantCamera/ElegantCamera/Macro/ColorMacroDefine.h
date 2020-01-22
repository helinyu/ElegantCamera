//
//  ColorMacroDefine.h
//  KanManHua
//
//  Created by wangkun on 2017/11/17.
//  Copyright © 2017年 KanManHua. All rights reserved.
//

#ifndef ColorMacroDefine_h
#define ColorMacroDefine_h

#import <YYKit/YYKit.h>

#define HexColor(hexString) UIColorHex(hexString)
#define HexColorWithAlpha(hexString, alpha) [HexColor(hexString) colorWithAlphaComponent:alpha]

// 16进制颜色的方法
#define kHexColor(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]
#define kRGB(r, g, b) kRGBA(r, g, b, 1)

#define kRGB_MAIN kRGB(116.f, 232.f, 246.f)
// 0x74E8F6
#define kRGB_MAIN_WEIGHT kRGB(116.f, 190.f, 255.f)

#define kClearColor    [UIColor clearColor]
#define kBlack_A(a) HexColorWithAlpha(@"000000", a);
#define kWhite_A(a) HexColorWithAlpha(@"ffffff", a);

#define kRGB_BLUE HexColor(@"41A1FF")
#define kRGB_RED  HexColor(@"eb2c1b")
#define kRGB_DARK_RED HexColor(@"FC5959")
#define kRGB_GREEN HexColor(@"41C88A")
#define kRGB_MAIN_BG HexColor(@"FDEFED")

#define kRGB_FFF7FB HexColor(@"FFF7FB")
#define kRGB_FF6465 HexColor(@"FF6465")
#define kRGB_FFEDF7 HexColor(@"FFEDF7")
#define kRGB_F7F8FA HexColor(@"F7F8FA")

#define kRGB_EB HexColor(@"ebebeb")
#define kRGB_9B HexColor(@"9B9B9B")
#define kRGB_00 HexColor(@"000000")
#define kRGB_11 HexColor(@"111111")
#define kRGB_27 HexColor(@"272727")
#define kRGB_33 HexColor(@"333333")
#define kRGB_41 HexColor(@"414141")
#define kRGB_44 HexColor(@"444444")
#define kRGB_4A HexColor(@"4a4a4a")
#define kRGB_53 HexColor(@"535353")
#define kRGB_55 HexColor(@"555555")
#define kRGB_63 HexColor(@"636363")
#define kRGB_66 HexColor(666666)
#define kRGB_71 HexColor(@"717171")
#define kRGB_77 HexColor(@"777777")
#define kRGB_80 HexColor(@"808080")
#define kRGB_81 HexColor(@"818181")
#define kRGB_98 HexColor(@"989898")
#define kRGB_99 HexColor(999999)
#define kRGB_9B HexColor(@"9B9B9B")

#define kRGB_A0 HexColor(@"a0a0a0")
#define kRGB_A1 HexColor(@"a1a1a1")
#define kRGB_A8 HexColor(@"a8a8a8")
#define kRGB_A9 HexColor(@"a9a9a9")
#define kRGB_AA HexColor(@"aaaaaa")
#define kRGB_AE HexColor(@"aeaeae")
#define kRGB_E6 HexColor(@"e6e6e6")

#define kRGB_B6 HexColor(@"B6B6B6")
#define kRGB_B9 HexColor(@"B9B9B9")
#define kRGB_BB HexColor(@"BBBBBB")
#define kRGB_BC HexColor(@"BCBCBC")
#define kRGB_CF HexColor(@"cfcfcf")

#define kRGB_C3 HexColor(@"C3C3C3")
#define kRGB_CC HexColor(@"CCCCCC")
#define kRGB_CD HexColor(@"CDCDCD")

#define kRGB_D8 HexColor(@"D8D8D8")
#define kRGB_DD HexColor(DDDDDD)

#define kRGB_E3 HexColor(@"E3E3E3")
#define kRGB_E4 HexColor(@"E4E4E4")
#define kRGB_EB HexColor(@"ebebeb")
#define kRGB_EE HexColor(EEEEEE)
#define kRGB_EF HexColor(@"EFEFEF")

#define kRGB_FE HexColor(@"FEFEFE")

#define nightColor [UIColor colorWithHexString:@"6D6C6C"]
#define minorOrangeColor [UIColor colorWithHexString:@"#ffac40"]
#define minorRedColor [UIColor colorWithHexString:@"#ff3f7a"]
#define minorNightColor [UIColor colorWithHexString:@"#8b8a8a"]
#define minorWhiteColor [UIColor colorWithHexString:@"#e2e2e2"]


#define kRGB_F1 HexColor(@"f1f1f1")
#define kRGB_F5 HexColor(@"F5F5F5")
#define kRGB_F6 HexColor(@"F6F6F6")
#define kRGB_F8 HexColor(@"F8F8F8")
#define kRGB_F9 HexColor(@"F9F9F9")
#define kRGB_FA HexColor(@"FAFAFA")
#define kRGB_FF HexColor(ffffff)

#define kRGB_FC5959 HexColor(@"FC5959")
#define kRGB_FFF7FB HexColor(@"FFF7FB")
#define kRGB_FF6465 HexColor(@"FF6465")
#define kRGB_FFEDF7 HexColor(@"FFEDF7")
#define kRGB_41A1FF HexColor(@"41A1FF")
#define kRGB_4E97FF HexColor(@"4E97FF")
#define kRGB_E3B987 HexColor(@"E3B987")
#define kRGB_E7C681 HexColor(@"E7C681")
#define kRGB_522D04 HexColor(@"522D04")
#define kRGB_FFF5F1 HexColor(@"FFF5F1")
#define kRGB_C4DDFE HexColor(@"C4DDFE")
#define kRGB_FFF1EB HexColor(@"FFF1EB")
#define kRGB_A04529 HexColor(@"A04529")

#define kRGB_F1CF98 HexColor(@"FFF5F1")
#define kRGB_F65C3D HexColor(@"F65C3D")
#define kRGB_5775DC HexColor(@"5775DC")
#define kRGB_6D8BC4 HexColor(@"6D8BC4")
#define kRGB_C6A47E HexColor(@"C6A47E")
#define kRGB_B28B60 HexColor(@"B28B60")
#define kRGB_28A9E9 HexColor(@"28A9E9")
#define kRGB_2E88D9 HexColor(@"2E88D9")
#define kRGB_FF858C HexColor(@"ff858c")
#define kRGB_FAE167 HexColor(@"FAE167")
#define kRGB_F3D56F HexColor(@"F3D56F")
#define kRGB_FFAE58 HexColor(@"FFAE58")
#define kRGB_FDC25A HexColor(@"FDC25A")
#define kRGB_FF8C11 HexColor(@"FF8C11")
#define kRGB_3288EF HexColor(@"3288EF")
#define kRGB_A7C3DD HexColor(@"A7C3DD")
#define kRGB_FF5856 HexColor(@"FF5856")
#define kRGB_1EE579 HexColor(@"1EE579")
#define kRGB_F6FCFF HexColor(@"F6FCFF")

#define kRGB_CBCBD0 HexColor(@"CBCBD0")
#define kRGB_D25AB9 HexColor(@"d25ab9")
#define kRGB_FFC700 HexColor(@"FFC700")
#define kRGB_FFAA00 HexColor(@"FFAA00")
#define kRGB_14387A HexColor(@"14387A")
#define kRGB_649BB5 HexColor(@"649BB5")
#define kRGB_D9A121 HexColor(@"D9A121")
#define kRGB_4396EF HexColor(@"4396EF")

#define kRGB_FB8492 HexColor(@"FB8492")
#define kRGB_FF99B0 HexColor(@"FF99B0")
#define kRGB_F1687B HexColor(@"F1687B")
#define kRGB_FF797A HexColor(@"FF797A")
#define kRGB_FDEDEE HexColor(@"FDEDEE")

#define kRGB_8F7A03 HexColor(@"8F7A03") // 1代
#define kRGB_408443 HexColor(@"408443") // 2代
#define kRGB_2485D1 HexColor(@"2485D1") // 3代
#define kRGB_9568BA HexColor(@"9568BA") // 4代
#define kRGB_BE5022 HexColor(@"BE5022") // 5代
#define kRGB_FFF9FA HexColor(@"FFF9FA") // 5代

#define kRGB_F67016 HexColor(@"F67016")
#define kRGB_A48779 HexColor(@"A48779")
#define kRGB_14AC79 HexColor(@"14AC79")
#define kRGB_FFEE2B HexColor(@"FFEE2B")
#define kRGB_14AC79 HexColor(@"14AC79")
#define kRGB_0D915B HexColor(@"0D915B")

#define kRGB_F2D137 HexColor(@"F2D137")
#define kRGB_FF8576 HexColor(@"FF8576")
#define kRGB_FF76BA HexColor(@"FF76BA")
#define kRGB_FFF5F4 HexColor(@"FFF5F4")
#define kRGB_543EDA HexColor(@"543EDA")
#define kRGB_B5DAFF HexColor(@"B5DAFF")


#endif /* ColorMacroDefine_h */
