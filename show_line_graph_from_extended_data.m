%from the network provided graph the 00 const version vs the 09 const
%version
network=1;

%draw the stable steady states with strengths
if(network ==1)
    %network 1
    fname = 'steady_state_strength_net1_00_extended.mat';
    load(fname);
    fname = 'steady_state_strength_net1_09_extended.mat';
    load(fname);
    
else
    fprintf('only network 1 is supported for show_line_graph_from_extended_data\n');
end

close all;
figure(1);

minsize = .001;
lines = zeros(4,size(net1_00,1));
spectral_radii = zeros(4,size(net1_00,1));

a=[1 .1 .1];
b=[.1 1 .1];
c=[.1 .1 1];

%graph all the points from the 00 const
for i=1:size(net1_00,1)
    ss_cur = net1_00{i};
    lines(1,i) = ss_cur(1,4); %+ ss_cur(2,4) + ss_cur(3,4) + ss_cur(5,4);
    lines(2,i) = ss_cur(8,4);
    
    %FIXME: this is lame but we need the alpha values
    a(1) = (i-1)*.2 + 1; 
    b(2) = a(1);
    c(3) = a(1);
    spectral_radii(1,i) = get_spectral_radius(ss_cur(1,1:3),a,b,c); 
    spectral_radii(2,i) = get_spectral_radius(ss_cur(8,1:3),a,b,c);
end

%graph all the points from the 09 const
for i=1:size(net1_09,1)
    ss_cur = net1_09{i};
    lines(3,i) = ss_cur(1,4);
    lines(4,i) = ss_cur(8,4);
    
    %FIXME: this is lame but we need the alpha values
    a(1) = (i-1)*.2 + 1; 
    b(2) = a(1);
    c(3) = a(1);
    spectral_radii(3,i) = get_spectral_radius(ss_cur(1,1:3),a,b,c); 
    spectral_radii(4,i) = get_spectral_radius(ss_cur(8,1:3),a,b,c);
end

%we know that the data was generated from alpha = 1 through 5, spaced .5
alphas = 1:.2:5;

colors = [
    0.00	0.00	0.00 %blk
    1.00    0.50    0.00 %orange
    0.00	0.00    1.00 %blue
    1.00    0.00	0.00 %red
    0.00    0.50	0.00 %green
    1.00    0.50	0.50 %
    0.75    0.75	0.00 %yellow
    0.00    0.75    0.75
    0.75    0.00    0.75
    0.75    0.75    0.75
    1.00    1.00    1.00 %white
    ];

for i=1:4
    
    clr = colors(i,:);
    if(i ==3)
        handle = line(alphas, lines(i,:,1),'color',clr,'linewidth',1.5, 'LineStyle', '--');
    else
        handle = line(alphas, lines(i,:,1),'color',clr,'linewidth',1.5, 'LineStyle', '-');
    end
end

legend('net1 ---','net1 +++','net1 +const ---','net1 +const +++')
