%anaStkInfoAll
stkInfoAll = [];
strBeginTime = '2006-01-01';
strEndTime = '2016-07-09';

for i = 1:(length(stkIdAll)/2)
    stkId = stkIdAll(i);
    if stkId > 300000 && stkId < 600000
        continue;
    end
    stkData = anaStkInfoGetByTime(stkId, strBeginTime, strEndTime);
    stkInfo = struct('stkId',stkId,'stkData',stkData);
    stkInfoAll = [stkInfoAll;stkInfo];
end