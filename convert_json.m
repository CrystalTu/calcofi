% Convert the CalCOFI structure array data
% Crystal 2015/06/04

load data/adj_space_quarter_data1951_2007.mat

% Change the sequence of structure array into: sp, adj_sta_pos,
% quarter_cruise_season, crdata

for n=1:67
   temp=data(1,n);
   output(1,n).sp=temp.sp;
   output(1,n).adj_sta_pos=data(1,1).adj_sta_pos;
   output(1,n).quarter_cruise_season=data(1,1).quarter_cruise_season;
   output(1,n).crdata=temp.crdata;
end

json=savejson('',output,'adj_space_quarter_data1951_2007.json');
