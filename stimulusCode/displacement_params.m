function [ jitter_pos,jitter_angle,surr_prob, background_bw,contrast_bw ] = displacement_params( type )
    if nargin < 1, type='random'; end

switch type
    case 'full'
        jitter_pos=0; % no random positions of distractors/target
        surr_prob=1; % 100% of probability of occurrence
        jitter_angle=0;
    otherwise
        jitter_pos=1;
        surr_prob=0.25;
        jitter_angle=0;
end

target_bw=[0]; %black
background_bw=[1]; %white
distractor_bw=[0]; %black
contrast_bw=[target_bw,distractor_bw]-background_bw;

end

