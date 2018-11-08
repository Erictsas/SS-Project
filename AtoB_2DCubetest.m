fileID = fopen('data.txt','r');
formatSpec = '%f';
d = 0.02;
c = 340;
f = 8000;
w = 2*pi*f;
audio_channels = audioTest(fileID);

LF = audio_channels(:,1);
RF = audio_channels(:,2);
LB = audio_channels(:,3);
RB = audio_channels(:,4);

%Fw = (1+1j*w*d/c-1/3*(w*d/c)^2)/(1/3*1j*w*d/c);
%Fxyz = sqrt(6)*(1+1/3*1j*w*d/c-1/3*(w*d/c)^2)/(1/3*1j*w*d/c);
Fw=1;
Fxyz=1000;

W = Fw.*(LF+RF+LB+RB);
X = Fxyz.*(LF+RF-LB-RB);
Y = Fxyz.*(LF-RF+LB-RB);
%Z = Fxyz.*(FLU-FRD-BLD+BRU);

% sum = 0.9397*W+0.1856*X;
% delta = 1j*(-0.3420*W+0.5099*X)+0.6555*Y;
% T = 1j*(-0.1432*W+0.6512*X)-0.7072*Y;
% Q = 0.9772*Z;
% 
% L = 0.5*(sum+delta);
% R = 0.5*(sum-delta);

Mid = (real(W)*sqrt(2)) + real(X);  % This is a cardioid response pointing forward
Left = Mid + real(Y);
Right = Mid - real(Y);

Left = (Left-mean(Left))/(max(Left)-mean(Left));
if(min(Left)<-1)
    Left = Left/(-min(Left));
end
Right = (Right-mean(Right))/(max(Right)-mean(Right));
if(min(Right)<-1)
    Right = Right/(-min(Right));
end


% Left = (X + Y)/sqrt(2)   /* (Left, Right) are just the (Y, X) */
% Right = (X - Y)/sqrt(2)  /* responses rotated by -45 degrees  */
play = [Left Right];
audiowrite('C:\Users\Eric\Documents\UU-Arbete\Spatial Sound Project\matlabSkapadCubeB.wav',play,f);
