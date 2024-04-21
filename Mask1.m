
%load MRI; %you need to load usual MR image or skul stripped image as .mat file
%load SPM_wm100; %you need to load the same images WM parts as .mat file

for nthPerson=1:length(SPM_wm100)
    [row,col,slice]=size(SPM_wm100{nthPerson});
    
    for nthSlice=1:slice
        
        img=double(SPM_wm100{nthPerson}(:,:,nthSlice));
        
        painted_pointinside = PaintContiguous(img);
        new_painted_pointinside{nthPerson}(:,:,nthSlice)=painted_pointinside;
         for i=1:row
            for j=1:col
                if painted_pointinside(i,j)==-5
                    painted_pointinside(i,j)=0;
                else
                    painted_pointinside(i,j)=1;
                end
            end
        end
        
        decreased_pointinside=dec(painted_pointinside);
        mask1{nthPerson}(:,:,nthSlice)=decreased_pointinside;
        
        masked=MRI{nthPerson}(:,:,nthSlice);
        for i=1:row %masking part
            for j=1:col
                if decreased_pointinside(i,j)==0
                    masked(i,j)=0;
                end
            end
        end   
        masked_with_mask1{nthPerson}(:,:,nthSlice)=masked;
    end
end