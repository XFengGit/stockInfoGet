function stkInfo = anaStkInfoGetByTime(stkId, strBeginTime, strEndTime)
stkInfo = [];
iBeginTime = datenum(strBeginTime);
iEndTime = datenum(strEndTime);
beginDate = datevec(iBeginTime);
endDate = datevec(iEndTime);
beginYear = beginDate(1);
endYear = endDate(1);

if iBeginTime>iEndTime
    error('begin time %s bigger than end time %s.', strBeginTime, strEndTime);
end

for i = beginYear:endYear
    for j = 1:4
        stkInfoTmp = anaStkInfoGetByYearQuart(stkId, i, j);
        stkInfo = [stkInfoTmp; stkInfo];
    end
end

stkInfo = stkInfo(stkInfo(:,1)<=iEndTime & stkInfo(:,1)>=iBeginTime,:);
