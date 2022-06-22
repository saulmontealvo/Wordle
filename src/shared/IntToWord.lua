function ToWord(value, context)
    context = context or { financial = false; scale = 'long'; decimal = 0; };
    context = { scale = context.scale or 'long'; decimal = context.decimal or 0; };
    local numbers =
        {
            ones = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
            tens = { '', "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };
            thousands =
            {
                short = { "Thousand", "Million", "Billion", "Trillion", "Quadrillion", "Quintillion", "Sextillion", "Septillion" };
                long = { "Thousand", "Tillion", "Thousand million", "Billion", "Thousand billion", "Trillion", "Thousand trillion", "Quadrillion" };
            };
            decimal =
            {
                short = { "Thousandth", "Millionth", "Billionth", "Trilionth", "Wuadrillionth", "Sextillionth", "Septillionth" };
                long = { "Thousandth", "Millionth", "Thousand-millionth", "Billionth", "Thousand-billionth", "Trilionth", "Thousand-trillionth", "Quadrillionth" };
            };
        };

    local function _raw_convert(n)
        local r = { };
        for i = #n, 1, -3 do
            local val_p = tonumber(n:sub(math.max(i - 2, 1), i));
            local val_p_r = numbers.ones[val_p];
            if not val_p_r then
                if val_p >= 20 then
                    local h = '';
                    if val_p >= 100 then
                        h = numbers.ones[math.floor(val_p / 100)] .. ' hundred and ';
                    end;
                    val_p_r = h .. (numbers.tens[math.floor((val_p % 100) / 10)] or '') .. '-' .. (numbers.ones[val_p % 10] or '');
                end;
            end;
            val_p_r = (val_p_r or ''):gsub("[- ]+$", "");
            if val_p_r ~= '' then
                val_p_r = val_p_r .. ' ' .. (numbers.thousands[context.scale][(#n - i) / 3] or '');
                table.insert(r, 1, (val_p_r:gsub("[- ]+$", "")));
            end;
        end;
        return table.concat(r, ', ');
    end;

    if type(value) == 'number' then
        value = ("%.99f"):format(value);
    end;
    local int_v, frac_v = value:match("(%d*)[.]?(%d*)");
    local int_r = _raw_convert(int_v:gsub("^0+", ''));
    local frac_r;

    frac_v = frac_v:gsub("0+$", '');
    local frac_r = '';
    if #frac_v > 0 then
        if context.decimal == 0 and not context.financial then
            frac_r = { };
            for n in frac_v:gmatch('%d') do
                table.insert(frac_r, numbers.ones[tonumber(n)]);
            end;
            frac_r = table.concat(frac_r, ' ');
        elseif context.decimal == 1 and not context.financial then
            local d = "tenth";
            if #frac_v == 2 then
                d = "hundredth";
            elseif #frac_v > 2 then
                d = (((#frac_v % 3) == 2 and 'hundred-') or ((#frac_v % 3) == 1 and 'ten-') or '') .. (numbers.decimal[context.scale][math.floor(#frac_v / 3)] or '');
            end;
            frac_r = _raw_convert(frac_v)
            if frac_r ~= '' then
                frac_r = frac_r .. ' ' .. d .. ((frac_v:gsub("[13579]", '') == frac_v) and '' or 's');
            end;
        else
            frac_r = frac_v:gsub("^0+", '') .. '/1' .. ('0'):rep(#frac_v);
        end;
    end;

    if int_r == '' and ((context.decimal == 0) or (#frac_r == 0)) then
        int_r = 'zero';
    end;

    if #frac_r == 0 then
        local toSend = int_r.."."
        return(toSend);
    else
        return ("%s %s %s"):format(int_r, context.decimal == 0 and 'point' or 'and', frac_r);
    end;
end;

return function (number)
    local a =  ToWord(number);
    -- remove the . from the end of the string
    a = a:gsub("%.$", "");
    return a;
end