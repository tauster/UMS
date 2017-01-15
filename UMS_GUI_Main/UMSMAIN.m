%%  Ultrasonic Mapping System - UMS
%   
%   Starts the main GUI interface and gives two choices. Choose Live Data
%   to see live data from xbee as well as connect to serial port of xbee
%   dongle to start the UMS system. MUST CONNECT TO SERIAL TO START SYSTEM.
%   
%   by Tausif Sharif
%
%%  GUI - DO NOT EDIT
function varargout = UMSMAIN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UMSMAIN_OpeningFcn, ...
                   'gui_OutputFcn',  @UMSMAIN_OutputFcn, ...
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

% --- Executes just before UMSMAIN is made visible.
function UMSMAIN_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = UMSMAIN_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
UMS_GUI

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
UMS_DATAPLOT

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('UMS Logo.png')


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('RU-FEAS-rgb2.png')
