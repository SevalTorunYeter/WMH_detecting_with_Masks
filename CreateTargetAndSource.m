%load('Estimated_WMH_Mask1.mat');
%load('Estimated_WMH_Mask2.mat');
%load('MRI.mat');
Source.Original=MRI;
%Source.MyWork=Estimated_WMH_Mask1;
Source.MyWork=Estimated_WMH_Mask2;
save('Source.mat','Source');

for nthPerson=1:length(MRI)
    [row, col, slice]=size(MRI{nthPerson});
    for nthSlice=1:slice
        OverEstimate{nthPerson}(:,:,nthSlice)=zeros(row, col);
        UnderEstimate{nthPerson}(:,:,nthSlice)=zeros(row, col);
       % OverEstimate{nthPerson}(:,:,nthSlice)=NaN;
       % UnderEstimate{nthPerson}(:,:,nthSlice)=NaN;
    end
end
Target.OverEstimate=OverEstimate;
Target.UnderEstimate=UnderEstimate;
%save('Target_Mask1.mat','Target');
save('Target_Mask2.mat','Target');