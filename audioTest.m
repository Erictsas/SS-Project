clear all
fileID = fopen('data.txt','r');
formatSpec = '%f';
data = fscanf(fileID,formatSpec);

%%Creates 4 empty vectors for our data
channel1 = zeros(length(data)/4,1);
channel2 = zeros(length(data)/4,1);
channel3 = zeros(length(data)/4,1);
channel4 = zeros(length(data)/4,1);

i = 1;
printToChannel = 1;
channel1Pointer = 1;
channel2Pointer = 1;
channel3Pointer = 1;
channel4Pointer = 1;
while(i<=length(data))%%Splits the data in 4 vectors
    if(printToChannel == 1)
        channel1(channel1Pointer) = data(i);
        channel1Pointer = channel1Pointer + 1;
        printToChannel = 2;
    elseif(printToChannel == 2)
        channel2(channel2Pointer) = data(i);
        channel2Pointer = channel2Pointer + 1;
        printToChannel = 3;
    elseif(printToChannel == 3)
        channel3(channel3Pointer) = data(i);
        channel3Pointer = channel3Pointer + 1;
        printToChannel = 4;
    elseif(printToChannel == 4)
        channel4(channel4Pointer) = data(i);
        channel4Pointer = channel4Pointer + 1;
        printToChannel = 1;
    end
    i = i + 1;
end
fs = 8000; %Fix sample rate in arduino code
dt = 1/fs;
t = 0:dt:(length(channel1)*dt)-dt;

%%Normalize the data(-1 to +1)
channel1 = (channel1-mean(channel1))/(max(channel1)-mean(channel1));
if(min(channel1)<-1)
    channel1 = channel1/(-min(channel1));
end
channel2 = (channel2-mean(channel2))/(max(channel2)-mean(channel2));
if(min(channel2)<-1)
    channel2 = channel2/(-min(channel2));
end
channel3 = (channel3-mean(channel3))/(max(channel3)-mean(channel3));
if(min(channel3)<-1)
    channel3 = channel3/(-min(channel3));
end
channel4 = (channel4-mean(channel4))/(max(channel4)-mean(channel4));
if(min(channel4)<-1)
    channel4 = channel4/(-min(channel4));
end

figure(1)
plot(t,channel1)
title('LeftFront')
xlabel('Time [s]')
ylabel('Amplitude')
figure(2)
plot(t,channel2)
title('RightFront')
xlabel('Time [s]')
ylabel('Amplitude')
figure(3)
plot(t,channel3)
title('LeftBack')
xlabel('Time [s]')
ylabel('Amplitude')
figure(4)
plot(t,channel4)
title('RightBack')
xlabel('Time [s]')
ylabel('Amplitude')

y = zeros(length(channel1),6);
y(:,1) = channel1;%%LeftFront
y(:,2) = channel2;%%RightFront
y(:,3);%%Center
y(:,4);%%Bass
y(:,5) = channel3;%%LeftBack
y(:,6) = channel4;%%RightBack


audiowrite('C:\Users\Eric\Documents\UU-Arbete\Spatial Sound Project\matlabSkapad.wav',y,fs);