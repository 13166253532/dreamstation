//
//  DSHttpGetPersonAccountCmd+Response.m
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/30.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import "DSHttpGetPersonAccountCmd+Response.h"
#import "DSHttpGetPersonAccountResult.h"
#import "JSONModel.h"
#import "DreamStation-Swift.h"

@protocol DSHttpGetPersonAccountCompanies;
@interface DSHttpGetPersonAccountCompanies : JSONModel
@property NSString<Optional>*myName;
@property NSString<Optional>*licenceUrl;
@property NSString<Optional>*name;
@property NSString<Optional>*address;
@end
@implementation DSHttpGetPersonAccountCompanies
@end

@protocol DSHttpGetPersonAccountProvider;
@interface DSHttpGetPersonAccountProvider : JSONModel
@property NSMutableArray<DSHttpGetPersonAccountCompanies>*companies;
@property NSString<Optional>*activeCompanyName;
@end
@implementation DSHttpGetPersonAccountProvider
@end

@protocol DSHttpGetPersonAccountCats;
@interface DSHttpGetPersonAccountCats : JSONModel
@property NSString<Optional>*name;
@property NSString<Optional>*description;
@end
@implementation DSHttpGetPersonAccountCats
@synthesize description;
@end

@protocol DSHttpGetPersonAccountPartners;
@interface DSHttpGetPersonAccountPartners : JSONModel
@property NSString<Optional>*name;
@property NSString<Optional>*description;
@property NSString<Optional>*position;
@property NSString<Optional>*avatar;
@end
@implementation DSHttpGetPersonAccountPartners
@synthesize description;
@end

@protocol DSHttpGetPersonAccountIndividual;
@interface DSHttpGetPersonAccountIndividual : JSONModel
@property NSString<Optional>*followCount;
@property NSString<Optional>*introduction;
@property NSString<Optional>*investMax;
@property NSString<Optional>*investMin;
@property NSString<Optional>*cases;
@property NSMutableArray<DSHttpGetPersonAccountCats>*cats;              ///
@property NSString<Optional>*pv;
@property NSString<Optional>*popular;
@property NSString<Optional>*videoUrl;
@property NSString<Optional>*videoTitle;
@property NSString<Optional>*videoImage;
@property NSString<Optional>*phone;
@property NSString<Optional>*wechat;
@property NSString<Optional>*linkedIn;
@property NSString<Optional>*createTime;
@property NSString<Optional>*cardNo;
@property NSString<Optional>*cardNoFront;
@property NSString<Optional>*cardNoBack;
@property NSString<Optional>*personalAssetsCertificate;
@end
@implementation DSHttpGetPersonAccountIndividual
@end

@protocol DSHttpGetPersonAccountinstitution;
@interface DSHttpGetPersonAccountinstitution : JSONModel
@property NSString<Optional>*followCount;
@property NSString<Optional>*cases;
@property NSString<Optional>*investMin;
@property NSString<Optional>*investMax;
@property NSString<Optional>*company;
@property NSString<Optional>*weichat;
@property NSString<Optional>*adminLogin;
@property NSString<Optional>*mail;
@property NSString<Optional>*videoText;
@property NSString<Optional>*homePage;
@property NSString<Optional>*videoUrl;
@property NSMutableArray<DSHttpGetPersonAccountCats>*cats;
@property NSString<Optional>*id;
@property NSString<Optional>*cardUrl;
@property NSString<Optional>*lincece;
@property NSString<Optional>*phone;
@property NSString<Optional>*institution;
@property NSString<Optional>*videoImg;
@property NSString<Optional>*introduction;
@property NSString<Optional>*logo;
@property NSMutableArray<Optional>*institutioners;
@property NSMutableArray<DSHttpGetPersonAccountPartners>*partners;
@property NSString<Optional>*linkin;
@property NSString<Optional>*address;
@end
@implementation DSHttpGetPersonAccountinstitution
@end


@protocol DSHttpGetPersonAccountinstitutioner;
@interface DSHttpGetPersonAccountinstitutioner : JSONModel
@property NSString<Optional>*phone;
@property NSString<Optional>*login;
@property NSString<Optional>*homePage;
@property NSString<Optional>*weichat;
@property NSString<Optional>*title;
@property NSString<Optional>*instroduction;
@property NSString<Optional>*address;
@property DSHttpGetPersonAccountinstitution<Optional>*institution;
@property NSString<Optional>*investorMin;
@property NSString<Optional>*investorMax;
@property NSString<Optional>*cardUrl;
@property NSMutableArray<DSHttpGetPersonAccountCats>*cats;
@property NSString<Optional>*linkin;
@property NSString<Optional>*name;
@property NSString<Optional>*mail;
@end
@implementation DSHttpGetPersonAccountinstitutioner
@end

@protocol DSHttpGetPersonAccountParkddressDetail;
@interface DSHttpGetPersonAccountParkddressDetail : JSONModel
@property NSString<Optional> *city;
@property NSString<Optional> *detailAddress;
@end
@implementation DSHttpGetPersonAccountParkddressDetail
@synthesize description;
@end



@protocol DSHttpGetPersonAccountPark;
@interface DSHttpGetPersonAccountPark : JSONModel
@property NSString<Optional>*joinCondition;
@property NSString<Optional>*wechat;
@property NSString<Optional>*licence;
@property NSString<Optional>*parkName;
@property NSString<Optional>*vedioUrl;
@property NSString<Optional>*linkdin;
@property NSString<Optional>*card;
@property NSString<Optional>*investService;
@property NSString<Optional>*parkLogo;
@property NSString<Optional>*vedioImg;
@property NSString<Optional>*officeRent;
@property NSString<Optional>*briefIntroduction;
@property NSString<Optional>*vedioTitle;
@property NSString<Optional>*name;
@property NSString<Optional>*id;
@property NSString<Optional>*introductionText;
@property NSString<Optional>*job;
@property NSString<Optional>*email;
@property NSString<Optional>*introducePic;
@property NSString<Optional>*phone;
@property NSString<Optional>*incubationCase;
@property NSString<Optional>*createTime;
@property NSString<Optional>*address;
@property NSMutableArray<DSHttpGetPersonAccountParkddressDetail>*detailAddress;

@end
@implementation DSHttpGetPersonAccountPark
@end



@interface DSHttpGetPersonAccountResultData : JSONModel
@property NSString<Optional>*id;
@property NSString<Optional>*login;
@property NSString<Optional>*avatar;
@property NSString<Optional>*name;
@property NSString<Optional>*role;
@property DSHttpGetPersonAccountinstitutioner<Optional>*institutioner;
@property NSString<Optional>*institutionCreator;
@property DSHttpGetPersonAccountIndividual<Optional> *individual;                 ///
@property DSHttpGetPersonAccountProvider<Optional>*provider;
@property DSHttpGetPersonAccountinstitution<Optional>*institution;
@property DSHttpGetPersonAccountPark<Optional>*park;
@property NSString<Optional>*authorized;
@property NSString<Optional>*createTime;
@property NSString<Optional>*truthRole;
@end
@implementation DSHttpGetPersonAccountResultData
@end


@interface DSHttpGetPersonAccountResult()
@property DSHttpGetPersonAccountResultData *data;
@end


@implementation DSHttpGetPersonAccountCmd (Response)

- (void)onRequestSuccess:(id)request code:(NSInteger)code{
    
    [self.result setResultState:kRequestResultSuccess];
    NSDictionary *dic = (NSDictionary *)request;
    DSHttpGetPersonAccountResult *result = (DSHttpGetPersonAccountResult *)self.result;
    if (code > 199&&code < 299) {
        [self.result setResultState:kRequestResultSuccess];
        NSError *error;
        result.data = [[DSHttpGetPersonAccountResultData alloc]initWithDictionary:dic error:(NSError **)&error];
        if (error) {
            [self onRequestFailed:error];
            return;
        }
    }else{
        
        NSString *memo = [dic objectForKey:@"error_description"];
        [self.result setResultState:kRequestResultFail];
        [self.result setErrMsg:memo];
        NSLog(@"code :%ld errormsg:%@",(long)code,memo);
    }
}

- (void)onRequestFailed:(NSError *)error{
    
    NSLog(@"Error:%@",error);
    [self.result setErrMsg:[error localizedDescription]];
    [self.result setResultState:kRequestResultFail];
}

@end

@implementation DSHttpGetPersonAccountResult

//MARK:----------个人投资方信息
- (DSGetPersonAccountIndividualInfo *)getAllIndividual{
    
    DSGetPersonAccountIndividualInfo *info = [[DSGetPersonAccountIndividualInfo alloc]init];
    info.introduction = self.data.individual.introduction;
    info.investMax = self.data.individual.investMax;
    info.investMin = self.data.individual.investMin;
    info.cases = self.data.individual.cases;
    info.pv = self.data.individual.pv;
    info.popular = self.data.individual.popular;
    info.videoUrl = self.data.individual.videoUrl;
    info.videoTitle = self.data.individual.videoTitle;
    info.videoImage = self.data.individual.videoImage;
    info.phone = self.data.individual.phone;
    info.wechat = self.data.individual.wechat;
    info.linkedIn = self.data.individual.linkedIn;
    info.createTime = self.data.individual.createTime;
    info.cardNo = self.data.individual.cardNo;
    info.cardNoFront = self.data.individual.cardNoFront;
    info.cardNoBack = self.data.individual.cardNoBack;
    info.personalAssetsCertificate = self.data.individual.personalAssetsCertificate;
    info.followCount = self.data.individual.followCount;
    NSMutableArray *catList = [NSMutableArray array];
    for (int i = 0; i<self.data.individual.cats.count; i++) {
        DSGetPersonAccountCatsInfo *info = [[DSGetPersonAccountCatsInfo alloc]init];
        DSHttpGetPersonAccountCats *webCatInfo = self.data.individual.cats[i];
        info.catName = webCatInfo.name;
        info.descriptions = webCatInfo.description;
        [catList addObject:info];
    }
    info.cats = catList;
    
    return info;
}

//MARK:-------项目方信息
- (DSGetPersonAccountProviderInfo *)getAllProvider{
    
    DSGetPersonAccountProviderInfo *info = [[DSGetPersonAccountProviderInfo alloc]init];
    info.companies = [self.getAllCompanies mutableCopy];
    info.activeCompanyName = self.data.provider.activeCompanyName;
    
    return info;
}

- (NSMutableArray *)getAllCompanies{
    NSMutableArray *list = [NSMutableArray array];
    
    for (int i = 0; i<self.data.provider.companies.count; i++) {
        DSGetPersonAccountCompaniesInfo *info = [[DSGetPersonAccountCompaniesInfo alloc]init];
        DSHttpGetPersonAccountCompanies *webInfo = self.data.provider.companies[i];
        info.myName = webInfo.myName;
        info.licenceUrl = webInfo.licenceUrl;
        info.name = webInfo.name;
        info.address = webInfo.address;
        [list addObject:info];
    }
    
    return list;
}

- (DSGetPersonAccountInstitutionInfo *)getAllInstitution{
    
    DSGetPersonAccountInstitutionInfo *info = [[DSGetPersonAccountInstitutionInfo alloc]init];
    info.cases = self.data.institutioner.institution.cases;
    info.investMin = self.data.institutioner.institution.investMin;
    info.investMax = self.data.institutioner.institution.investMax;
    info.company = self.data.institutioner.institution.company;
    info.weichat = self.data.institutioner.institution.weichat;
    info.adminLogin = self.data.institutioner.institution.adminLogin;
    info.mail = self.data.institutioner.institution.mail;
    info.videoText = self.data.institutioner.institution.videoText;
    info.homePage = self.data.institutioner.institution.homePage;
    info.videoUrl = self.data.institutioner.institution.videoUrl;
    info.cats = self.data.institutioner.institution.cats;
    info.id = self.data.institutioner.institution.id;
    info.cardUrl = self.data.institutioner.institution.cardUrl;
    info.lincece = self.data.institutioner.institution.lincece;
    info.phone = self.data.institutioner.institution.phone;
    info.institution = self.data.institutioner.institution.institution;
    info.videoImg = self.data.institutioner.institution.videoImg;
    info.introduction = self.data.institutioner.institution.introduction;
    info.logo = self.data.institutioner.institution.logo;
    info.institutioners = self.data.institutioner.institution.institutioners;
    info.partners = self.data.institutioner.institution.partners;
    info.linkin = self.data.institutioner.institution.linkin;
    info.address = self.data.institutioner.institution.address;
    
    return info;
}

- (DSGetPersonAccountInstitutionInfo *)getAllInstitutions{
    
    DSGetPersonAccountInstitutionInfo *info = [[DSGetPersonAccountInstitutionInfo alloc]init];
    info.cases = self.data.institution.cases;
    info.investMin = self.data.institution.investMin;
    info.investMax = self.data.institution.investMax;
    info.company = self.data.institution.company;
    info.weichat = self.data.institution.weichat;
    info.adminLogin = self.data.institution.adminLogin;
    info.mail = self.data.institution.mail;
    info.videoText = self.data.institution.videoText;
    info.homePage = self.data.institution.homePage;
    info.videoUrl = self.data.institution.videoUrl;
    info.followCount = self.data.institution.followCount;
    NSMutableArray *catList = [NSMutableArray array];
    for (int i = 0; i<self.data.institution.cats.count; i++) {
        DSGetPersonAccountCatsInfo *infos = [[DSGetPersonAccountCatsInfo alloc]init];
        DSHttpGetPersonAccountCats *webCatInfo = self.data.institution.cats[i];
        infos.catName = webCatInfo.name;
        infos.descriptions = webCatInfo.description;
        [catList addObject:infos];
    }
    info.cats = catList;
    info.id = self.data.institution.id;
    info.cardUrl = self.data.institution.cardUrl;
    info.lincece = self.data.institution.lincece;
    info.phone = self.data.institution.phone;
    info.institution = self.data.institution.institution;
    info.videoImg = self.data.institution.videoImg;
    info.introduction = self.data.institution.introduction;
    info.logo = self.data.institution.logo;
    info.institutioners = self.data.institution.institutioners;
    //info.partners = self.data.institution.partners;
    
    NSMutableArray *perList = [NSMutableArray array];
    for (int i = 0; i<self.data.institution.partners.count; i++) {
        DSGetPersonAccountPartnersInfo *infos = [[DSGetPersonAccountPartnersInfo alloc]init];
        DSHttpGetPersonAccountPartners *webCatInfo = self.data.institution.partners[i];
        infos.name = webCatInfo.name;
        infos.descriptions = webCatInfo.description;
        infos.position = webCatInfo.position;
        infos.avatar = webCatInfo.avatar;
        [perList addObject:infos];
    }
    info.partners = perList;
    info.linkin = self.data.institution.linkin;
    info.address = self.data.institution.address;
    
    return info;
}

//MARK:----------投资机构下的个人信息
- (DSGetPersonAccountInstitutionerInfo *)getAllInstitutioner{
    
    DSGetPersonAccountInstitutionerInfo *info = [[DSGetPersonAccountInstitutionerInfo alloc]init];
    info.phone = self.data.institutioner.phone;
    info.login = self.data.institutioner.login;
    info.homePage = self.data.institutioner.homePage;
    info.weichat = self.data.institutioner.weichat;
    info.title = self.data.institutioner.title;
    info.instroduction = self.data.institutioner.instroduction;
    info.institution = [self getAllInstitution];
    info.investorMin = self.data.institutioner.investorMin;
    info.investorMax = self.data.institutioner.investorMax;
    info.cardUrl = self.data.institutioner.cardUrl;
    info.linkin = self.data.institutioner.linkin;
    info.name = self.data.institutioner.name;
    info.mail = self.data.institutioner.mail;
    
    NSMutableArray *catList = [NSMutableArray array];
    for (int i = 0; i<self.data.institutioner.cats.count; i++) {
        DSGetPersonAccountCatsInfo *info = [[DSGetPersonAccountCatsInfo alloc]init];
        DSHttpGetPersonAccountCats *webCatInfo = self.data.institutioner.cats[i];
        info.catName = webCatInfo.name;
        info.descriptions = webCatInfo.description;
        [catList addObject:info];
    }
    info.cats = catList;
    
    return info;
}

//MARK:----------投资机构下的个人信息
- (DSGetPersonAccountParkInfo *)getAllPark{
   DSGetPersonAccountParkInfo *info = [[DSGetPersonAccountParkInfo alloc]init];
    info.joinCondition = self.data.park.joinCondition ;
    info.wechat = self.data.park.wechat;
    info.licence = self.data.park.licence;
    info.parkName = self.data.park.parkName;
    info.vedioUrl = self.data.park.vedioUrl;
    info.linkdin = self.data.park.linkdin;
    info.card = self.data.park.card;
    info.investService = self.data.park.investService;
    info.parkLogo = self.data.park.parkLogo;
    info.vedioImg = self.data.park.vedioImg;
    info.officeRent = self.data.park.officeRent;
    info.briefIntroduction = self.data.park.briefIntroduction;
    info.vedioTitle = self.data.park.vedioTitle;
    info.name = self.data.park.name;
    info.id = self.data.park.id;
    info.introductionText = self.data.park.introductionText;
    info.job = self.data.park.job;
    info.email = self.data.park.email;
    info.introducePic = self.data.park.introducePic;
    info.phone = self.data.park.phone;
    info.incubationCase = self.data.park.incubationCase;
    info.createTime = self.data.park.createTime;
    info.address = self.data.park.address;
    for (int j=0; j<self.data.park.detailAddress.count; j++) {
        DSHttpGetPersonAccountParkddressDetail *webAddress = self.data.park.detailAddress[j];
        DSParkListDetailAddressinfo *addressInfo = [[DSParkListDetailAddressinfo alloc]init];
        addressInfo.city = webAddress.city;
        addressInfo.detailAddress = webAddress.detailAddress;
        //info.detailAddressArray
        [info.detailAddress addObject:addressInfo];
    }
   return info;
}


//MARK:------------全部信息
- (NSMutableArray *)getAllData{
    NSMutableArray *arr = [NSMutableArray array];
    
    DSGetPersonAccountInfo *info = [[DSGetPersonAccountInfo alloc]init];
    info.id = self.data.id;
    info.login = self.data.login;
    info.avatar = self.data.avatar;
    info.name = self.data.name;
    info.role = self.data.role;
    
    info.institutioner = self.getAllInstitutioner;  //投资机构下的个人信息
    info.institution = [self getAllInstitutions];       //投资机构方
    info.individual = [self getAllIndividual];        //个人投资方
    info.provider = [self getAllProvider];             //项目方
    
    info.institutionCreator = self.data.institutionCreator;
    
    info.park = [self getAllPark];                     //园区方
    
    info.authorized = self.data.authorized;
    info.createTime = self.data.createTime;
    info.truthRole = self.data.truthRole;
    
    [arr addObject:info];
    return arr;
}
@end

