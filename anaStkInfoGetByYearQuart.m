function stkInfo = anaStkInfoGetByYearQuart(stkId, year, quart)
stkInfo = []; %open/high/close/low/vol/amount/weight

url = sprintf(['http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_FuQuanMarketHistory/stockid/%06d'...
    '.phtml?year=%d&jidu=%d'], stkId, year, quart);

%     fprintf('[URL]%s. \r\n', url);
[srcFile, status] = urlread(url);
if ~status
    fprintf('[ERROR]read url failed while get single stk info, stk id = %d. \r\n', stkId);
end

expr1 = '\s+(\d\d\d\d-\d\d-\d\d)\s*'; %get date info
[~, dateTokens]= regexp(srcFile, expr1, 'match', 'tokens');

if isempty(dateTokens)
    fprintf('[ERROR]data is empty while get single stk info, stk id = %d. \r\n', stkId);
    return;
end

expr2 = '<div align="center">(\d*\.?\d*)</div>'; %获取交易数据
[~, dataTokens] = regexp(srcFile, expr2, 'match', 'tokens');

%7 represent 7 num, open/high/close/low/vol/amount/weight
dataTokens = reshape(dataTokens, 7, length(dataTokens)/7)';

for col = 1:length(dateTokens)
    stkInfo(col,1) = datenum(dateTokens{col}(1));
    for row = 1:size(dataTokens,2)
        stkInfo(col,row+1) = str2double(dataTokens{col,row});
    end
end
