function varargout = sudokugui(varargin)
% SUDOKUGUI Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% (Leave a blank line following the help.)

%  Initialization tasks
s={'String','Calculating','Iterations: ','Error';'BackgroundColor','y','g','r'};


%  Construct the components
fig =  figure(...
    'Name','Sudoku Solver GUI',...
    'NumberTitle', 'off',...
    'Units','pixels',...
    'MenuBar','none',...
    'Toolbar','none',...
    'Position',[200,200,455,485],...
    'Visible','off');

boxo = uicontrol(fig,...
    'Style','text',...
    'BackgroundColor','k',...
    'Position',[45,80,365,365]);

for i = 1:3
    for j = 1:3
        boxi(i,j) = uicontrol(fig,...
            'Style','text',...
            'BackgroundColor','w',...
            'Position',[50+120*(i-1),85+120*(j-1),115,115]);
    end
end

for i = 1:9
    for j = 1:9
        table(i,j) = uicontrol(fig,...
            'Max',1,...
            'Min',1,...
            'Position',[(50+40*(j-1)),(405-40*(i-1)),35,35],...
            'String','0',...
            'Style','edit');
    end
end
            
solve = uicontrol(fig,...
    'Callback',@solvef,...
    'Style','pushbutton',...
    'String','Solve',...
    'Position',[45,25,100,30]);
    
status = uicontrol(fig,...
    'Style','pushbutton',...
    'String','Ready',...
    'Enable','inactive',...
    'Position',[175,25,105,30],...
    'BackgroundColor','w');
    

reset = uicontrol(fig,...
    'Callback',@resetf,...
    'Style','pushbutton',...
    'String','Reset',...
    'Position',[310,25,100,30]);

%  Initialization tasks
set([fig,boxo,boxi(1,:),boxi(2,:),boxi(3,:),...
    table(1,:),table(2,:),table(3,:),table(4,:),table(5,:),table(6,:),...
    table(7,:),table(8,:),table(9,:),solve,status,reset],'Units','normalized')
set(fig,'Visible','on')

%  Callbacks for MYGUI
function solvef(hObject,eventdata)
        
        
        r=round(0.6:0.11:9.5);
        c=[1:9,1:9,1:9,1:9,1:9,1:9,1:9,1:9,1:9];
        start=zeros(9,9);
        pause(0.1)
        set(status,'String','Calculating','BackgroundColor','y');
        pause(0.1)
        for n=1:81
            start(r(n),c(n))=str2double(get(table(r(n),c(n)),'String'));
        end
        
        [final,res,it] = solverfunction(start,1,0);
        set(status,s(1,1),strcat(s(1,3),num2str(it)),s(2,1),s(2,3))
        if res ~= true
            set(status,s(1,1),s(1,4),s(2,1),s(2,4))
        end
        
        for y = 1:9
            for z = 1:9
                set(table(y,z),'String',num2str(final(y,z)))
            end
        end
        
end

function resetf(hObject,eventdata)
        for i = 1:9
            for j = 1:9
                set(table(i,j),'String','0')
            end
        end
        set(status,'String','Ready','BackgroundColor','w')
end
%  Utility functions for MYGUI
function [ test, res, it ] = solverfunction( test, num, it )
    r=round(0.6:0.11:9.5);
    c=[1:9,1:9,1:9,1:9,1:9,1:9,1:9,1:9,1:9];
    res = false;

    if test(r(num),c(num))~=0
        [test,res,it] = solverfunction(test, num+1,it);
    else
        for x = 1:9
            it = it + 1;
            test(r(num),c(num))=x;
            good = sudokutest(test);
            if and(good == true, num < 81)
                [test,res,it] = solverfunction(test, num+1,it);
                if res == true
                    break
                end
            elseif and(good == true, num == 81)
                res = true;
                break
            end
        end
        if res == false
            test(r(num),c(num))=0;
        end
    end            
end

function [ good ] = sudokutest(test)
good = true;

    for q = 1:9
        testr = test(q,:);
        testr(testr == 0) = [];
        testc = test(:,q);
        testc(testc == 0) = [];
    
        [~,f1] = mode(testr);
        [~,f2] = mode(testc);
    
        if or(f1>1,f2>1)
            good = false;
        end
    end
    for i = 1:3:7
        for j = 1:3:7
            testb = [test(i,j:(j+2)),test(i+1,j:(j+2)),test(i+2,(j:j+2))];
            testb(testb == 0) = [];
            [~,f3] = mode(testb);
            if f3>1
                good = false;
            end
        end
    end
end

end
