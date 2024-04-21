function result = PaintContiguous(source)
resultX=2;
resultY=2;
paintColor=-5;
targetColor=0;

result= source;

[width, height]=size(result);
result(resultX, resultY) = paintColor;
painted=true;
while painted
    painted=false;
    for x=2:width-1
        for y=2:height-1
            if (result(x, y) == paintColor)
                if (result(x - 1, y - 1) == targetColor)
                    result(x - 1, y - 1) = paintColor;painted=true;
                end
                if (result(x - 1, y) == targetColor)
                    result(x - 1, y) = paintColor;painted=true;
                end
                if (result(x - 1, y + 1) == targetColor)
                    result(x - 1, y + 1) = paintColor;painted=true;
                end
                if (result(x, y - 1) == targetColor)
                    result(x, y - 1) = paintColor;painted=true;
                end
                if (result(x, y + 1) == targetColor)
                    result(x, y + 1) = paintColor;painted=true;
                end
                if (result(x + 1, y - 1) == targetColor)
                    result(x + 1, y - 1) = paintColor;painted=true;
                end
                if (result(x + 1, y) == targetColor)
                    result(x + 1, y) = paintColor;painted=true;
                end
                if (result(x + 1, y + 1) == targetColor)
                    result(x + 1, y + 1) = paintColor;painted=true;
                end
            end
        end
    end
end
end