clear;
% Generate dense SIFT from image and save as .bin
addpath(fullfile(pwd,'mexDenseSIFT'));
addpath(fullfile(pwd,'mexDiscreteFlow'));

read_path='/home/cel/PERL/datasets/rgbd_dataset/freiburg1_xyz/rgb/';
save_path='/home/cel/PERL/datasets/rgbd_dataset/freiburg1_xyz/sift_flow/';
files=dir([read_path '*.png']);

SIFTflowpara.alpha=2*255;
SIFTflowpara.d=40*255;
SIFTflowpara.gamma=0.005*255;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=2;
SIFTflowpara.topwsize=10;
SIFTflowpara.nTopIterations = 60;
SIFTflowpara.nIterations= 30;

flow = zeros(480, 640, 2);
flow = reshape(flow, [], 2);
flow = reshape(flow', [], 1);
flow = single(flow);
fileID = fopen([save_path files(1).name(1:17) '.bin'],'w');
fwrite(fileID, flow, 'single');
fclose(fileID);

for i=2:size(files)
    img1 = imread([read_path files(i-1).name]);
    img2 = imread([read_path files(i).name]);
    img1_double = im2double(img1);
    img2_double = im2double(img2);
    
    % Dense SIFT
    cellsize=3;
    gridspacing=1;
    sift1 = mexDenseSIFT(img1_double,cellsize,gridspacing);
    sift2 = mexDenseSIFT(img2_double,cellsize,gridspacing);

    tic;[vx,vy,energylist]=SIFTflowc2f(sift1,sift2,SIFTflowpara);toc

    % display flow
    clear flow;
    flow(:,:,1)=vx;
    flow(:,:,2)=vy;
    flow = reshape(flow, [], 2);    
    flow = reshape(flow', [], 1);
    flow = single(flow);

    % save .bin file
    fileID = fopen([save_path files(i).name(1:17) '.bin'],'w');
    fwrite(fileID, flow, 'single');
    fclose(fileID);
end
