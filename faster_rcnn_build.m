function faster_rcnn_build(cuda_path)
% faster_rcnn_build()
% --------------------------------------------------------
% Faster R-CNN
% Copyright (c) 2015, Shaoqing Ren
% Licensed under The MIT License [see LICENSE for details]
% --------------------------------------------------------

if nargin < 1
    error('Please specify path to CUDA root.');
end
    
% Compile nms_mex
if ~exist('nms_mex', 'file')
  fprintf('Compiling nms_mex\n');

  mex -O -outdir bin ...
      CXXFLAGS="\$CXXFLAGS -std=c++11"  ...
      -largeArrayDims ...
      functions/nms/nms_mex.cpp ...
      -output nms_mex;
end

if ~exist('nms_gpu_mex', 'file')
   fprintf('Compiling nms_gpu_mex\n');
   addpath(fullfile(pwd, 'functions', 'nms'));
   nvmex('functions/nms/nms_gpu_mex.cu', 'bin', cuda_path);
   delete('nms_gpu_mex.o');
end


