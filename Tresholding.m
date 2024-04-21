%load masked_with_Mask2; %or load masked_with_Mask1;
%load MRI; %you need to load usual MR image or skul stripped image as .mat file
for nthPerson=1:length(masked_with_Mask2)
    [row col slice]=size(masked_with_Mask2{nthPerson});
    for nthSlice=1:slice
        A=masked_with_Mask2{nthPerson}(:,:,nthSlice);
        B=double(MRI{nthPerson}(:,:,nthSlice));
        mn=mean(B(B>0));
        sigma=std(B(B>0));
        
        if  nthSlice<slice*0.32
            WMH=zeros(size(A));
        elseif nthSlice>(slice-(slice*0.20))
            WMH=zeros(size(A));
        elseif sigma<=5
            WMH=zeros(size(A));
            treshold=mn+20*sigma;
            index=A>mn+20*sigma;
            WMH(index)=A(index);
        elseif sigma>5 && sigma<9
            WMH=zeros(size(A));
            treshold=mn+10*sigma;
            index=A>mn+10*sigma;
            WMH(index)=A(index);
        elseif sigma>=9 && sigma<15
            WMH=zeros(size(A));
            treshold=mn+2*sigma;
            index=A>mn+2*sigma;
            WMH(index)=A(index);
        elseif  sigma>=15 && sigma<40
            WMH=zeros(size(A));
            treshold=mn+1.25*sigma;
            index=A>mn+1.25*sigma;
            WMH(index)=A(index);
        else
            WMH=zeros(size(A));
            treshold=mn+sigma;
            index=A>mn+sigma;
            WMH(index)=A(index);
        end
        
        Estimated_WMH_Mask2{nthPerson}(:,:,nthSlice)=WMH;
        %Estimated_WMH_Mask1{nthPerson}(:,:,nthSlice)=WMH;        
    end
end