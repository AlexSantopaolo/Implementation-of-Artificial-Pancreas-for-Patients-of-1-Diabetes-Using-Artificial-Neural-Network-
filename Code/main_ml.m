%%Implementation of Artificial Pancreas

%Syed Saad Saif 
%Santopaolo Alessandro

% Before running the code please run init.m to initialise all the variables.
% Using Non-linear Model Predictive Control based on Hovorka model

clc;
close all;
nlobj = nlmpc(8,1,1); %8 States, 1 Output, 1 Input
Ts = 15;  %Sampling time of the system
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 5;
nlobj.ControlHorizon    = 4; 
nlobj.Model.StateFcn    = 'pancDTNOUG'; 
nlobj.Model.IsContinuousTime   = false;
nlobj.Model.NumberOfParameters = 1; % Number of parameters passes to the model
nlobj.Model.OutputFcn = @(x,u,Ts) x(1);

%Implementation of Custom Cost Function

nlobj.Optimization.CustomCostFcn       ='myCostFunction';
nlobj.Optimization.ReplaceStandardCost = true;

% nlobj.Weights.OutputVariables = 1;    %optimise it
% nlobj.Weights.ManipulatedVariablesRate = 0.1; %optimise it
% nlobj.OV.Min = 0.5; 
% nlobj.OV.Max = 2; %optimise it
% nlobj.MV.Min = 0;
% nlobj.MV.Max = 1; %insulin pump %optimise it

x0 = [0.9610316458536540; %Experimentally found equilibrium state
      0.7022190020480630;
      9.4710831378935500;
      9.9763282570318200;
      11.013534851338600;
      0.0548876753724354;
      0.0090264114840940;
      0.0045307057420470]; %An equilibrium conditions

%x_for_ml = x0; %collect training data for machine learning
%u_for_ml = 0;
initial_glucose_level = 0.4 + rand()*0.8;

global meal_time;
global d_g;

d_g = rand(1,4)*0.8 + 0.2; 
meal_time = ceil(rand(1,4)*20 + [20 80 140 200]);
x0(1) = initial_glucose_level;

u0  = 0;       %first controller output
u_History = u0;
t_History = 0;

param_mpc = [Ts,0];
validateFcns(nlobj, x0, u0, [], {param_mpc});

x    = x0;
y    = x0(1);

yref  = 0.96; %% express MMOL ( 6 in MMOL/L)

nloptions = nlmpcmoveopt;
nloptions.Parameters = {param_mpc};

Duration    = 300;
xHistory    = x;


%Generate reference tracking trajectory

a=-sign(x0(1)-yref);
yreftrack=x0(1)+a*0.1;
yref_adapt=yreftrack;

    tic
    for ct = 1:(Duration/Ts) % ct = current time
        param = [Ts,ct];
        xk = x;
        % Compute optimal control output
        y = xk(1);
        k = 0;
        if(y >yref)
            k = 0.2;
        else
            if(y<yref)
              k = 0.5;
            end
        end
        
        yref_adapt= yref_adapt + k*(yref - y);
        
        if(y>yref && yref_adapt<yref)
            yref_adapt = yref;
        end
        
        if(y<yref && yref_adapt>yref)
            yref_adapt = yref;
        end
        
        %generate controller output from nlmpc
        
        %[mv,nloptions] = nlmpcmove(nlobj,xk,mv,yref_adapt,[],nloptions);
        
        %generalte machine controller output from Artificial Neural Network
        
        mv = ml_cont(xk);

        % Simulate the system for the calculated controller outputs
        
        x = pancDT(x,mv,param);
        %x_ml = pancDT(x,mv_ml,param);


        % Generate sensor data
        
        y = x([1]); % + randn(1)*0.01;
        t_History=[t_History ct];
        u_History=[u_History mv];
        
        yreftrack=[yreftrack yref_adapt];
        
        % Save plant states
        
        xHistory = [xHistory x];
        
    end
    %x_for_ml = [x_for_ml xHistory]; %data augmented for crealting machine learning data
    %u_for_ml = [u_for_ml u_History];
toc

%% Plot the simulated Glucose-Insulin System

clear figure;
subplot(5,1,1);
hold on;
plot(0:Ts:Duration,xHistory(1,:),'-o')
plot(0:Ts:Duration,xHistory(2,:),'-o')
plot(0:Ts:Duration,yreftrack,'-o')

legend('Q1','Q2','yref');

subplot(5,1,2);
hold on;
plot(0:Ts:Duration,xHistory(3,:),'-o')
plot(0:Ts:Duration,xHistory(4,:),'-o')
legend('S1','S2');

subplot(5,1,3);
hold on;
stairs(0:Ts:Duration,u_History)
legend('ut');


subplot(5,1,4);
plot(0:Ts:Duration,xHistory(5,:),'-o')
legend('I');

subplot(5,1,5);
hold on;
plot(0:Ts:Duration,xHistory(6,:),'-o')
plot(0:Ts:Duration,xHistory(7,:),'-o')
plot(0:Ts:Duration,xHistory(8,:),'-o')
legend('x1','x2','x3');



