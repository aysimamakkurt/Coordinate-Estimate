function [sat] = read_sp3file(f_orbit)

[fid,errmsg] = fopen(f_orbit);

if any(errmsg)
    errordlg('SP3 file can not be opened.','SP3 file error');
    error   ('SP3 file error');
end

sn  = 32;
sat = NaN(96,4,sn);

while ~feof(fid)
    line = fgetl(fid);
    if strcmp(line(1),'#') && ~strcmp(line(1:2),'##')
        dat = sscanf(line(4:14),'%f');
    end
    if strcmp(line(1:2),'##')
        sp3int = sscanf(line(25:38),'%f');
        epno   = 86400/sp3int; 
        sat    = NaN(epno,4,sn);
    end
    
    if line(1)=='+'
        temp = sscanf(line(5:6),'%d');
        if ~isnan(temp)
            NoSat = temp;
        end
    end
    
    % new epoch
    if line(1)=='*'
        ep   = sscanf(line(2:end),'%f',[1,6]);
        if ep(1)~=dat(1) || ep(2)~=dat(2) || ep(3)~=dat(3)
            continue
        end
        epno = ((ep(4)*3600 + ep(5)*60 + ep(6))/sp3int)+1;
        for k=1:NoSat
            line = fgetl(fid);
            if strcmp(line(2),'G')
                sno  = sscanf(line(3:4),'%d');
                if sno>32
                    continue
                else
                    temp = sscanf(line(5:end),'%f',[1,4]);
                    % writing part
                    sat(epno,1:3,sno) = temp(1:3)*1000; %meter
                    sat(epno,  4,sno) = temp(4)*10^-6;  %second 
                end
            end
        end        
    end
end
fclose('all');
end