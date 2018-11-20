SIG4VAM: Synthetic Image Generator for Visual Attention Modeling
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

#### Please, if you use this code, cite:

````
@article{Berga2019a,
title = "Psychophysical evaluation of individual low-level feature influences on visual attention",
journal = "Vision Research",
volume = "154",
pages = "60 - 79",
year = "2019",
issn = "0042-6989",
doi = "https://doi.org/10.1016/j.visres.2018.10.006",
url = "http://www.sciencedirect.com/science/article/pii/S0042698918302207",
author = "David Berga and Xosé R. Fdez-Vidal and Xavier Otazu and Víctor Leborán and Xosé M. Pardo"
}
````


### NOTE: The core of the code is based on previous M.W. Spratling's Code
	Ref: M. W. Spratling (2012) Predictive coding as a model of the V1 saliency map hypothesis. Neural Networks, 26:7-28. 
	DOI: 10.1016/j.neunet.2011.10.002
	URL=https://nms.kcl.ac.uk/michael.spratling/Code/v1_saliency.zip




