
# 使用方法

## 1、初始化
    LogManager.init(
        config: LogConfig(enable: true,globalTag: "TAG",stackTraceDepth: 5),
        printers: [ConsolePrint()]
    );
## 2、样例
    Map<String ,dynamic > logDic = {
        "RequestData": {
        "examId": 606, "operationSheetId": 578, "operationPersonId": 444,
            "operationItemScoreListTos": [
            {"deductScore": 2, "itemId": 9677, "score": 2, "reason": "res"},
            {"deductScore": 2, "itemId": 9678, "score": 2, "reason": "12323"},
            {"deductScore": 4, "itemId": 9679, "score": 4, "reason":"415" },
            {"deductScore": 4, "itemId": 9680, "score": 4, "reason": "45454"},
            {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流3"},
            {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "56adfs"},
            {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "asgh"},
            {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "assuage"},
            {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"asfgasgaewegeag" },
            {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"大家晚上好，交流圈的问题已经回复啦，群19点后禁言" },
            {"deductScore": 2, "itemId": 9671, "score": 2, "reason": "res"},
            {"deductScore": 2, "itemId": 9672, "score": 2, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
            {"deductScore": 4, "itemId": 9683, "score": 4, "reason":"大家晚上好，交流圈的问题已经回复啦，群19点后禁言" },
            {"deductScore": 4, "itemId": 9684, "score": 4, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
            {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "大家晚上好"},
            {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "大家晚上好"},
            {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
            {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
            {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
            {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
            {"deductScore": 2, "itemId": 9677, "score": 2, "reason": "res"},
            {"deductScore": 2, "itemId": 9679, "score": 2, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9682, "score": 4, "reason":"v" },
            {"deductScore": 4, "itemId": 9684, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
            {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
            {"deductScore": 2, "itemId": 9677, "score": 2, "reason": "res"},
            {"deductScore": 2, "itemId": 9679, "score": 2, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9682, "score": 4, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
            {"deductScore": 4, "itemId": 9684, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
            {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "大家晚上好"},
            {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "大家晚上好"},
            {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "大家晚上好"},
            {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "大家晚上好"},
            {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"大家晚上好" },
            {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"大家晚上好" },
            ]
        }
    };
LogUtil.E(tag: 'JSON',json: logDic);