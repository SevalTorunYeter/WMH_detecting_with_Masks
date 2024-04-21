%load('MRI.mat')
%load('Target_Mask1.mat')
%load('Target_Mask2.mat')
%load('Estimated_WMH_Mask1.mat')
%load('Estimated_WMH_Mask2.mat')

FP=Target.OverEstimate;


for nthPerson=1:length(Estimated_WMH_Mask2)
    [row, col, Slice]=size(Estimated_WMH_Mask2{nthPerson});
    FP_pixel_count=0;
    FN_pixel_count=0;
    TP_pixel_count=0;
    TN_pixel_count=0;

    for nthSlice=1:Slice     
        FN{nthPerson}(:,:,nthSlice)=zeros(row, col);
        TP{nthPerson}(:,:,nthSlice)=zeros(row, col);
        TN{nthPerson}(:,:,nthSlice)=zeros(row, col);
        True_WMH{nthPerson}(:,:,nthSlice)=zeros(row, col);
        for i=1:row
            for j=1:col
                if Target.UnderEstimate{nthPerson}(i,j,nthSlice)~=0 && Estimated_WMH_Mask2{nthPerson}(i,j,nthSlice)==0
                    FN{nthPerson}(i,j,nthSlice)=1;
                    FN_pixel_count=FN_pixel_count+1;
                end
                if FP{nthPerson}(i,j,nthSlice)~=0 && FN{nthPerson}(i,j,nthSlice)~=0
                    FP{nthPerson}(i,j,nthSlice)=0;
                end
                if FP{nthPerson}(i,j,nthSlice)~=0 
                    FP_pixel_count=FP_pixel_count+1;
                end
                if FP{nthPerson}(i,j,nthSlice)==0 && Estimated_WMH_Mask2{nthPerson}(i,j,nthSlice)~=0
                    TP{nthPerson}(i,j,nthSlice)=1;
                    TP_pixel_count=TP_pixel_count+1;
                end
                if FP{nthPerson}(i,j,nthSlice)==0 && TP{nthPerson}(i,j,nthSlice)==0 && FN{nthPerson}(i,j,nthSlice)==0
                    TN{nthPerson}(i,j,nthSlice)=1;
                    TN_pixel_count=TN_pixel_count+1;
                end
                if FN{nthPerson}(i,j,nthSlice)==1 ||  TP{nthPerson}(i,j,nthSlice)==1
                    True_WMH{nthPerson}(i,j,nthSlice)=1;
                end
            end
        end
    end
    pixel_count.TP(:,nthPerson)=TP_pixel_count;
    pixel_count.FP(:,nthPerson)=FP_pixel_count;
    pixel_count.FN(:,nthPerson)=FN_pixel_count;
    pixel_count.TN(:,nthPerson)=TN_pixel_count;
end
