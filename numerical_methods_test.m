
function varargout = numerical_methods_test(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @numerical_methods_test_OpeningFcn, ...
                   'gui_OutputFcn',  @numerical_methods_test_OutputFcn, ...
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


% --- Executes just before numerical_methods_test is made visible.
function numerical_methods_test_OpeningFcn(hObject, eventdata, handles, varargin)
%
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = numerical_methods_test_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
format long;
x=0;
fun = get(handles.enterFun , 'string');
f = inline (fun , 'x');
ff= sym(fun);
x1=str2double(get(handles.x1 , 'string'));
x2=str2double(get(handles.x2 , 'string'));
v = get(handles.selectMethod,'Value'); 
n=str2double(get(handles.n , 'string'));
n=str2double(get(handles.n , 'string'));
    if isempty(get(handles.n , 'string'))
        n = 0.00001;
        disp('Defalut stopping is : 10^-5')
    
    end
error = 1;
switch v
    case 1
         %Bisection Method 
         k=1;
while (error > n)
     
    xr=(x1+x2)/2 ;
    if f(xr)*f(x1) >0 
        error = abs((xr-x1)/xr);
        x1=xr;       
    else
        error = abs((xr-x2)/xr) ;
        x2=xr;
    end
    tableData(k,1)=xr;
    tableData(k,2)=error;
    k = k+1;
end
    case 2 
        % False-position Method
for k = 1:n
    xr = x2-(f(x2)*(x2-x1))/(f(x2)-f(x1));
    if f(xr) * f(x1) >0
        error = (xr-x1)/xr ;
        x1 =xr;
    else
        error = (xr-x2)/xr ;
        x2=xr;
        end
        tableData(k,1)=xr;
        tableData(k,2)=error;
    
end
    case 3 
        % Newton-Raphson Method 
       fd= diff(ff);
        k=1;
        while(error  > n)
            ydd = subs(fd , x1);
            yd = double(ydd);
            xr = x1 - f(x1)/yd;
            error = abs((xr - x1)/xr) ; 
            x1 = xr ;  
             tableData(k,1)=xr;
             tableData(k,2)=error;
             k=k+1;
    
        end 
    case 4 
                % Secant Method
                k=1;
        while(error > n)
            xr = x2-f(x2)*(x2-x1)/(f(x2)-f(x1));
            error = abs((xr - x1)/xr) ;
            x1=x2;
            x2=xr;
            tableData(k,1)=xr;
            tableData(k,2)=error;
            k=k+1;
        end

        
 case 5
        %Fixied-point method
        
        
        fun2=@(x) x;
        disp('fb');
        g=(@(x) fun2(x)+f(x));
        k=1;
        
        if ((g(x1)>= x1)&&(g(x2)<= x2))~=true
            '/fontsize{15} Function dose not converge!!!';
            f = msgbox('Function dose not converge!!!','Error','error');
        end 
            pn_1=x1;
            pn= g(pn_1);
            error1=abs(pn-pn_1);
            tableData(k,1)=pn;
            tableData(k,2)=error1;
            k=2;
            while(error1>=n)
                pn_1=pn;
                pn= g(pn_1);
                error1=abs(pn-pn_1);
                 tableData(k,1)=pn;
                 tableData(k,2)=error1;
                k=k+1;
                
            end
        
end 

set(handles.showResult , 'data' , tableData );
% --- Executes on selection change in selectMethod.
function selectMethod_Callback(hObject, eventdata, handles)

function selectMethod_CreateFcn(hObject, eventdata, handles)



if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enterFun_Callback(hObject, eventdata, handles)

function enterFun_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_Callback(hObject, eventdata, handles)

function x2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_Callback(hObject, eventdata, handles)

function x1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_Callback(hObject, eventdata, handles)

function n_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function showResult_CellEditCallback(hObject, eventdata, handles)


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
