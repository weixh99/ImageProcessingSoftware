function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 25-Dec-2020 14:01:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.jpg','C:\Users\admin\Desktop');
str=[pathname filename];
global x;
if ~isequal([pathname,filename],[0,0]);
    x=imread(str);
    
    handles.x=x;
    guidata(hObject,handles);
    
    axes(handles.axes1);
    imshow(x);
end
 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=imread('1.jpg');
lum = get(handles.lumbright, 'string')
g1=imadjust(I, [  ], [  ], str2num(lum));   
axes(handles.axes2); 
imshow(g1);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new_f_handle=figure('visible','off');
new_axes=copyobj(handles.axes2,new_f_handle); %axes1是GUI界面绘图的坐标系
set(new_axes,'units','default','position','default');
[filename,pathname fileindex]=uiputfile({'*.jpg';'*.bmp'},'save picture as');
if ~filename
    return
else
   file=strcat(pathname,filename);
    switch fileindex %根据不同的选择保存为不同的类型
       case 1
           print(new_f_handle,'-djpeg',file);
       case 2
           print(new_f_handle,'-dbmp',file);
    end
end
delete(new_f_handle);

% 图像旋转--- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=imread('1.jpg');
lum = get(handles.lumangle, 'string')
%%rotate = get(handles.rotateSlider, 'value');
%%rotate
if str2num(lum)>360||str2num(lum)<0
    '输入角度有误，请重新输入'
else
A=imrotate(I,str2num(lum),'nearest');
axes(handles.axes2); 
imshow(A);
end

%图像的直方图统计--- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
grayimage=imread('1.jpg');
imshow(grayimage);
[m,n]=size(grayimage);
gp=zeros(1,256);
for i=1:256    
	gp(i)=length(find(grayimage==(i-1)))/(m*n);
end
axes(handles.axes2);
bar(0:255,gp);


%添加简单的椒盐噪声--- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=imread('1.jpg');
lum = get(handles.lumnoise, 'string')
t1=imnoise(t,'salt & pepper',str2num(lum));
axes(handles.axes2);
imshow(t1);



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t1=imread('jyzs.jpg');
t1 = rgb2gray(t1);
t2=medfilt2(t1,[3 3]);
imwrite(t2,'jyzs.jpg' )
axes(handles.axes2);
imshow(t2)



function lumbright_Callback(hObject, eventdata, handles)
% hObject    handle to lumbright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumbright as text
%        str2double(get(hObject,'String')) returns contents of lumbright as a double


% --- Executes during object creation, after setting all properties.
function lumbright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumbright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lumnoise_Callback(hObject, eventdata, handles)
% hObject    handle to lumnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumnoise as text
%        str2double(get(hObject,'String')) returns contents of lumnoise as a double


% --- Executes during object creation, after setting all properties.
function lumnoise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lumangle_Callback(hObject, eventdata, handles)
% hObject    handle to lumangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumangle as text
%        str2double(get(hObject,'String')) returns contents of lumangle as a double


% --- Executes during object creation, after setting all properties.
function lumangle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lumjyzs_Callback(hObject, eventdata, handles)
% hObject    handle to lumjyzs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumjyzs as text
%        str2double(get(hObject,'String')) returns contents of lumjyzs as a double


% --- Executes during object creation, after setting all properties.
function lumjyzs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumjyzs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
