data = dlmread('DATALOG.TXT');

x_grid = linspace(min(data(:, 1)), max(data(:, 1)), 11);
y_grid = linspace(min(data(:, 2)), max(data(:, 2)), 11);

[x_mesh, y_mesh] = meshgrid(x_grid, y_grid);
z_mesh = griddata(data(:, 1), data(:, 2), data(:, 3), x_mesh, y_mesh, 'v4');
figure(2)
xlabel('z')
ylabel('x')
zlabel('y')
surf(z_mesh, y_mesh, x_mesh)
hold on
legend = colorbar;
legend.Label.String = 'Elevation (inches)';
%contour3(z_mesh, y_mesh, x_mesh, 30);
%hold on
%plot3(data(:, 1), data(:, 2), data(:, 3));