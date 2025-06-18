%% main script to run the cruise control example

% define PCSSP modules and top model class instances
[topm,obj_voiture,obj_controller] = cruise_control_topm_obj();

% initialize and setup all PCSSP models
topm.init;
topm.setup;

%% compile and simulate

topm.compile;
out = topm.sim;
simout = logsout2struct(out);

%% plot

h = tiledlayout(3,1,'TileSpacing','compact','Padding','compact');

h1 = nexttile;
plot(h1,simout.follower_position_position.Time,simout.follower_position_position.Values);
hold on;
plot(h1,simout.leader_position_position.Time,simout.leader_position_position.Values);
legend(h1,'follower position','leader position')

h2 = nexttile;

plot(h2,simout.velocity_error.Time,simout.velocity_error.Values);
legend(h2,'velocity error')

h3 = nexttile;
plot(simout.controller_mode.Time,simout.controller_mode.Values);
legend(h3,'controller mode');

h.XLabel.String = 't (s)';