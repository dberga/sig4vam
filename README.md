SIG4VAM: Synthetic Image Generator for Visual Attention Modeling
---
This is a code for generating synthetic stimuli

<img width="624" height="174" alt="image" src="https://github.com/user-attachments/assets/ff9ca5a3-0615-4131-94c8-65113011ecda" />

#### RUN

-Run "stimulusCode.m" to generate stimuli<br/>
-Files will be saved to "dataset" and "dataset_blocks"<br/>
-both masks and extra files will be generated in such folders

#### GENERAL FUNCTIONS:

stimulusCode/common_param_values -> defines the experimental setup (image characteristics, object size ...)<br/>
stimulusCode/psicometric_param_values -> defines the psychometric values (psi factor, slope, N ...)<br/>
stimulusCode/general/ -> it generates any image of the selected type

#### Please, if you use this code, cite these two articles:
Dataset psychophysics: https://www.sciencedirect.com/science/article/pii/S0042698918302207

Dataset saliency benchmark: https://ieeexplore.ieee.org/document/9008799

Also see The CVF publication [here](https://openaccess.thecvf.com/content_ICCV_2019/html/Berga_SID4VAM_A_Benchmark_Dataset_With_Synthetic_Images_for_Visual_Attention_ICCV_2019_paper.html)

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
@inproceedings{Berga2019_ICCV,
  title = {SID4VAM: A Benchmark Dataset With Synthetic Images for Visual Attention Modeling},
  url = {http://dx.doi.org/10.1109/ICCV.2019.00888},
  DOI = {10.1109/iccv.2019.00888},
  booktitle = {2019 IEEE/CVF International Conference on Computer Vision (ICCV)},
  publisher = {IEEE},
  author = {Berga,  David and Vidal,  Xose Ramon Fernandez and Otazu,  Xavier and Pardo,  Xose M.},
  year = {2019},
  month = Oct,
  pages = {8788–8797}
}
````

### NOTE: The core of the code is based on previous M.W. Spratling's Code
	Ref: M. W. Spratling (2012) Predictive coding as a model of the V1 saliency map hypothesis. Neural Networks, 26:7-28. 
	DOI: 10.1016/j.neunet.2011.10.002
	URL=https://nms.kcl.ac.uk/michael.spratling/Code/v1_saliency.zip

### SID4VAM: Synthetic Image Dataset for Visual Attention Modeling
Note: You can use this as test set and use the generator (SIG4VAM) with the automatically generated masks to train your model at wish. We use a [this benchmark](https://github.com/dberga/saliency) for saliency evaluation.

> Images and Masks: [https://drive.google.com/drive/folders/1YV_VGRlmPoJnYlh1W0c1REBzjQZCXQyk?usp=sharing](https://drive.google.com/drive/folders/1YV_VGRlmPoJnYlh1W0c1REBzjQZCXQyk?usp=sharing)

> Fixation Data and more: [https://drive.google.com/drive/folders/11VYqWsy0AY1aO7IJYqs_7ITJW8d-n5wi?usp=sharing](https://drive.google.com/drive/folders/11VYqWsy0AY1aO7IJYqs_7ITJW8d-n5wi?usp=sharing)

<img width="671" height="598" alt="image" src="https://github.com/user-attachments/assets/d6828a9c-8724-437b-8574-f7e104a5bf79" />
<img width="674" height="577" alt="image" src="https://github.com/user-attachments/assets/35fddda2-c7ab-4075-87c4-599cc73661ed" />
<img width="688" height="577" alt="image" src="https://github.com/user-attachments/assets/1729237f-5bb8-42a4-9821-55ace6b5fd2c" />
<img width="672" height="792" alt="image" src="https://github.com/user-attachments/assets/5653d30e-87f5-4841-8cd7-bbedcd4a8a93" />

## Results
<img width="711" height="789" alt="image" src="https://github.com/user-attachments/assets/9b8ad356-3e4c-4c7f-a286-dc5fd2c31a99" />
<img width="833" height="739" alt="image" src="https://github.com/user-attachments/assets/31085dcf-d9d7-47ed-9f0b-bd169517c0d5" />
<img width="527" height="567" alt="image" src="https://github.com/user-attachments/assets/af1e8cc2-642c-468a-95bc-98ed82d4bed1" />
<img width="514" height="300" alt="image" src="https://github.com/user-attachments/assets/e94cad64-0ff9-49f8-a5ef-1bff43f98df9" />
<img width="1216" height="356" alt="sindexplots" src="https://github.com/user-attachments/assets/410ba637-5f84-478c-b0d9-f77b32099c5e" />


