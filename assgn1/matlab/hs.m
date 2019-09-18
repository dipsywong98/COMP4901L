clear;

datadir     = '../data';    %the directory containing the images
resultsdir  = '../individual-results'; %the directory for dumping results

%parameters
sigma     = 4;
threshold = 0.1;
rhoRes    = 2;
thetaRes  = pi/90;
nLines    = 50;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));
name = sprintf('img04.jpg');

for i = 1:1
    
    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    imgname = name;
    img = imread(sprintf('%s/%s', datadir, imgname));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
   
    %actual Hough line code function calls%  
    [Im] = myEdgeFilter(img, sigma);   
    [H,rhoScale,thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
    [rhos, thetas] = myHoughLines(H, nLines);
    lines = houghlines(Im>threshold, 180*(thetaScale/pi), rhoScale, [rhos,thetas],'FillGap',5,'MinLength',10);
    
    %everything below here just saves the outputs to files%
    fname = sprintf('%s/%s_01edge.png', resultsdir, imgname);
    figure;
    imshow(sqrt(Im/max(Im(:))));
    imwrite(sqrt(Im/max(Im(:))), fname);
    fname = sprintf('%s/%s_02threshold.png', resultsdir, imgname);
    imwrite(Im > threshold, fname);
    figure;
    imshow(Im > threshold);
    fname = sprintf('%s/%s_03hough.png', resultsdir, imgname);
    imwrite(H/max(H(:)), fname);
    fname = sprintf('%s/%s_04lines.png', resultsdir, imgname);
    
    img2 = img;
    for j=1:numel(lines)
       img2 = drawLine(img2, lines(j).point1, lines(j).point2); 
    end     
    imwrite(img2, fname);
    figure;
    imshow(img2);
end
    