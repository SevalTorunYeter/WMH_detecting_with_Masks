%load MRI; %you need to load usual MR image or skul stripped image as .mat file
%load SPM_wm100; %you need to load the same images WM parts as .mat file

for nthPerson=1:length(SPM_wm100)
    [row,col,slice]=size(SPM_wm100{nthPerson});
    
    for nthSlice=1:slice
        
        result=false;
        
        img=double(SPM_wm100{nthPerson}(:,:,nthSlice));
        painted{nthPerson}(:,:,nthSlice) = PaintContiguous(img);
        
        x_center=round(row/2);
        y_center=round(col/2);
        middle=painted{nthPerson}((x_center-1:x_center+1),(y_center-1:y_center+1),nthSlice);
        
        if  nthSlice>(slice*0.4) && nthSlice<(slice*0.75) && min(min(middle(:)))==-5
            Iblur = imgaussfilt(img, 2);
            painted{nthPerson}(:,:,nthSlice) = PaintContiguous(Iblur);
            result=true;
        end
        
        for i=1:row
            for j=1:col
                if painted{nthPerson}(i,j,nthSlice)==-5
                    painted{nthPerson}(i,j,nthSlice)=0;
                else
                    painted{nthPerson}(i,j,nthSlice)=1;
                end
            end
        end
        
        decreased{nthPerson}(:,:,nthSlice)=dec(painted{nthPerson}(:,:,nthSlice));
        
        if result==true
            decreased{nthPerson}(:,:,nthSlice)=dec(decreased{nthPerson}(:,:,nthSlice));
            decreased{nthPerson}(:,:,nthSlice)=dec(decreased{nthPerson}(:,:,nthSlice));
            decreased{nthPerson}(:,:,nthSlice)=dec(decreased{nthPerson}(:,:,nthSlice));
            decreased{nthPerson}(:,:,nthSlice)=dec(decreased{nthPerson}(:,:,nthSlice));
        end
        
        if nthSlice>(slice*0.7)
            decreased{nthPerson}(:,:,nthSlice)=dec(decreased{nthPerson}(:,:,nthSlice));
        end
        
        mask2{nthPerson}(:,:,nthSlice)=decreased{nthPerson}(:,:,nthSlice);
        masked=MRI{nthPerson}(:,:,nthSlice);
        
        for i=1:row %masking part
            for j=1:col
                if mask2{nthPerson}(i,j,nthSlice)==0
                    masked(i,j)=0;
                end
            end
        end
        
        masked_with_Mask2{nthPerson}(:,:,nthSlice)=masked;
    end
end