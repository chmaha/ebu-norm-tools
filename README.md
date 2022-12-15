# ebu-norm | tp-norm | ebu-scan | ebu-plot

### Installation of scripts
```shell
sudo ./install.sh
```

Copies all scripts and latest sound-gambit binary (if needed) to `usr/local/bin`. 

## ebu-norm & tp-norm

Scripts to batch normalize files to integrated or true peak targets

Prerequisites: `ffmpeg`, `sound-gambit` (https://github.com/x42/sound-gambit)

Fully supported file inputs: wav, aiff (or aif), flac.  
Mp3, opus, ogg and wavpack are first converted to wav before normalizing.

### Process
Files are analyzed by `ffmpeg` with the required gain passed to either `ffmpeg` or `sound-gambit`. 
+/− gain is calculated by the target level minus the analyzed integrated or peak value.
In the case of `ebu-norm`, it uses two analysis passes to ensure that the exact integrated value is reached.
Files are written to a sub-folder with suffix added to filename. User-friendly variables near the top of the `ebu-norm` script are present to allow for tweaking of the limiter settings. 

When using `ebu-norm`with large positive gain amounts into the limiter, it should be noted that excessive limiting is no substitute for correctly mastered files. If you find yourself applying more than a couple of dB of peak limiting, perhaps it is a sign to return to the original file in order to use a compressor plugin or to apply manual gain-riding.

### Usage: 
```shell
ebu-norm [-t target_value] infiles
```
where ```-t``` allows for an integrated target other than -23 LUFS.

If true peaks would rise above -1 dBTP, the `sound-gambit` true-peak limiter is engaged.

```shell
tp-norm [-t target_value] infiles
```
where ```-t``` allows for an true peak target other than -1 dBTP.

#### Examples

```shell
ebu-norm AudioFolder/*.wav
```
will create an `ebu-norm` sub-folder and create -23 LUFS integrated WAV files (default).

```shell
ebu-norm -t -16 AudioFolder/* 
```
will create an `ebu-norm` sub-folder and normalize all supported audio files to -16 LUFS integrated with true-peak limiting as required. 

```shell
tp-norm AudioFolder/*.wav
```
will create a `tp-norm` sub-folder and -1 dBTP WAV files (default). 

```shell
tp-norm -t -2 AudioFolder/*.flac
```
will create a `tp-norm` sub-folder and -2 dBTP FLAC files. 

## ebu-scan

### Usage: 
```shell
ebu-scan [-a] infiles
```
Script to batch analyze audio files and print true peak and various loudness values to screen and text file. If the `-a` flag is added, all files are treated as part of an album and total loudness results are additionally returned. In this instance all files should be the same file format, bit depth, channel count etc.

Prerequisites: `ffmpeg`

Fully supported file inputs: wav, aiff (or aif), flac, ogg, opus, mp3 and wavpack.  

#### Example

```shell
ebu-scan AudioFolder/*.wav
```
Sample formatted terminal output (and also written to analysis.txt):
```shell
File                     True Peak  Integrated  Short-term  Momentary  LRA
                         (dBTP)     (LUFS)      (LUFS)      (LUFS)     (LU)
02 Ubi Caritas.wav       -3.2       -21.7       -14.4       -13.1      15.8
07 Bring Him Home.wav    -9.0       -25.0       -18.6       -17.5      11.5
08 Steal Away.wav        -7.2       -22.4       -16.7       -15.4      12.9
09 Lullaby.wav           -2.5       -22.4       -15.0       -11.8      14.7
11 Over the Rainbow.wav  -6.8       -21.9       -16.6       -14.8      11.9

```

## ebu-plot (beta)
Wrapper script to batch produce PNG loudness graphs using adapted PowerShell script.  
A huge thanks to user L5730 from https://www.audiosciencereview.com/ for the original PowerShell script.  
====_Will move to native bash script for v3.0_====

Prerequisites: `pwsh` (PowerShell), `ffmpeg`, `gnuplot` 

Fully supported file inputs: wav, aiff (or aif), flac, ogg, opus, mp3 and wavpack 

#### Example

```shell
ebu-scan AudioFolder/Sympathique.flac
```
![11 - Sympathique-flac-ebu-plot](https://user-images.githubusercontent.com/79659262/110396624-2d794680-8025-11eb-8de7-64bdc5b154fe.png)

