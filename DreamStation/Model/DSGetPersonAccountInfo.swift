//
//  DSGetPersonAccountInfo.swift
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/30.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

class DSGetPersonAccountInfo: JSONModel {

    var id:String?
    var login:String?
    var avatar:String?
    var name:String?
    var role:String?
    var institutioner:DSGetPersonAccountInstitutionerInfo?       //投资机构下的子账户
    var institutionCreator:String?
    var individual:DSGetPersonAccountIndividualInfo?
    var provider:DSGetPersonAccountProviderInfo?
    var institution:DSGetPersonAccountInstitutionInfo?
    var park:DSGetPersonAccountParkInfo?
    var authorized:String?
    var createTime:String?
    var truthRole:String?
    
}

//MARK:------个人
class DSGetPersonAccountIndividualInfo:JSONModel{
    /// 简介
    var introduction:String?
    /// 最大额度
    var investMax:String?
    /// 最小额度
    var investMin:String?
    /// 过往案例
    var cases:String?
    /// 细则
    var cats:NSMutableArray?    //DSGetPersonAccountCatsInfo
    var followCount:String?
    var pv:String?
    var popular:String?
    var videoUrl:String?
    var videoTitle:String?
    var videoImage:String?
    var phone:String?
    
    /// 微信
    var wechat:String?
    var linkedIn:String?
    var createTime:String?
    /// 身份证号
    var cardNo:String?
    /// 身份证正面
    var cardNoFront:String?
    /// 身份证背面
    var cardNoBack:String?
    /// 个人资产
    var personalAssetsCertificate:String?
}
class DSGetPersonAccountCatsInfo: NSObject {
    var catName:String?
    var descriptions:String?
}
class DSGetPersonAccountPartnersInfo: NSObject {
    var name:String?
    var descriptions:String?
    var position:String?
    var avatar:String?
}
//MARK:-------项目方
class DSGetPersonAccountProviderInfo:JSONModel{
    var activeCompanyName:String?
    var companies:NSMutableArray?
}
class DSGetPersonAccountCompaniesInfo:NSObject{
    
    /// 姓名
    var myName:String?
    /// 营业执照
    var licenceUrl:String?
    /// 公司名称
    var name:String?
    /// 公司地址
    var address:String?
}

//MARK:------投资机构下的子账户
class DSGetPersonAccountInstitutionerInfo:JSONModel{
    
    var phone:String?
    var login:String?
    var homePage:String?
    var weichat:String?
    var title:String?
    var instroduction:String?
    var institution:DSGetPersonAccountInstitutionInfo?
    var investorMin:String?
    var investorMax:String?
    var cardUrl:String?
    var cats:NSMutableArray?
    var linkin:String?
    var name:String?
    var mail:String?

}

class DSGetPersonAccountInstitutionInfo:JSONModel{

    var cases:String?
    var investMin:String?
    var investMax:String?
    var company:String?
    var weichat:String?
    var adminLogin:String?
    var mail:String?
    var videoText:String?
    var homePage:String?
    var videoUrl:String?
    var cats:NSMutableArray?
    var id:String?
    var cardUrl:String?
    var lincece:String?
    var phone:String?
    var institution:String?
    var videoImg:String?
    var introduction:String?
    var logo:String?
    var institutioners:NSMutableArray?
    var partners:NSMutableArray?
    var linkin:String?
    var address:String?
    var followCount:String?
}

class DSGetPersonAccountParkInfo:JSONModel{
    
    var joinCondition:String?
    var wechat:String?
    var licence:String?
    var parkName:String?
    var vedioUrl:String?
    var linkdin:String?
    var card:String?
    var investService:String?
    var parkLogo:String?
    var vedioImg:String?
    var officeRent:String?
    var briefIntroduction:String?
    var vedioTitle:String?
    var name:String?
    var id:String?
    var introductionText:String?
    var job:String?
    var email:String?
    var introducePic:String?
    var phone:String?
    var incubationCase:String?
    var createTime:String?
    var address:String?
    var detailAddress = NSMutableArray()
    
}
