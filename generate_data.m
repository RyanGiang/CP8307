imgPath = 'E:\MEng\CP8307\Final Project\Forest Segmented\images\';
newPath = 'E:\MEng\CP8307\Final Project\mod_datasets\';

dCell = dir([imgPath '*.jpg']);

for d = 1:length(dCell)
    img = imread([imgPath dCell(d).name]);
    gray = rgb2gray(img);
    img = im2double(img);
    
    %Adding Gaussian Noise
    Im_noise = imnoise(img, 'gaussian', 0, 0.001);
    fullFileName = fullfile('gnoise', dCell(d).name);
    imwrite(Im_noise, fullFileName);
    
    %Highboost filtering with k=5
    Im_blur = imfilter(gray, fspecial('gaussian', 5, 2.5));
    diff = gray - Im_blur;
    diff = im2double(diff);
    hbf_1 = img + 5*diff;
    fullFileName = fullfile('edge', dCell(d).name);
    imwrite(hbf_1, fullFileName);
    
    %Histogram Normalization
    min_val = min(img(:));
    max_val = max(img(:));

    % Scale the image intensities to the range [0, 1]
    Im_hist = (img - min_val) / (max_val - min_val);
    fullFileName = fullfile('histo', dCell(d).name);
    imwrite(Im_hist, fullFileName);
    
    %Add Noise to Edge Enhanced Dataset
    Im_edge_noise = imnoise(hbf_1, 'gaussian', 0, 0.001);
    fullFileName = fullfile('edge_gnoise', dCell(d).name);
    imwrite(Im_edge_noise, fullFileName);
    
    %Apply Edge Enhancement ot Histogram Dataset
    Im_edge_histo = Im_hist + 5*diff;
    fullFileName = fullfile('edge_histo', dCell(d).name);
    imwrite(Im_edge_histo, fullFileName);

    %Add Noise to Histogram Dataset
    Im_histo_noise = imnoise(Im_hist, 'gaussian', 0, 0.001);
    fullFileName = fullfile('gnoise_histo', dCell(d).name);
    imwrite(Im_histo_noise, fullFileName);

    %Add Noise to Histogram and Edge Enhancement Dataset
    Im_all = imnoise(Im_edge_histo, 'gaussian', 0, 0.001);
    fullFileName = fullfile('all', dCell(d).name);
    imwrite(Im_all, fullFileName);

end