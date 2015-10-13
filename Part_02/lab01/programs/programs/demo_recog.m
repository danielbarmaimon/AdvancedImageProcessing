clear all

% a demostration of using this package

% Recognition Stage

% Only one noised image is examined in this demo
% Two eigenspaces can be choosed: demo_1_2.mat, demo_2_2.mat

choice_3 = input('    Please choose the eigenspace (1-2):  ');
load demo_test_1.mat;

test_eigen_recog;
