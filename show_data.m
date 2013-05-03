function show_data(data,~,axes, parameter, minAlpha,maxAlpha, showUnstable,initialColor,network)

global networkNumber;
networkNumber = network;
global offset;
global alphaOffset;

if(networkNumber == 1)
    offset = 0;%.1;
    data = data + offset;
    alphaOffset = 0;%10;
    data(4,:) = data(4,:) + alphaOffset;
end

%this needed to be changed because plots with many line segments seem to
%have problems

initStability=1;
ourColor = initialColor;

%get a colormap for 8 lines to be drawn (line segments for us)
clr = colormap(lines(9));
clr(1,:) = 0; %after 7 we start getting repeat colors but never black
clr(7,:) = [.5;.5;.5];
clr(9,:) = [.75;.75;.75];

% clr = [
%          0         0         0
%          0    0.5000         0
%     1.0000         0         0
%          0    0.7500    0.7500
%     0.7500         0    0.7500
%     0.7500    0.7500         0
%     0.5000    0.5000    0.5000
%          0         0    1.0000
%     0.7500    0.7500    0.7500];

% clr = [        
%          0         0         0
%        0.1       0.1      0.80
%          0      0.75      0.75
%       1.00         0         0
%       0.50         0         0
%          0      0.50      0.50
%        0.1       0.1    0.3500
%     0.7500    0.7500    0.7500
%       0.50      0.50      0.50];

clr = [
         0         0         0
         0    0.5000         0
    1.0000         0         0
         0         0    1.0000
    0.7500    0.7500         0
         0    0.7500    0.7500
    0.7500         0    0.7500
    0.7500    0.7500    0.7500
    0.5000    0.5000    0.5000];


%figure-specific hacks
startAt = 1;
endAt = 1;
if(ourColor ==3)
    startAt = 1373;
end

if(networkNumber ==1)
   startAt = 1;
   %the ret -+- line seems to have some problems here, it looks like it
   %loops back
   endAt = 100;
   
   if(initialColor ==1)
       startAt = 1970;
       %the ret -+- line seems to have some problems here, it looks like it
       %loops back
       endAt = 1000;
   end
end

startInd = startAt;
endInd = 1;

for i = startAt:(size(data,2)/1)-endAt
    
    newColor = bin2Decimal(getColor(data(1:3,(i))));
    %if we are out of the alpha range then flush our points, if we have no
    %points do nothing
    if(data(parameter,(i)) < minAlpha || data(parameter,(i)) > maxAlpha ...
            || (ourColor-1) ~= newColor)
        col = clr(ourColor,:);
        if(ourColor-1 ~= newColor)
            endInd = (i); 
        end
     %   endInd = (i);
        if( initStability || showUnstable)
            %this is a nasty hack around the fact that our colors are bound
            %as binary opposites around 4 then the sum mod 8 = the lower
            %and we only draw from the lower
            if(initStability && mod(ourColor + initialColor,8) ~=1)
                ourColor  = initialColor;
            end
            if(~initStability)
               ourColor = initialColor; 
            end
            col = clr(ourColor,:);
            drawPoints(data,axes,startInd,endInd,col,initStability);
        end
        startInd=(i);    
        initStability = isAttractor(data(1:3,startInd),data(4,startInd),networkNumber);
        %        newColor = getColor(data(:,startInd),axes);
        %        color = newColor;
        ourColor = newColor+1;
        continue;
    end
    
    endInd = (i);
    
    
    %if the first 3 fields are negative then it is an attractor, else it is
    %not
    isStable = isAttractor(data(1:3,endInd),data(4,endInd),networkNumber);
    %    newColor = getColor(data(:,endInd),axes);
    
    %if the stability changed draw all of our points and prepare for the
    %next loop, otherwise add our points to the list
    %    if(initStability == isStable && isequal(newColor,color))
    if(initStability == isStable)
        %if(length(find(s(i).data.eval<0))==3)
        %        line(x_coordinates, y_coordinates, z_coordinates,'color',clr,'linewidth',1.5)
    else
        %   drawPoints(data,axes,startInd,endInd,clr,initStability);
        col = clr(ourColor,:);
        if( initStability || showUnstable)
            if(initStability && mod(ourColor + initialColor,8) ~=1)
                ourColor  = initialColor;
            end
            if(~initStability)
               ourColor = initialColor; 
            end
            col = clr(ourColor,:);
            drawPoints(data,axes,startInd,endInd,col,initStability);
            if(~initStability)
               ourColor = newColor+1; 
            end
        end
        startInd=(i);
        initStability = isStable;
        %        color = newColor;
    end
end

col = clr(ourColor,:);
if( initStability || showUnstable)
    drawPoints(data,axes,startInd,endInd,col,initStability);
end

end

function drawPoints(data,axes,startInd,endInd,clr,stable)

%is alpha one of the axes we are using?
alphaPresent = max(axes ==4);

handle = -1;

if(length(axes) ==3)
    if(startInd < endInd)
        x_coordinates = data(axes(1),startInd:endInd);
        y_coordinates = data(axes(2),startInd:endInd);
        z_coordinates = data(axes(3),startInd:endInd);
        if(stable)
            if(alphaPresent)
                handle = line(z_coordinates, x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
            else
                handle = line(x_coordinates, y_coordinates, z_coordinates,'color',clr,'linewidth',1.5);
            end
        else
            %we only care able stable steady states
            if(alphaPresent)
                handle = line(z_coordinates, x_coordinates, y_coordinates,'color',clr,'linewidth',.2);
            else
                handle = line(x_coordinates, y_coordinates, z_coordinates,'color',clr,'linewidth',.2);
            end
        end
        updateAxes(axes,alphaPresent);
    end
elseif(length(axes) ==2)
    if(startInd < endInd)
        x_coordinates = data(axes(1),startInd:endInd);
        y_coordinates = data(axes(2),startInd:endInd);
        if(stable)
            if(alphaPresent)
                handle = line(x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
            else
                handle = line(x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
            end
        else
            %we only care able stable steady states
            if(alphaPresent)
                handle = line(y_coordinates, x_coordinates,'color',clr,'linewidth',.2);
            else
                handle = line(x_coordinates, y_coordinates, 'color',clr,'linewidth',.2);
            end
        end
        updateAxes(axes,alphaPresent);
    end
    
end

if(~stable && handle > 0)
    hasbehavior(handle,'legend',false);
end

end

function updateAxes(axes,alphaPresent)

global offset;
global alphaOffset;

names = ['X','Y','Z','A'];
set(gca,'XGrid','on','YGrid','on','ZGrid','on','XMinorGrid','off','YMinorGrid','off','ZMinorGrid','off')
set(gca,'fontsize',18)

%net 84 A vs X possibility 1
%set(gca,'Xscale','log','Yscale','log','Zscale','log')
%axis([.6 8 .01 2 .01 2])

%net 84 A vs X possibility 2, looks awkward
%axis([-.1 2 -.1 2 -.1 2])
%set(gca,'Xscale','log','Yscale','log','Zscale','log')

%net 1
set(gca,'Xscale','log','Yscale','log','Zscale','log')
% axis([.8 100 .8 100 .8 100])
axis([9 100 1 100 1 100])
axis([(alphaOffset+offset-1) 100 offset 100 offset 100])

%net 1 
%axis([-.1 30 -.1 30 -.1 30])


if(alphaPresent == 0)
    xlabel(names(axes(1)),'fontsize',18)
    ylabel(names(axes(2)),'fontsize',18)
    if(length(axes)==3)
        zlabel(names(axes(3)),'fontsize',18)
    end
else
    if(length(axes)==3)
        xlabel(names(axes(3)),'fontsize',18)
        ylabel(names(axes(1)),'fontsize',18)
        zlabel(names(axes(2)),'fontsize',18)
    else
        xlabel(names(axes(2)),'fontsize',18)
        ylabel(names(axes(1)),'fontsize',18)
    end
    
end

end

%this works only if we are bifurcating on alpha (auto-activation) and it will
%return whether a point is an attractor for the provided alpha
function [isStable] = isAttractor(xIn,a,network)
global networkNumber;
global offset;

a = [a,.1,.1];
b = [.1,a,.1];
c = [.1,.1,a];

if(networkNumber == 1)
    x = xIn;
    x = x-offset;
else
    x = xIn;
end

fn = ['network' num2str(network)];
fh = str2func(fn);

[~,jac] = fh(x,a,b,c);

eigenValues = eig(jac);

if(length(find(eigenValues<0))==3)
    isStable = 1;
else
    isStable = 0;
end


end

%return the color which is RGB mapped onto the 3 dimensions chosen by axes
%scale by alpha regardless of the axes
function [color] = getColor(dataRow,axes)
global networkNumber;
global offset;

if(networkNumber == 1)
    row = dataRow;
%    row = row-offset;
else
    row = dataRow;
end

possibilities = [row(1:3) ; .0001];
%color = round(dataRow(1:3)/max(possibilities));

color = round(round(row(1:3))/max(possibilities));

for i=1:3
   if(color(i) > 1)
       color(i) = 1;
   end
end

%dataRow
%color

end

%needs a row vector of binary values and it returns a decimal number
function [dec] = bin2Decimal(binary)

%is this a column vector ? row-ify it if so
if(size(binary,1)>1)
    binary = binary';
end

%we use binary backwards(MSB <->LSB) compared to this script
binary= fliplr(binary);

dec = sum(binary.*2.^(numel(binary)-1:-1:0));
end

