function source = dec(source)

[width,height]=size(source);

for x=1:(width-1)
    for y=1:(height-1)
        if source(x,y) ==0
             if source(x+1,y)==1
                source(x+1,y)=2;
            end
            if source(x+1,y+1)==1 
                source(x+1,y+1)=2;
            end
            if source(x,y+1)==1 
                source(x,y+1)=2;
            end          
        end
    end
end

for x=1:width
    for y=1:height
        if source(x,y) ==2
            source(x,y) =0  ;
        end
    end
end
end