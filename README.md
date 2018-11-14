SIG4VAM: Synthetic Image Generator for Visual Attention Modelling
---
This is a code for generating synthetic stimuli

#### RUN

-Run "stimulusCode.m" to generate stimuli
-Files will be saved to "dataset" and "dataset_blocks"
-both masks and extra files will be generated in such folders

#### GENERAL FUNCTIONS:

stimulusCode/common_param_values -> defines the experimental setup (image characteristics, object size ...)
stimulusCode/psicometric_param_values -> defines the psychometric values (psi factor, slope, N ...)
stimulusCode/general/ -> it generates any image of the selected type

### NOTE: The core of the code is based on M.W. Spratling's Code
	Ref: M. W. Spratling (2012) Predictive coding as a model of the V1 saliency map hypothesis. Neural Networks, 26:7-28. 
	DOI: 10.1016/j.neunet.2011.10.002
	URL=https://nms.kcl.ac.uk/michael.spratling/Code/v1_saliency.zip




