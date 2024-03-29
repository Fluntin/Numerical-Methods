function L=kanslighetLU()

% Clear the command window and any open figures
clc
close all

% Create a new figure window
figure()

% Load data for a truss structure from a file
load('eiffel1.mat')
num_nodes=261;
% Define the number of nodes in the truss structure

% Initialize a vector of external forces
external_forces = zeros(2*num_nodes, 1);

% Initialize a vector to store the displacement at each node in the truss
node_displacements = zeros(num_nodes, 1);

% Compute the LU factorization of the matrix A

[L, U] = lu(A);

% Loop over all elements of the external force vector
tStart=tic;
for i = 1:size(external_forces)
    
    % For elements with even indices, set the corresponding external force to -1 to apply a load in the y direction
    if mod(i, 2) == 0
        
        % Compute the displacement at each node using matrix algebra
        node_index = i / 2;
        external_forces(i) = -1;
        y = L \ external_forces;
        displacement_vector = U \ y;
        
        
        % Compute the total displacement at each node using the x and y displacement components
        total_displacement = 0;
        for displacement_index = 1:2:size(displacement_vector)
            delta_x = displacement_vector(displacement_index);
            delta_y = displacement_vector(displacement_index + 1);
            total_displacement = ((delta_x^2) + (delta_y^2));
        end
        node_displacements(node_index) = sqrt(total_displacement);
    end
    
    % Reset the external force vector for the next iteration of the loop
    external_forces = zeros(2*num_nodes, 1);
end
tStop=toc(tStart);
L=tStop;

% Find the maximum and minimum values of the node displacement vector and their corresponding node indices
[max_displacement, max_index] = max(node_displacements);
[min_displacement, min_index] = min(node_displacements);

% Find the x and y coordinates of the nodes corresponding to the maximum and minimum displacement values
max_y_node = ynod(max_index);
max_x_node = xnod(max_index);
min_y_node = ynod(min_index);
min_x_node = xnod(min_index);

% Plot the truss structure
trussplot(xnod, ynod, bars)

% Overlay the location of the maximum and minimum displacements as red circles and stars, respectively
hold on
plot(max_x_node, max_y_node, "ro")
plot(min_x_node, min_y_node, "r*")
end