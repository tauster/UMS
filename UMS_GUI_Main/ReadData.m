function [r, h, t] = ReadData(out)

readings = [0, 0, 0];

fprintf(out.s, 'R');
readings(1) = fscanf(out.s, '%u');

fprintf(out.s, 'H');
readings(2) = fscanf(out.s, '%u');

fprintf(out.s, 'A');
readings(3) = fscanf(out.s, '%u');

if(readings(1) < 0)
    readings(1) = 0;
end
if(readings(2) < 0)
    readings(2) = 0;
end
if(readings(3) < 0)
    readings(3) = 0;
end

r = readings(1);
h = readings(2);
t = readings(3);

end