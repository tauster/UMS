function [s, flag] = SetupSerial(COMPort)

flag = 1;

s = serial(COMPort);
set(s, 'DataBits', 8);
set(s, 'StopBits', 1);
set(s, 'BaudRate', 9600);
set(s, 'Parity', 'none');
fopen(s);

fprintf(s, '%c', 'a');

a = 'b';
while(a ~= 'a')
    a = fread(s, 1, 'uchar');
end
if(a == 'a')
    disp('Serial Read');
end
%fprintf(s, '%c', 'a');
abox = msgbox('Serial Connection Setup');
uiwait(abox);
fscanf(s, '%u');
end