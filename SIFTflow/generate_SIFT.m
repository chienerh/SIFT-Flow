clear;
% Generate dense SIFT from image and save as .bin
addpath(fullfile(pwd,'SIFTflow'));
addpath(fullfile(pwd,'mexDenseSIFT'));
addpath(fullfile(pwd,'mexDiscreteFlow'));

read_path='/home/cel/PERL/datasets/rgbd_dataset/freiburg1_xyz/rgb/';
save_path='/home/cel/PERL/datasets/rgbd_dataset/freiburg1_xyz/sift/';
files=dir([read_path '*.png']);

for i=1:1%size(files)
    img = imread([read_path files(i).name]);
    img_double = im2double(img);
    
    % Dense SIFT
    cellsize=3;
    gridspacing=1;
    sift = mexDenseSIFT(img_double,cellsize,gridspacing);
    sift = single(sift);
    sift = reshape(sift, [], 128);
    
    % PCA
%     [coeff,score,latent,~,explained] = pca(sift);
%     PCA1 = sift*coeff(:,1);
%     PCA2 = sift*coeff(:,2);
%     PCA3 = sift*coeff(:,3);
%     sift_pca = zeros(307200, 8);
%     for p=1:8
%         sift_pca(:,p) = sift*coeff(:,p);
%     end
%     
%     sift_pca = single(sift_pca);
%     sift_pca = reshape(sift_pca', [], 1);

    sift = reshape(sift', [], 1);
    
    % save .bin file
    fileID = fopen([save_path files(i).name(1:17) '.bin'],'w');
    fwrite(fileID, sift, 'float');
    fclose(fileID);
end