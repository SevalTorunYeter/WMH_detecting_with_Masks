%DSC Similarity Index(SI)=2TP/(2TP+FP+FN)
%Accuracy(ACC)=(TP+TN)/(TP+TN+FP+FN)
%sensitivity(sen)=TP/(TP+FN)
%specificity (spec)= TN/(TN+FP) or 1-(FP/(FP+TN))

%load('MRI.mat')
%load pixel_count;

TP=pixel_count.TP;
FP=pixel_count.FP;
FN=pixel_count.FN;
TN=pixel_count.TN;

for i=1:length(MRI)
    [row, col, s]=size(MRI{i});
    SI(:,i)=2*TP(i)/((2*TP(i))+FP(i)+FN(i));
    ACC(:,i)=(TP(i)+TN(i))/(TP(i)+TN(i)+FP(i)+FN(i));
    sens(:,i)=TP(i)/(TP(i)+FN(i));
    spec(:,i)=1-(FP(i)/(FP(i)+TN(i)));
end