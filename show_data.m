function show_data(data,~, axes, parameter, minAlpha, maxAlpha, showUnstable,initialColor,network, const, clr)

global networkNumber;
networkNumber = network;
global offset;
global alphaOffset;
global constant;
constant = const;


offset=0;
alphaOffset=0;

if(networkNumber == 1 && initialColor == 1 && const == 0  )
    offset = .02;%.1;
    data = data + offset;
    alphaOffset = 0;%10;
    data(4,:) = data(4,:) + alphaOffset;
    %data(1,:) = data(1,:) + .02;
end

%this needed to be changed because plots with many line segments seem to
%have problems

initStability=1;
ourColor = initialColor;

%hack to get legend information up, draw a small white line
if(initialColor == 1)
    figure(1)
    pts = [0 0.001 0.002];
    %handle = line(0, 0, 0, 'color',clr(10,:),'linewidth',.1);
    handle = patchline(0, 0, 0, 'color',clr(10,:),'linewidth',.1);
    clear pts;
    %hasbehavior(handle,'legend',true);
end

%figure-specific hacks
startAt = 1;
endEarly = 1;

if(networkNumber ==1)
    
    if(const ==0)
        
        
        %find out where the colors loop back to being stable and stop them
        %there, this will allow a stable or unstable line to be drawn
        %startAt = 4700; % should be 1, changed for specific figures
        startAt = 1;
        endEarly = 1;
        
        if(ourColor == 2 || ourColor == 3 || ourColor == 5)
            endEarly = (size(data,2)/1) - 8469 + 1;
            startAt = 4760;
        end
        
        if(ourColor == 4 || ourColor == 6 || ourColor == 7)
            endEarly = (size(data,2)/1) - 6891 + 1;
        end
            
    else
        
        startAt = 1;
        endEarly = 1;
        
        
        if(ourColor == 1)
            endEarly = (size(data,2)/1) - 8322 + 1;
        end
        
        
        if(ourColor == 2 || ourColor == 3 || ourColor == 5)
            endEarly = (size(data,2)/1) - 4886 + 1;
        end
        
        if(ourColor == 4 || ourColor == 6 || ourColor == 7)
            startAt = 3026;
            endEarly = (size(data,2)/1) - 4749 + 1;
        end
        
        if(ourColor == 8)
            startAt = 3028;
            %endEarly = (size(data,2)/1) - 4749 + 1;
        end
    end
    
elseif(networkNumber==84)
    startAt = 1;
    endEarly = 1200;
    
    if(ourColor == 1)
        startAt = 1970;
        endEarly = 1000;
        
        
    elseif(ourColor == 2 || ourColor == 3 || ourColor == 5)
        %endEarly = (size(data,2)/1) - 4886 + 1;
        
        
        % --+ links back to ++-, so any of the 2-on's have already been drawn
    elseif(ourColor == 4 || ourColor == 6 || ourColor == 7)
        return;
        %startAt = 3026;
        %endEarly = (size(data,2)/1) - 4749 + 1;
        
    elseif(ourColor == 8)
        return;
        %startAt = 3028;
        %endEarly = (size(data,2)/1) - 4749 + 1;
    end
end

startInd = startAt;
endInd = 1;

for i = startAt:((size(data,2)/1)-endEarly)
    
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
        
        
        if( initStability || showUnstable)
            %this is a nasty hack around the fact that our colors are bound
            %as binary opposites around 4 then the sum mod 8 = the lower
            %and we only draw from the lower
            if(initStability && mod(ourColor + initialColor,8) ~=1)
                ourColor  = initialColor;
            end
            if(~initStability)
    %            ourColor = initialColor;
            end
            %if(endInd - startInd >1)
            if(startInd >1)
                fprintf('parameter leaving alpha range for color %d, start %d, end %d\n',ourColor,startInd,endInd);
                col = clr(ourColor,:);
                drawPoints(data,axes,startInd,endInd,col,initStability);
                %drawPoints(data,axes,startInd,endInd+1,col,initStability);
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
   %             ourColor = initialColor;
            end
            fprintf('parameter changing stability for color %d, start %d, end %d\n',ourColor,startInd,endInd);
            
            col = clr(ourColor,:);
            drawPoints(data,axes,startInd,endInd,col,initStability);
            %drawPoints(data,axes,startInd,endInd+1,col,initStability);
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

if(endInd - startInd < 1)
    fprintf('returning from drawPoints without printing, not enough pts\n');
    return;
end

handle = -1;

if(length(axes) ==3)
    if(startInd < endInd)
%         
%         x_coordinates = data(axes(1),startInd:endInd);
%         y_coordinates = data(axes(2),startInd:endInd);
%         z_coordinates = data(axes(3),startInd:endInd);
        x_coordinates = log(data(axes(1),startInd:endInd));
        y_coordinates = log(data(axes(2),startInd:endInd));
        z_coordinates = log(data(axes(3),startInd:endInd));
        
        if(stable)
            if(alphaPresent)
                %handle = line(z_coordinates, x_coordinates, y_coordinates,'color',clr,'linewidth',4);
                handle = patchline(z_coordinates, x_coordinates, y_coordinates,'color',clr,'linewidth',4);
            else
                %handle = line(x_coordinates, y_coordinates, z_coordinates,'color',clr,'linewidth',4);
                handle = patchline(x_coordinates, y_coordinates, z_coordinates,'color',clr,'linewidth',4);
            end
        else
            %we only care able stable steady states
            if(alphaPresent)
                %handle = line(z_coordinates, x_coordinates, y_coordinates,'color',clr,'linewidth',.1);
                %handle = line(z_coordinates, x_coordinates, y_coordinates,'color',[0.5 0.5 0.5],'linewidth',.5);
                handle = patchline(z_coordinates, x_coordinates, y_coordinates,'color',[0.5 0.5 0.5],'linewidth',.5);
            else
                %handle = line(x_coordinates, y_coordinates, z_coordinates,'color',clr,'linewidth',.1);
                %handle = line(x_coordinates, y_coordinates, z_coordinates,'color',[0.5 0.5 0.5],'linewidth',.5);
                handle = patchline(x_coordinates, y_coordinates, z_coordinates,'color',[0.5 0.5 0.5],'linewidth',.5);
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
                %handle = line(x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
                handle = patchline(x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
            else
                %handle = line(x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
                handle = patchline(x_coordinates, y_coordinates,'color',clr,'linewidth',1.5);
            end
        else
            %we only care about stable steady states
            if(alphaPresent)
                %handle = line(y_coordinates, x_coordinates,'color',clr,'linewidth',.2);
                handle = patchline(y_coordinates, x_coordinates,'color',clr,'linewidth',.2);
            else
                %handle = line(x_coordinates, y_coordinates, 'color',clr,'linewidth',.2);
                handle = patchline(x_coordinates, y_coordinates, 'color',clr,'linewidth',.2);
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
global constant;

fontSize = 28;

names = ['X','Y','Z','A'];
set(gca,'XGrid','on','YGrid','on','ZGrid','on','XMinorGrid','off','YMinorGrid','off','ZMinorGrid','off')
set(gca,'fontsize',fontSize, 'FontWeight' , 'bold')

%patches are not transparent when using log scale, hack around it
%set(gca,'Xscale','log','Yscale','log','Zscale','log')
%axisValues = [.5 20 .01 20 .01 20];
%tickPositions = [.1 1 10];
%set(gca,'XTick',tickPositions)
%set(gca,'YTick',tickPositions)
%set(gca,'ZTick',tickPositions)

axisValues = log([.5 20 .01 20 .01 20]);
tickPositions = [.01 .1 1 5 20];

labels=num2cell(tickPositions);

axis(axisValues)
set(gca,'XTick',log(tickPositions))
%set(gca,'XTickLabel',labels)
set(gca,'YTick',log(tickPositions))
%set(gca,'YTickLabel',labels)
set(gca,'ZTick',log(tickPositions))
%set(gca,'ZTickLabel',labels)
set(gca,'GridLineStyle','--')



%net 1
if(networkNumber ==1)
    
%     if(constant ==0)
%         axis([(alphaOffset*.9+offset*.9)+.1 10 offset*.9+.01 10 offset*.9+.01 10])
%     else
%         axis([(alphaOffset*.9+offset*.9)+.1 10 offset*.9+.08 10 offset*.9+.08 10])
%     end
        
    
    %    axis([0 5 0 5 0 5]);
    
    %for const .09
    %axis([(alphaOffset*.9+offset*.9) 10 offset*.9 10 offset*.9 10])
else
%     %net 84 A vs X possibility 1
%     set(gca,'Xscale','log','Yscale','log','Zscale','log')
%     %axis([.6 20 .001 20 .001 20])
%     axis([.6 20 .0005 20 .0005 20])
    
    %net 84 A vs X possibility 2, looks awkward
    %axis([-.1 2 -.1 2 -.1 2])
    %set(gca,'Xscale','log','Yscale','log','Zscale','log')
end



if(alphaPresent == 0)
    xlabel(names(axes(1)),'fontsize',fontSize)
    ylabel(names(axes(2)),'fontsize',fontSize)
    if(length(axes)==3)
        zlabel(names(axes(3)),'fontsize',fontSize)
    end
else
    if(length(axes)==3)
        %if we have an alpha then the first dimension will always be alpha
        xlabel('\alpha','fontsize',fontSize+4)
        %xlabel(names(axes(3)),'fontsize',18)
        ylabel(names(axes(1)),'fontsize',fontSize)
        zlabel(names(axes(2)),'fontsize',fontSize)
    else
        xlabel(names(axes(2)),'fontsize',fontSize+4)
        ylabel(names(axes(1)),'fontsize',fontSize)
    end
    
end

view(-95,16)

%nolabels mode
% xlabel([]);
% ylabel([]);
% zlabel([]);
% 
% set(gca,'XTickLabel',[])
% set(gca,'YTickLabel',[])
% set(gca,'ZTickLabel',[])
end

%this works only if we are bifurcating on alpha (auto-activation) and it will
%return whether a point is an attractor for the provided alpha
%we don't care about the constant because a jacobian is a derivative
function [isStable] = isAttractor(xIn,alpha,network)
global networkNumber;
global offset;
global alphaOffset;


if(alpha <0)
    isStable=0;
    return
end

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

