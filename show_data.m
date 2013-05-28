function show_data(data,~,axes, parameter, minAlpha,maxAlpha, showUnstable,initialColor,network)

global networkNumber;
networkNumber = network;
global offset;
global alphaOffset;

offset=0;
alphaOffset=0;

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
    %for .09 const
   %startAt = 100;
   %endAt = 1300;
   
   startAt = 1;
   endAt = 1;
   %the ret -+- line seems to have some problems here, it looks like it
   %loops back
   
   if(initialColor ==1)
       if(showUnstable)
           startAt = 1970;
           %the ret -+- line seems to have some problems here, it looks like it
           %loops back
           endAt = 1000;
       end
   end
   
elseif(networkNumber==84)
    startAt = 100;
    endAt = 100;
    
end

startInd = startAt;
endInd = 1;

for i = startAt:(size(data,2)/1)-endAt
    
    if(networkNumber ==1)
        newColor = ourColor-1;
    else
        newColor = bin2Decimal(getColor(data(1:3,(i))));
    end
    %if we are out of the alpha range then flush our points, if we have no
    %points do nothing
    if(data(parameter,(i)) < minAlpha || data(parameter,(i)) > maxAlpha ...
            || (ourColor-1) ~= newColor)
        col = clr(ourColor,:);
        if(ourColor-1 ~= newColor)
            endInd = (i); 
        end
     %   endInd = (i);
     
     if(data(parameter,(i)) > maxAlpha && data(parameter,(i)) < maxAlpha+.1 && isAttractor(data(1:3,i),data(4,i),networkNumber))
        fprintf('parameter leaving alpha range for initial color %d, a:%f, x:%f, y:%f, z:%f\n',initialColor,data(4,(i)),data(1,(i)),data(2,(i)),data(3,(i)));
     end
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
            if(endInd - startInd >2)
                fprintf('parameter leaving alpha range for color %d, start %d, end %d\n',ourColor,startInd,endInd);
                col = clr(ourColor,:);
                drawPoints(data,axes,startInd,endInd,col,initStability);
            end
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
            fprintf('parameter changing stability for color %d, start %d, end %d\n',ourColor,startInd,endInd);
            
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

if(endInd - startInd < 2)
    return;
end

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
global networkNumber;

names = ['X','Y','Z','A'];
set(gca,'XGrid','on','YGrid','on','ZGrid','on','XMinorGrid','off','YMinorGrid','off','ZMinorGrid','off')
set(gca,'fontsize',18)


%net 1
if(networkNumber ==1)
    set(gca,'Xscale','log','Yscale','log','Zscale','log')
    axis([(alphaOffset*.9+offset*.9)+.1 100 offset*.9+.1 100 offset*.9+.1 100])

%    axis([0 5 0 5 0 5]);
    
    %for const .09
    %axis([(alphaOffset*.9+offset*.9) 10 offset*.9 10 offset*.9 10])
else
    %net 84 A vs X possibility 1
    set(gca,'Xscale','log','Yscale','log','Zscale','log')
    axis([.6 20 .001 20 .001 20])
    
    %net 84 A vs X possibility 2, looks awkward
    %axis([-.1 2 -.1 2 -.1 2])
    %set(gca,'Xscale','log','Yscale','log','Zscale','log')
end

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
function [isStable] = isAttractor(xIn,alpha,network)
global networkNumber;
global offset;
global alphaOffset;


alpha = alpha-alphaOffset;

a = [alpha,.1,.1];
b = [.1,alpha,.1];
c = [.1,.1,alpha];

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
global alphaOffset;

if(networkNumber == 1)
%    row = dataRow;
    row = row-offset;
    row(4,:) = row(4,:)-alphaOffset;
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

