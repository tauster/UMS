%%  UMS - SD Data Plotter
%   
%   Copy and pase DATALOG.TXT from UMS SD card to the working directory for
%   all these MATLAB files. Start this GUI. Click on Import File. Click on
%   plot type of choice and hit Update Plot. WIPE SD CARD CLEAN BEFORE 
%   PUTTING IT BACK INTO UMS!!!
%
%   by Tausif Sharif
%
%%  GUI - DO NOT EDIT
function varargout = UMS_DATAPLOT(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UMS_DATAPLOT_OpeningFcn, ...
                   'gui_OutputFcn',  @UMS_DATAPLOT_OutputFcn, ...
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

% --- Executes just before UMS_DATAPLOT is made visible.
function UMS_DATAPLOT_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = UMS_DATAPLOT_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
dataFile = get(handles.edit1, 'String');
data = dlmread(dataFile);
handles.data = data;
guidata(hObject, handles);

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'Raw Data Plot', 'Surface Plot', 'Contour Plot'});

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.listbox1, 'Value');

handles = guidata(hObject);
data = handles.data;

switch popup_sel_index
    case 1
        [XX, YY, ZZ] = pol2cart((((data(:, 3))*pi)/180), data(:, 1), data(:, 2));
        scatter3(YY, XX, ZZ)
        hold on
        xlabel('Depth (inches)')
        ylabel('Lateral (inches)')
        zlabel('Elevation (inches)')
        title('Raw Data')
        hold off
    case 2
        x_grid = linspace(min(data(:, 1)), max(data(:, 1)), 11);
        y_grid = linspace(min(data(:, 2)), max(data(:, 2)), 11);
        
        [x_mesh, y_mesh] = meshgrid(x_grid, y_grid);
        z_mesh = griddata(data(:, 1), data(:, 2), data(:, 3), x_mesh, y_mesh, 'v4');
        
        surf(z_mesh, y_mesh, x_mesh)
        hold on
        xlabel('Depth (scaled)')
        ylabel('Lateral (scaled)')
        zlabel('Elevation (inches)')
        title('Surface Plot')
        legend = colorbar;
        legend.Label.String = 'Elevation (inches)';
        hold off
    case 3
        x_grid = linspace(min(data(:, 1)), max(data(:, 1)), 11);
        y_grid = linspace(min(data(:, 2)), max(data(:, 2)), 11);
        
        [x_mesh, y_mesh] = meshgrid(x_grid, y_grid);
        z_mesh = griddata(data(:, 1), data(:, 2), data(:, 3), x_mesh, y_mesh, 'v4');
        
        contour3(z_mesh, y_mesh, x_mesh, 100);
        hold on
        xlabel('Depth (inches)')
        ylabel('Lateral (inches)')
        zlabel('Elevation (inches)')
        title('Contour Plot')
        legend = colorbar;
        legend.Label.String = 'Elevation (inches)';
        hold off
end

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('RU-FEAS-rgb2.png')

% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('UMS Logo.png')
