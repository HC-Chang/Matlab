function  t_d()
tic
%%  檔案設定
%file = fopen('data.csv');
file = fopen('1.csv');

% x,y,z 軸 代表項目
xLabel = 'Longitude';
yLabel = 'Latitude';
zLabel = 'SOG';

%%
line_string = fgets(file);

fields = '';
for i = 1:length(line_string)
    fields = strcat(fields,line_string(1,i));
end

fields = regexp(fields, ',', 'split');

% x,y,z 軸 對應 col
x = 0;
y = 0;
z = 0;
for i = 1:length(fields)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %disp( fields(1,i) )
    if( strcmp( fields(1,i),xLabel))
        x = i;
    end
    if(strcmp( fields(1,i),yLabel))
        y = i;
    end
    if(strcmp( fields(1,i),zLabel))
        z = i;
    end
end

%%

x_plot = [];
y_plot = [];
z_plot = [];

figure
grid on
hold on

count = 0;
while(feof(file) == 0)
    line_string = fgets(file);

    fields = '';
    for i = 1:length(line_string)
        fields = strcat(fields,line_string(1,i));
    end
    
    fields = regexp(fields, ',', 'split');
    
    x_plot = [x_plot; str2double(fields(1,x))];
    y_plot = [y_plot; str2double(fields(1,y))];
    z_plot = [z_plot; str2double(fields(1,z))];
    count = count+1;
    
    % 固定筆數資料繪圖
    if(rem(count,500) == 0)
        scatter3(x_plot(:,1),y_plot(:,1),z_plot(:,1),'filled','MarkerEdgeColor','k','MarkerFaceColor','b')
        x_plot = [];
        y_plot = [];
        z_plot = [];
    end
end

if( ~isempty(x_plot) && ~isempty(y_plot) && ~isempty(z_plot))
    scatter3(x_plot(:,1),y_plot(:,1),z_plot(:,1),'filled','MarkerEdgeColor','k','MarkerFaceColor','b')
    x_plot = [];
    y_plot = [];
    z_plot = [];
end

xlabel(xLabel,'FontSize',16,'FontWeight','bold')
ylabel(yLabel,'FontSize',16,'FontWeight','bold')
zlabel(zLabel,'FontSize',16,'FontWeight','bold')

count

toc

view([30,30])