function varargout = HuangVisualizationGUI(varargin)
% HUANGVISUALIZATIONGUI MATLAB code for HuangVisualizationGUI.fig
%      HUANGVISUALIZATIONGUI, by itself, creates a new HUANGVISUALIZATIONGUI or raises the existing
%      singleton*.
%
%      H = HUANGVISUALIZATIONGUI returns the handle to a new HUANGVISUALIZATIONGUI or the handle to
%      the existing singleton*.
%
%      HUANGVISUALIZATIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUANGVISUALIZATIONGUI.M with the given input arguments.
%
%      HUANGVISUALIZATIONGUI('Property','Value',...) creates a new HUANGVISUALIZATIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HuangVisualizationGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HuangVisualizationGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HuangVisualizationGUI

% Last Modified by GUIDE v2.5 03-May-2013 09:42:52

addpath('./functions')

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @HuangVisualizationGUI_OpeningFcn, ...
    'gui_OutputFcn',  @HuangVisualizationGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HuangVisualizationGUI is made visible.
function HuangVisualizationGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HuangVisualizationGUI (see VARARGIN)

% Choose default command line output for HuangVisualizationGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HuangVisualizationGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HuangVisualizationGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function minAlphaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to minAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%update text
set(handles.minAlphaValue,'String',get(hObject,'value'));
%update graph
update_Graphs(handles);

% --- Executes during object creation, after setting all properties.
function minAlphaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function maxAlphaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to maxAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%update text
set(handles.maxAlphaValue,'String',get(hObject,'value'));
%update graph
update_Graphs(handles);

% --- Executes during object creation, after setting all properties.
function maxAlphaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function minAlphaValue_Callback(hObject, eventdata, handles)
% hObject    handle to minAlphaValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minAlphaValue as text
%        str2double(get(hObject,'String')) returns contents of minAlphaValue as a double
%update slider
set(handles.minAlphaSlider,'Value',str2double(get(hObject,'String')));
%update graph
update_Graphs(handles);

% --- Executes during object creation, after setting all properties.
function minAlphaValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minAlphaValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxAlphaValue_Callback(hObject, eventdata, handles)
% hObject    handle to maxAlphaValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxAlphaValue as text
%        str2double(get(hObject,'String')) returns contents of maxAlphaValue as a double

%update slider
set(handles.maxAlphaSlider,'Value',str2double(get(hObject,'String')));
%update graph
update_Graphs(handles);

% --- Executes during object creation, after setting all properties.
function maxAlphaValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxAlphaValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in XCheckbox.
function XCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to XCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of XCheckbox


% --- Executes on button press in YCheckbox.
function YCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to YCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of YCheckbox


% --- Executes on button press in ZCheckbox.
function ZCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to ZCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ZCheckbox


% --- Executes on button press in AlphaCheckbox.
function AlphaCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to AlphaCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AlphaCheckbox

% --- Executes on button press in UCheckbox.
function UCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to UCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UCheckbox


% --- Executes on button press in UnstableCheckbox.
function UnstableCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to UnstableCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UnstableCheckbox


% --- Executes on selection change in networkSelector.
function networkSelector_Callback(hObject, eventdata, handles)
% hObject    handle to networkSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns networkSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from networkSelector
%if a new network is selected load those file contents
contents = cellstr(get(hObject,'String'));
stringval = contents{get(hObject,'Value')};
load(strcat('visualization_results_',stringval,'.mat'));
handles.current_data = bout;
%update our network number, 1 and 2 are net1, 3 is net84
if(get(handles.networkSelector,'Value') < 3)
    network =1;
    if(get(handles.networkSelector,'Value') == 1)
        const = 0;
    else
        const = 0.09;
    end
else
    network =84;
    const = 0;
end
handles.current_network = network;
handles.const = const;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function networkSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to networkSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%extra utility functions

function update_Graphs(handles)

clr = [
    0.00	0.00	0.00 %black
    0.00    0.50	0.00 %magenta
    0.70    0.40    0.00
    0.00	0.00    1.00 %blue
    0.75    0.75	0.00 %yellow
    0.00    0.75    0.75
    0.75    0.00    0.75
    1.00    0.50    0.00 %orange
    0.25    0.25    0.25
    1.00    0.00	0.00 %red
    1.00    1.00    1.00 %white
    ];

if(~isfield(handles, 'current_data'))
    contents = cellstr(get(handles.networkSelector,'String'));
    stringval = contents{get(handles.networkSelector,'Value')};
    load(strcat('visualization_results_',stringval,'.mat'));
    handles.current_data = bout;
    ourdata = bout;
    
    if(get(handles.networkSelector,'Value') < 3)
        network =1;
        if(get(handles.networkSelector,'Value') == 1)
            const=0;
        else
            const=0.09;
        end
    else
        network=84;
    end
    handles.current_network = network;
    handles.const = const;
    
    guidata(hObject, handles);
    
else
    ourdata = handles.current_data;
end

%get which axes to show, we're lazy so parameterize on the first unused
%value
axes=[];
bifurcation=4;
if(get(handles.AlphaCheckbox,'Value') ==1)
    axes=[4 axes];
else
    bifurcation=4;
end
if(get(handles.ZCheckbox,'Value') ==1)
    axes=[3 axes];
else
    bifurcation=3;
end
if(get(handles.YCheckbox,'Value') ==1)
    axes=[2 axes];
else
    bifurcation=2;
end
if(get(handles.XCheckbox,'Value') ==1)
    axes=[1 axes];
else
    bifurcation=1;
end

%if you check all 4 just graph the first 3
if(size(axes)>3)
    axes = axes(1:3);
end

%grab a handle to the first figure and clear its contents
figure(1);
clf(figure(1));

%add "patches" to give a sense of depth to the graph
alpha = .25; % please change this as needed .
% Obtain the limits of the axes
xp = log([.5,20]);
zp = log([.01,20]);
% Use the axes Y and Z limits to find the co-ordinates for the patch
x1 = [ xp(1) xp(2) xp(2) xp(1)];
z1 = [ zp(1) zp(1) zp(2) zp(2)];

y1 = ones(1,numel(x1))* log(.1);
y2 = ones(1,numel(x1))* log(1);
y3 = ones(1,numel(x1))* log(5);

%ybars
% p = patch(x1,y1,z1, 'b');
% set(p,'facealpha',alpha)
% set(p,'edgealpha',alpha)
% p = patch(x1,y2,z1, 'b');
% set(p,'facealpha',alpha)
% set(p,'edgealpha',alpha)
% p = patch(x1,y3,z1, 'b');
% set(p,'facealpha',alpha)
% set(p,'edgealpha',alpha)

%zbars
% p = patch(x1,z1,y1, 'b');
% set(p,'facealpha',alpha)
% set(p,'edgealpha',alpha)
% p = patch(x1,z1,y2, 'b');
% set(p,'facealpha',alpha)
% set(p,'edgealpha',alpha)
% p = patch(x1,z1,y3, 'b');
% set(p,'facealpha',alpha)
% set(p,'edgealpha',alpha)

%xbars
xp = log([.01,20]);
zp = log([.01,20]);
% Use the axes Y and Z limits to find the co-ordinates for the patch
x1 = [ xp(1) xp(2) xp(2) xp(1)];
z1 = [ zp(1) zp(1) zp(2) zp(2)];

y1 = ones(1,numel(x1))* log(1);
y2 = ones(1,numel(x1))* log(5);

p = patch(y1,x1,z1, 'b');
set(p,'facealpha',alpha)
set(p,'edgealpha',alpha)
p = patch(y2,x1,z1, 'b');
set(p,'facealpha',alpha)
set(p,'edgealpha',alpha)

%get the parameter range values
minParm = str2double(get(handles.minAlphaValue,'String'));
maxParm = str2double(get(handles.maxAlphaValue,'String'));
showSpecialLine = get(handles.UCheckbox,'Value');
showUnstablePoints = get(handles.UnstableCheckbox,'Value');

%load the stable steady state strengths, attractor region / spectral radii
if(handles.current_network ==1)
    %network 1
    if(handles.const == 0)
        %fname = 'steady_state_strength_net1.mat';
        fname = 'steady_state_radii_net1.mat';
        load(fname);
    else
        % const .09
        %fname = 'steady_state_strength_net1_09.mat';
        fname = 'steady_state_radii_net1_09.mat';
        load(fname);
    end
    
else
    %network 84
    %fname = 'steady_state_strength_net84.mat';
    fname = 'steady_state_radii_net84.mat';
    load(fname);
end


fprintf('\n\nshowing data from network %s with parm range %f to %f\n',fname,minParm, maxParm);

%loop through all the data we have and call show_data on it
for i=1:size(ourdata,1)
    
    if(i<9)
        color = i;
    else
        if(~showSpecialLine)
            continue;
        end
        
        color = 9;
    end
    
    show_data(ourdata{i,1},ourdata{i,3},axes,bifurcation, minParm, maxParm,showUnstablePoints,color,handles.current_network, handles.const,clr);
    %show_data(ourdata{i,1},ourdata{i,3},axes,bifurcation, minParm, maxParm,showUnstablePoints);
    
end


show_legend =0; %we pre-generate the legend separately for graph cleanliness
if(show_legend)
    format_zyx =0; %do we want our legend in ZYX or XYZ format?
    % with z y x format legend
    if(format_zyx)
        if(handles.current_network ==1)
            if(handles.const == 0)
                %network 1
                legend('ZYX','---','--+','-+-','-++','+--','+-+','++-','+++')
            else
                legend('ZYX','---','--+','-+-','+--','+++')
            end
        else
            %network 84
            legend('ZYX','---','+++','++-','--+','-+-','+-+','+--','-++')
        end
    else
        if(handles.current_network ==1)
            if(handles.const == 0)
                %network 1
                h_legend = legend(' X Y Z ',' - - - ',' + - - ',' - + - ',' + + - ',' - - + ',' + - + ',' - + + ',' + + + ');
            else
                h_legend = legend(' X Y Z ',' - - - ',' + - - ',' - + - ',' - - + ',' + + + ');
            end
        else
            %network 84
            h_legend = legend(' X Y Z ',' - - -',' + + + ',' - + + ',' + - - ',' - + - ',' + - + ',' - - + ',' + + - ');
        end
        
        set(h_legend,'FontName','Courier','FontSize',26, 'FontWeight' , 'bold');
    end
end

%draw the relative stable steady state sizes now
figure(1);
hold on;

%alpha 1
ptset = ss_str{1}';
ptset2 = ss_str{2}';

offset=0;
if(handles.current_network==1 && handles.const==0)
    offset=.02;
    ptset(1:3,1) = ptset(1:3,1)+offset;
    ptset2(1:3,1) = ptset2(1:3,1)+offset;
end

%hack for using patches, log graphing is out
ptset(1:3,:) = real(log(ptset(1:3,:)));
ptset2(1:3,:) = real(log(ptset2(1:3,:)));


%ptset
%ptset2

%scale the spectral radii for easier drawing
for i=1:size(ptset(4,:),2)
    if(handles.current_network ==84)
        ptset(4,i) = exp(ptset(4,i))*30;
        ptset2(4,i) = exp(ptset2(4,i))*30;
    else
        if(handles.const ==0)          
            %ptset(4,i)  = exp((ptset(4,i)^10)*2)*10;
            ptset(4,i) = exp(ptset(4,i)^10)*30;
            ptset2(4,i) = exp((ptset2(4,i)^10)*2)*10;  
        else
            ptset(4,i)  = exp((ptset(4,i)^10)*2)*20;
            ptset2(4,i)  = exp((ptset2(4,i)^10)*2)*10;
            ptset2(4,1) = 25; %hack because otherwise the 1,1,1 state is invisible
        end
    end
end

%ptset
%ptset2

if(true) %we want to always print the states so that they can be seen
%if(~showUnstablePoints)
    %alpha_1 = 1+offset;
    alpha_1 = log(1+offset);
    for j=1:8

        if(ptset(4,j) >0)
            msize = ptset(4,j);
            h_plot = plot3(alpha_1, ptset(1,j), ptset(2,j), '.', 'MarkerSize',msize,'MarkerEdgeColor' , clr(10,:));
            set(h_plot, 'linewidth',1.5);
            h_plot = plot3(alpha_1, ptset(1,j), ptset(2,j), 'o', 'MarkerSize',msize/3 +.5,'MarkerEdgeColor' , clr(1,:));
            set(h_plot, 'linewidth',2.0);
        end
    end
    

    %alpha 5
%     alpha_5 = 5+offset;
    alpha_5 = log(5+offset);
    for j=1:8      
        if(ptset2(4,j) >30)            
            msize = ptset2(4,j);
            %h_plot = plot3(5+offset, ptset2(1,j), ptset2(2,j), 'o', 'MarkerSize',msize*2.1, 'MarkerEdgeColor' , clr(9,:));
            h_plot = plot3(alpha_5, ptset2(1,j), ptset2(2,j), '.', 'MarkerSize',msize, 'MarkerEdgeColor' , clr(9,:));
            set(h_plot, 'linewidth',1.5);
            h_plot = plot3(alpha_5, ptset2(1,j), ptset2(2,j), 'o', 'MarkerSize',msize/3 +.5, 'MarkerEdgeColor' , clr(1,:));
            set(h_plot, 'linewidth',2.0);
        end
    end
end

