%%  UMS - Live Plotter
%   
%   Live plotter interface for UMS. First connect to COM port of xbee usb
%   dongle like so, COM7. Then hit Start Serial. If the pop up window
%   doesn't go away, there is an error, hit Stop Serial and try again.
%   Otherwise UMS should have started up and hit Start Data Acquisition
%   when ready. Plot should start updating live. Hit Stop Data Acquisition
%   when complete. HIT STOP SERIAL WHEN DONE WITH SYSTEM!!!
%
%   by Tausif Sharif
%
%%  GUI - DO NOT EDIT
function varargout = UMS_GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UMS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @UMS_GUI_OutputFcn, ...
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

% --- Executes just before UMS_GUI is made visible.
function UMS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
plotCommand = 0;
handles.plotCommand = plotCommand;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = UMS_GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
COMPort = get(handles.edit1, 'String');
[s, flag] = SetupSerial(COMPort);
handles.out.s = s;
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
handles.plotCommand = 1
guidata(hObject, handles);

axes(handles.axes1);
i = handles.plotCommand;
scatter3(0,0,0, 'r*')
hold on
grid on
axis([-70 70 -70 70 0 85])
xlabel('Lateral (inches)')
ylabel('Depth (inches)')
zlabel('Elevation (inches)')
title('Live Data From UMS')

handles = guidata(hObject);
out.s = handles.out.s;
i = handles.plotCommand;

while(i == 1)
    try
        [r, h, t] = ReadData(out);
    catch
        r = 0;
        h = 0;
        t = 0;
    end
    
    handles = guidata(hObject);
    [XX, YY, ZZ] = pol2cart(((t*pi)/180), r, h);
    scatter3(XX, YY, ZZ)
    drawnow;
    handles = guidata(hObject);
    i = handles.plotCommand;
    
    pause(0.5)
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
handles.plotCommand = 0
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('RU-FEAS-rgb2.png')

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('UMS Logo.png')

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
CloseSerial

function axes1_CreateFcn(hObject, eventdata, handles)

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
