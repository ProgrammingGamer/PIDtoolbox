%% PTplotLogViewer - script to plot main line graphs

% ----------------------------------------------------------------------------------
% "THE BEER-WARE LICENSE" (Revision 42):
% <brian.white@queensu.ca> wrote this file. As long as you retain this notice you
% can do whatever you want with this stuff. If we meet some day, and you think
% this stuff is worth it, you can buy me a beer in return. -Brian White
% ----------------------------------------------------------------------------------

% tic
printf("---PTplotLogViewer---\n");
if ~isempty(filenameA) || ~isempty(filenameB) 
    
    %set(PTfig, 'pointer', 'watch')
    
    figure(1);

    maxY=1200;

    alpha_red=.8;
    alpha_blue=.8;

    prop_max_screen=(max([get(PTfig, 'position')(3) get(PTfig, 'position')(4)]));
    fontsz=(screensz_multiplier*prop_max_screen);
    
    % scale fonts according to size of window and/or screen
    set(guiHandles.fileA, 'fontsize', fontsz);
    set(guiHandles.fileB, 'fontsize', fontsz);
    set(guiHandles.runAll, 'fontsize', fontsz);
    set(guiHandles.Epoch1_A_text, 'fontsize', fontsz);
    set(guiHandles.Epoch1_A_Input, 'fontsize', fontsz);
    set(guiHandles.Epoch2_A_text, 'fontsize', fontsz);
    set(guiHandles.Epoch2_A_Input, 'fontsize', fontsz);
    set(guiHandles.Epoch1_B_text, 'fontsize', fontsz);
    set(guiHandles.Epoch1_B_Input, 'fontsize', fontsz);
    set(guiHandles.Epoch2_B_text, 'fontsize', fontsz);
    set(guiHandles.Epoch2_B_Input, 'fontsize', fontsz);
    %set(guiHandles.spectrogramButton, 'fontsize', fontsz);
    set(guiHandles.PIDerrButton, 'fontsize', fontsz);
    set(guiHandles.TuningButton, 'fontsize', fontsz);
    set(guiHandles.DispInfoButton, 'fontsize', fontsz);
    set(guiHandles.flightStats, 'fontsize', fontsz);
    set(guiHandles.saveFig, 'fontsize', fontsz);
    set(guiHandles.wiki, 'fontsize', fontsz);
    set(guiHandles.checkbox0, 'fontsize', fontsz);
    set(guiHandles.checkbox1, 'fontsize', fontsz);
    set(guiHandles.checkbox2, 'fontsize', fontsz);
    set(guiHandles.checkbox3, 'fontsize', fontsz);
    set(guiHandles.checkbox4, 'fontsize', fontsz);
    set(guiHandles.checkbox5, 'fontsize', fontsz);
    set(guiHandles.checkbox6, 'fontsize', fontsz);
    set(guiHandles.checkbox7, 'fontsize', fontsz);
    set(guiHandles.checkbox8, 'fontsize', fontsz);
    set(guiHandles.checkbox9, 'fontsize', fontsz);
    set(guiHandles.checkbox10, 'fontsize', fontsz);
    set(guiHandles.checkbox11, 'fontsize', fontsz);
    set(guiHandles.checkbox12, 'fontsize', fontsz);
    set(guiHandles.checkbox13, 'fontsize', fontsz);
    set(guiHandles.checkbox14, 'fontsize', fontsz);
    set(guiHandles.checkbox15, 'fontsize', fontsz);
    set(guiHandles.linewidth, 'fontsize', fontsz);
    set(controlpanel, 'fontsize', fontsz);
    
    if plotall_flag>=0 
        set(guiHandles.checkbox0, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox1, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox2, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox3, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox4, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox5, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox6, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox7, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox8, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox9, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox10, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox11, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox12, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox13, 'value', get(guiHandles.checkbox15, 'value'));
        set(guiHandles.checkbox14, 'value', get(guiHandles.checkbox15, 'value'));
    end
    plotall_flag=-1;

    %%%%%%%% ui filenames %%%%%%%
    if ~isempty(filenameA)
    set(guiHandles.fileA, 'fontweight', 'bold');
    guiHandles.fnameAText = uicontrol(PTfig,'style','text','string',['A:' filenameA],'fontsize',fontsz*.8,'units','normalized','BackgroundColor',bgcolor,'position',[posInfo.fnameAText]);
    end
    if ~isempty(filenameB)
    set(guiHandles.fileB, 'fontweight', 'bold');
    guiHandles.fnameBText = uicontrol(PTfig,'style','text','string',['B:' filenameB],'fontsize',fontsz*.8,'units','normalized','BackgroundColor',bgcolor,'position',[posInfo.fnameBText]);
    end


    %% posinfo
    posInfo.linepos1=[0.095 0.805 0.77 0.125];
    posInfo.linepos2=[0.095 0.675 0.77 0.125];
    posInfo.linepos3=[0.095 0.545 0.77 0.125];

    posInfo.linepos4=[0.095 0.39 0.77 0.125];
    posInfo.linepos5=[0.095 0.26 0.77 0.125];
    posInfo.linepos6=[0.095 0.13 0.77 0.125];

    expand_sz=[0.05 0.07 0.82 0.86];


    %% where you want full range of data
    if ~isempty(filenameA),
        y=[epoch1_A*us2sec epoch2_A*us2sec];%%% used for fill in unused data range
        t1=(tta(find(tta>y(1),1))) / us2sec;
        t2=(tta(find(tta>y(2),1))) / us2sec;  
    end

    if ~isempty(filenameB),
        y=[epoch1_B*us2sec epoch2_B*us2sec];
        t3=(ttb(find(ttb>y(1),1))) / us2sec;
        t4=(ttb(find(ttb>y(2),1))) / us2sec;  
    end

    %% log viewer line plots
    %%%%%%%% PLOT %%%%%%%
    axLabel={'roll';'pitch';'yaw'};

    PTfig;
    %dcm_obj = datacursormode(PTfig);
    %set(dcm_obj,'UpdateFcn',@PTdatatip);

     %%%% [A] LINE PLOTS
    if ~isempty(filenameA)
        for ii=1:3  
            if ~expandON,
                eval(['hlinepos' int2str(ii) '=subplot(' '''position''' ',posInfo.linepos' int2str(ii) ');cla;'])
            else
                eval(['if ~isempty(hexpand' int2str(ii) '),' 'subplot(hexpand' int2str(ii) ',' '''position''' ',expand_sz);cla; end'])
                warning off
            end

            if  ~expandON || (expandON && eval(['~isempty(hexpand' int2str(ii) ')']))
                xmax=max(tta/us2sec); 

                h=plot([0 xmax],[-maxY -maxY],'k');
                set(h,'linewidth',.2)
                hold on
                
                set(gca,'ytick',[2*-maxY -maxY -maxY+1 -600 0 600 maxY],'yticklabel',{'0%' '100%' '' '-600' '0' '600' ''},'YColor',[.2 .2 .2],'fontweight','bold') 
                set(gca,'xtick',[10:10:round(xmax-5)],'XColor',[.2 .2 .2])                 

                if expandON
                    if get(guiHandles.checkbox0, 'value'), h=plot(tta/us2sec, DATmainA.debug(ii,:));hold on;set(h,'color', [linec.col0],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox1, 'value'), h=plot(tta/us2sec, DATmainA.GyroFilt(ii,:));hold on;set(h,'color', [linec.col1],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox2, 'value'), h=plot(tta/us2sec, DATmainA.Pterm(ii,:));hold on;set(h,'color', [linec.col2],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox3, 'value'), h=plot(tta/us2sec, DATmainA.Iterm(ii,:));hold on;set(h,'color', [linec.col3],'LineWidth', get(guiHandles.linewidth, 'value')), end     
                    if get(guiHandles.checkbox4, 'value') && ii<3, h=plot(tta/us2sec, DATmainA.DtermRaw(ii,:));hold on;set(h,'color', [linec.col4],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox5, 'value') && ii<3, h=plot(tta/us2sec, DATmainA.DtermFilt(ii,:));hold on;set(h,'color', [linec.col5],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox6, 'value'), h=plot(tta/us2sec, DATmainA.Fterm(ii,:));hold on;set(h,'color', [linec.col6],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox7, 'value'), h=plot(tta/us2sec, DATmainA.RCRate(ii,:));hold on;set(h,'color', [linec.col7],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox8, 'value'), h=plot(tta/us2sec, DATmainA.PIDsum(ii,:));hold on;set(h,'color', [linec.col8],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox9, 'value'), h=plot(tta/us2sec, DATmainA.PIDerr(ii,:));hold on;set(h,'color', [linec.col9],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox10, 'value'), h=plot(tta/us2sec, (DATmainA.Motor(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col10],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox11, 'value'), h=plot(tta/us2sec, (DATmainA.Motor(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col11],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox12, 'value'), h=plot(tta/us2sec, (DATmainA.Motor(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col12],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox13, 'value'), h=plot(tta/us2sec, (DATmainA.Motor(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col13],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox10, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(tta/us2sec, (DATmainA.debug(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox11, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(tta/us2sec, (DATmainA.debug(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox12, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(tta/us2sec, (DATmainA.debug(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox13, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(tta/us2sec, (DATmainA.debug(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox14, 'value'), h=plot(tta/us2sec, (DATmainA.RCRate(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col14],'LineWidth', get(guiHandles.linewidth, 'value')); end
                else % downsampled for faster plotting performance
                    if get(guiHandles.checkbox0, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.debug(ii,:));hold on;set(h,'color', [linec.col0],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox1, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.GyroFilt(ii,:));hold on;set(h,'color', [linec.col1],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox2, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.Pterm(ii,:));hold on;set(h,'color', [linec.col2],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox3, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.Iterm(ii,:));hold on;set(h,'color', [linec.col3],'LineWidth',get(guiHandles.linewidth, 'value')), end     
                    if get(guiHandles.checkbox4, 'value') && ii<3, h=plot(DATdnsmplA.tta, DATdnsmplA.DtermRaw(ii,:));hold on;set(h,'color', [linec.col4],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox5, 'value') && ii<3, h=plot(DATdnsmplA.tta, DATdnsmplA.DtermFilt(ii,:));hold on;set(h,'color', [linec.col5],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox6, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.Fterm(ii,:));hold on;set(h,'color', [linec.col6],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox7, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.RCRate(ii,:));hold on;set(h,'color', [linec.col7],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox8, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.PIDsum(ii,:));hold on;set(h,'color', [linec.col8],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox9, 'value'), h=plot(DATdnsmplA.tta, DATdnsmplA.PIDerr(ii,:));hold on;set(h,'color', [linec.col9],'LineWidth',get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox10, 'value'), h=plot(DATdnsmplA.tta, (DATdnsmplA.Motor(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col10],'LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox11, 'value'), h=plot(DATdnsmplA.tta, (DATdnsmplA.Motor(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col11],'LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox12, 'value'), h=plot(DATdnsmplA.tta, (DATdnsmplA.Motor(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col12],'LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox13, 'value'), h=plot(DATdnsmplA.tta, (DATdnsmplA.Motor(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col13],'LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox10, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplA.tta, (DATdnsmplA.debug(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox11, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplA.tta, (DATdnsmplA.debug(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox12, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplA.tta, (DATdnsmplA.debug(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox13, 'value') && A_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplA.tta, (DATdnsmplA.debug(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth',get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox14, 'value'), h=plot(DATdnsmplA.tta, (DATdnsmplA.RCRate(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col14],'LineWidth',get(guiHandles.linewidth, 'value')); end
                end
                
                h=fill([0,t1,t1,0],[-maxY*2,-maxY*2,maxY,maxY],[.8 .8 .8]);
                set(h,'FaceAlpha',0.8,'EdgeColor',[.8 .8 .8]);
                h=fill([t2,xmax,xmax,t2],[-maxY*2,-maxY*2,maxY,maxY],[.8 .8 .8]);
                set(h,'FaceAlpha',0.8,'EdgeColor',[.8 .8 .8]);

                printf("ErrorCheck 01\n");
                
                %a = zoom(PTfig);
                
                printf("ErrorCheck 02\n");
                
                
                %if strcmp(a.Enable,'on'), 
                %    v = axis;
                %    axis(v)
                %else  
                %    a.Enable='off'; 
                %    axis([0 xmax -maxY*2 maxY])
                %end

                box off            
                y=ylabel(['[A] ' axLabel{ii} '^o/s'],'fontweight','bold','rotation', 90);               
                set(y,'Units','normalized', 'position', [-.035 .67 1],'color',[.2 .2 .2]); 
                y=xlabel('time (s)','fontweight','bold');
                set(y,'color',[.2 .2 .2]); 
                set(gca,'fontsize',fontsz)
            end

            if ii==1 && ~expandON,
                set(hlinepos1,'color',[1 1 1],'fontsize',fontsz,'tickdir','in','xminortick','on','yminortick','on','position',[posInfo.linepos1]), 
                set(hlinepos1,'buttondownfcn', ['expandON=1;hexpand1 = copyobj(hlinepos1, gcf); set(hexpand1, ''Units'', ''normal'',''fontweight'', ''bold'',' ...
                ' ''Position'', [expand_sz],' ...
                ' ''buttondownfcn'', ''delete(gca);expandON=0;hexpand1=[]; '');']);      
            end
            if ii==2 && ~expandON,
                set(hlinepos2,'color',[1 1 1],'fontsize',fontsz,'tickdir','in','xminortick','on','yminortick','on','position',[posInfo.linepos2]), 
                set(hlinepos2,'buttondownfcn', ['expandON=1;hexpand2 = copyobj(hlinepos2, gcf); set(hexpand2, ''Units'', ''normal'',''fontweight'', ''bold'',' ...
                ' ''Position'', [expand_sz],' ...
                ' ''buttondownfcn'', ''delete(gca);expandON=0;hexpand2=[]; '');']);
            end
            if ii==3 && ~expandON,
                set(hlinepos3,'color',[1 1 1],'fontsize',fontsz,'tickdir','in','xminortick','on','yminortick','on','position',[posInfo.linepos3]), 
                set(hlinepos3,'buttondownfcn', ['expandON=1;hexpand3 = copyobj(hlinepos3, gcf); set(hexpand3, ''Units'', ''normal'',''fontweight'', ''bold'',' ...
                ' ''Position'', [expand_sz],' ...
                ' ''buttondownfcn'', ''delete(gca);expandON=0;hexpand3=[]; '');']) 
            end           
        end
    end

    %%%% [B] LINE PLOTS
    if ~isempty(filenameB)
        for ii=1:3
            if ~expandON,
                eval(['hlinepos' int2str(ii+3) '=subplot(' '''position''' ',posInfo.linepos' int2str(ii+3) ');cla;'])
            else
                eval(['if ~isempty(hexpand' int2str(ii+3) '),' 'subplot(hexpand' int2str(ii+3) ',' '''position''' ',expand_sz);cla; end'])
                warning off
            end

            if ~expandON || (expandON && eval(['~isempty(hexpand' int2str(ii+3) ')']))
                xmax=max(ttb/us2sec);
 
                h=plot([0 xmax],[-maxY -maxY],'k');
                set(h,'linewidth',.2)
                hold on
                set(gca,'ytick',[2*-maxY -maxY -maxY+1 -600 0 600 maxY],'yticklabel',{'0%' '100%' '' '-600' '0' '600' ''},'YColor',[.2 .2 .2],'fontweight','bold')    
                set(gca,'xtick',[10:10:round(xmax-5)],'XColor',[.2 .2 .2])  

                if expandON
                    if get(guiHandles.checkbox0, 'value'), h=plot(ttb/us2sec, DATmainB.debug(ii,:));hold on;set(h,'color', [linec.col0],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox1, 'value'), h=plot(ttb/us2sec, DATmainB.GyroFilt(ii,:));hold on;set(h,'color', [linec.col1],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox2, 'value'), h=plot(ttb/us2sec, DATmainB.Pterm(ii,:));hold on;set(h,'color', [linec.col2],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox3, 'value'), h=plot(ttb/us2sec, DATmainB.Iterm(ii,:));hold on;set(h,'color', [linec.col3],'LineWidth', get(guiHandles.linewidth, 'value')), end     
                    if get(guiHandles.checkbox4, 'value') && ii<3, h=plot(ttb/us2sec, DATmainB.DtermRaw(ii,:));hold on;set(h,'color', [linec.col4],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox5, 'value') && ii<3, h=plot(ttb/us2sec, DATmainB.DtermFilt(ii,:));hold on;set(h,'color', [linec.col5],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox6, 'value'), h=plot(ttb/us2sec, DATmainB.Fterm(ii,:));hold on;set(h,'color', [linec.col6],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox7, 'value'), h=plot(ttb/us2sec, DATmainB.RCRate(ii,:));hold on;set(h,'color', [linec.col7],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox8, 'value'), h=plot(ttb/us2sec, DATmainB.PIDsum(ii,:));hold on;set(h,'color', [linec.col8],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox9, 'value'), h=plot(ttb/us2sec, DATmainB.PIDerr(ii,:));hold on;set(h,'color', [linec.col9],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox10, 'value'), h=plot(ttb/us2sec, (DATmainB.Motor(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col10],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox11, 'value'), h=plot(ttb/us2sec, (DATmainB.Motor(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col11],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox12, 'value'), h=plot(ttb/us2sec, (DATmainB.Motor(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col12],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox13, 'value'), h=plot(ttb/us2sec, (DATmainB.Motor(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col13],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox10, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(ttb/us2sec, (DATmainB.debug(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox11, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(ttb/us2sec, (DATmainB.debug(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox12, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(ttb/us2sec, (DATmainB.debug(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox13, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(ttb/us2sec, (DATmainB.debug(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox14, 'value'), h=plot(ttb/us2sec, (DATmainB.RCRate(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col14],'LineWidth', get(guiHandles.linewidth, 'value')), end
                else % downsampled for faster plotting performance
                    if get(guiHandles.checkbox0, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.debug(ii,:));hold on;set(h,'color', [linec.col0],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox1, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.GyroFilt(ii,:));hold on;set(h,'color', [linec.col1],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox2, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.Pterm(ii,:));hold on;set(h,'color', [linec.col2],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox3, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.Iterm(ii,:));hold on;set(h,'color', [linec.col3],'LineWidth', get(guiHandles.linewidth, 'value')), end     
                    if get(guiHandles.checkbox4, 'value') && ii<3, h=plot(DATdnsmplB.ttb, DATdnsmplB.DtermRaw(ii,:));hold on;set(h,'color', [linec.col4],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox5, 'value') && ii<3, h=plot(DATdnsmplB.ttb, DATdnsmplB.DtermFilt(ii,:));hold on;set(h,'color', [linec.col5],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox6, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.Fterm(ii,:));hold on;set(h,'color', [linec.col6],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox7, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.RCRate(ii,:));hold on;set(h,'color', [linec.col7],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox8, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.PIDsum(ii,:));hold on;set(h,'color', [linec.col8],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox9, 'value'), h=plot(DATdnsmplB.ttb, DATdnsmplB.PIDerr(ii,:));hold on;set(h,'color', [linec.col9],'LineWidth', get(guiHandles.linewidth, 'value')), end
                    if get(guiHandles.checkbox10, 'value'), h=plot(DATdnsmplB.ttb, (DATdnsmplB.Motor(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col10],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox11, 'value'), h=plot(DATdnsmplB.ttb, (DATdnsmplB.Motor(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col11],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox12, 'value'), h=plot(DATdnsmplB.ttb, (DATdnsmplB.Motor(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col12],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox13, 'value'), h=plot(DATdnsmplB.ttb, (DATdnsmplB.Motor(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col13],'LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox10, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplB.ttb, (DATdnsmplB.debug(1,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox11, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplB.ttb, (DATdnsmplB.debug(2,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox12, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplB.ttb, (DATdnsmplB.debug(3,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox13, 'value') && B_debugmode==DSHOT_RPM_TELEMETRY, h=plot(DATdnsmplB.ttb, (DATdnsmplB.debug(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', 'k','LineWidth', get(guiHandles.linewidth, 'value')); end
                    if get(guiHandles.checkbox14, 'value'), h=plot(DATdnsmplB.ttb, (DATdnsmplB.RCRate(4,:)*(maxY/100))-(maxY*2));hold on;set(h,'color', [linec.col14],'LineWidth', get(guiHandles.linewidth, 'value')); end
                end
                
                h=fill([0,t3,t3,0],[-maxY*2,-maxY*2,maxY,maxY],[.8 .8 .8]);
                set(h,'FaceAlpha',0.8,'EdgeColor',[.8 .8 .8]);
                h=fill([t4,xmax,xmax,t4],[-maxY*2,-maxY*2,maxY,maxY],[.8 .8 .8]);
                set(h,'FaceAlpha',0.8,'EdgeColor',[.8 .8 .8]);

                printf("ErrorCheck 03\n");
                
                %a = zoom(PTfig);
                %if strcmp(a.Enable,'on'), 
                %    v = axis;
                %    axis(v)
                %else  
                %    a.Enable='off'; 
                %    axis([0 xmax -maxY*2 maxY])
                %end
                
                printf("ErrorCheck 04\n");
               
                box off   
                y=ylabel(['[B] ' axLabel{ii} '^o/s'],'fontweight','bold','rotation', 90);                 
                set(y,'Units','normalized', 'position', [-.035 .67 1],'color',[.2 .2 .2]);  
                y=xlabel('time (s)','fontweight','bold');
                set(y,'color',[.2 .2 .2]); 
                set(gca,'fontsize',fontsz)
            end

            if ii==1 && ~expandON,
                set(hlinepos4,'color',[1 1 1],'fontsize',fontsz,'tickdir','in','xminortick','on','yminortick','on','position',[posInfo.linepos4]), 
                set(hlinepos4,'buttondownfcn', ['expandON=1;hexpand4 = copyobj(hlinepos4, gcf); set(hexpand4, ''Units'', ''normal'',''fontweight'', ''bold'',' ...
                ' ''Position'', [expand_sz],' ...
                ' ''buttondownfcn'', ''delete(gca);expandON=0;hexpand4=[]; '');']);            
            end
            if ii==2 && ~expandON, 
                set(hlinepos5,'color',[1 1 1],'fontsize',fontsz,'tickdir','in','xminortick','on','yminortick','on','position',[posInfo.linepos5]), 
                set(hlinepos5,'buttondownfcn', ['expandON=1;hexpand5 = copyobj(hlinepos5, gcf); set(hexpand5, ''Units'', ''normal'',''fontweight'', ''bold'',' ...
                ' ''Position'', [expand_sz],' ...
                ' ''buttondownfcn'', ''delete(gca);expandON=0;hexpand5=[]; '');']);            
            end
            if ii==3 && ~expandON,
                set(hlinepos6,'color',[1 1 1],'fontsize',fontsz,'tickdir','in','xminortick','on','yminortick','on','position',[posInfo.linepos6]), 
                set(hlinepos6,'buttondownfcn', ['expandON=1;hexpand6 = copyobj(hlinepos6, gcf); set(hexpand6, ''Units'', ''normal'',''fontweight'', ''bold'',' ...
                ' ''Position'', [expand_sz],' ...
                ' ''buttondownfcn'', ''delete(gca);expandON=0;hexpand6=[]; '');']);            
            end  
        end
    end

    set(PTfig, 'pointer', 'arrow')
else 
    errordlg('Please select file(s) then click ''load+run''', 'Error, no data');
    pause(2);
end

%toc

