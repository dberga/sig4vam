SIG4VAM: Synthetic Image Generator for Visual Attention Modeling
---
This is a code for generating synthetic stimuli

#### RUN

-Run "stimulusCode.m" to generate stimuli<br/>
-Files will be saved to "dataset" and "dataset_blocks"<br/>
-both masks and extra files will be generated in such folders

#### GENERAL FUNCTIONS:

stimulusCode/common_param_values -> defines the experimental setup (image characteristics, object size ...)<br/>
stimulusCode/psicometric_param_values -> defines the psychometric values (psi factor, slope, N ...)<br/>
stimulusCode/general/ -> it generates any image of the selected type

#### Please, if you use this code, cite:

````
@article{Berga_2019_VisRes,
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

@InProceedings{Berga_2019_ICCV,
author = {Berga, David and Fdez-Vidal, Xose R. and Otazu, Xavier and Pardo, Xose M.},
title = {SID4VAM: A Benchmark Dataset With Synthetic Images for Visual Attention Modeling},
booktitle = {The IEEE International Conference on Computer Vision (ICCV)},
month = {October},
year = {2019}
}

````


### NOTE: The core of the code is based on previous M.W. Spratling's Code
	Ref: M. W. Spratling (2012) Predictive coding as a model of the V1 saliency map hypothesis. Neural Networks, 26:7-28. 
	DOI: 10.1016/j.neunet.2011.10.002
	URL=https://nms.kcl.ac.uk/michael.spratling/Code/v1_saliency.zip




