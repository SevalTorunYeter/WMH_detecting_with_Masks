# WMH  detection study

This study is about detecting WMH (white matter hyperintensity) in brains that have vascular or ischemic disease. Axial T2 Flair images were used for original study. 
Using these files with that order is recommended:  
1.Mask1.m (To obtain a mask. You can skip this, Mask2.m has better performance)  
2.Mask2.m (To obtain a mask.)  
3.Tresholding (To detect WMH)  
4.CreateTargetAndSource.m (It's for using ExpertView.mlapp, you can skip this if you have proper files.)  
5.ExpertView.mlapp (This is for manual marking. If you don't interest to evaluating the results, you can skip this)  
6.AnalyzeResult.m (If you don't interest to evaluating the results you can skip this)  
7.SuccessEvaluation.m (If you don't interest to evaluating the results you can skip this)  

There are files were used:

## SampleImages.mat
This file represents a typical .mat file was used in this study. This file contains fake images.  
Format:
SampleImages{1 x 3}(20 x 20 x 5) int16.  
{1 x 3} means there are images for 3 people  
(20 x 20 x 5) means 5 slices contains 20x20 pixels.
To achieve this format, we added images of all people consecutively.

## Mask1.m
To use this file you need to have 2 types of brain MR images in .nifti form, turn them to .mat file like above, normalize their pixels 0-255 and load them. I used this names: MRI and SPM_wm100.

The first .mat file should be either usual brain MR image or SkullStripped brain MR image (for skull-stripping I used BET from FSL -https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET-). 
This first .mat file will be the base for determining WMH.   

The second .mat file should be only White Metter (WM) parts from the same image. For WM parts, I used SPM12 that is a MATLAB based program (https://www.fil.ion.ucl.ac.uk/spm/software/spm12/).
I used pixels have value more than 100.
This second file will be the mask. WMH areas are searched on original or skull striped images. But we can not search whole image. So, a mask was created. This mask was applied to the image and search WMH only corresponding parts.

There are 2 functions using this matlab file, all loaded here. First function is named 'PaintContiguous.m'. Second function is 'dec.m'.

## PaintContiguous.m
This function needs to get one slice of the SPM image (as double instead of int). This function paints SPM's WM areas for getting a mask.

## dec.m
This function gets painted image and decreases boundries of painted image.

## Mask2.m
Mask2 was developed to increase the performance of Mask1. Same functions, data and variables used in Mask1.

## Tresholding.m
To determine WMH, some tresholds were applied images after applying a mask.Pixels over these tresholds were determined as WMH.

## ExpertView.mlapp
To decide estimated WMHs are true of false, this screen was designed. This screen provides us to mark manually true and false areas. When you open this file you should load 2 files. First one is Source file. Second one is Target file.
At first Source should have 1x1 struct with 2 fields properties as follow:

'Source.Original' shold be the original images (for example SampleImages). 
'Source.MyWork' should be Estimated_WMH_Mask1 or Estimated_WMH_Mask2 (outputs of Tresholding.m).

At first Target hould have 1x1 struct with 2 fields properties as follow: 
'Target.OverEstimate' and  
'Target.UnderEstimate ' both are matrix with zeros size of original images.

After loading to start press next image for the first time.

## CreateTargetAndSource.m
I used this file to create Source and Target files for using ExpertView.mlapp.

## AnalyzeResult.m
This file developed fo detecting False Positive (FP), False Negative (FN), True Positive (TP) and True Negative (TN).

## SuccessEvaluation.m
To evaluate success this method I developed this file. To run this file pixel_count from AnalyzeResult.m file should be loaded.
