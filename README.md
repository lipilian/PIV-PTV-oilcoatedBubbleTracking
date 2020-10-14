# PIV-PTV-oilcoatedBubbleTracking

# Step progress
- [x]  build ptv piv analysis folder (data folder)

    Run python [script](https://github.com/lipilian/PIV-PTV-oilcoatedBubbleTracking/blob/master/CreateDatafolder.py) create [data](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn) folder, which includes all the cases.

- [x] run piv processing for all case.(09/19/2020)

- [x] Detect the Raising period.

- [x] Remove the background noise for bubble trajectory tracking.

1)	Call image sequence: ‘file’-‘import’-‘image sequence’
2)	Compute background: ‘image’-‘stacks’-‘z project’-‘projection type:min intensity’
3)	Remove background: ‘process’-‘image calculator’-‘operatioin:substract’
4)	Sharpen the contrast: ‘process-‘enhance contrast’-‘saturated pixels:0.3%’
5)	Save filtered sequence: ‘file’-‘save as’-‘image sequence’-‘format:jpeg’

- [x] PTV point detection, Gaussian kernel blob detection.
1) Face the problem about the laser light too light for some frames that it hard to detect the blob shape for certain case, which cause trajectory divergent and mixing. <ul><li>- [x]  </li> solved 09/24/2020 by using predictor method, which use the recently nearby velocity to predict the next frame bubble location. For each case, the bubble size need to be rechecked by applying imageJ local maximum detection.
- [x] Trajectory computing.
Bubble case 3 failed.
1) Top view of trajectory in [TopViewTraj folder](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn), please use the password I send you to access the data.

If you can't open the matlab figure file Try these two lines code in matlab:
eg.

>>fig = openfig('Graph.fig');

>>set(fig, 'Visible', 'on')



- [ ] PIV-PTV Combine.

- [x] Trajectory analysis. **Start** (10/07/2020)

1) trajectory analysis

- [x] PCA best fit plane finding.

Update [TopViewTraj folder](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn), the projection 2D plane function are shown in x label for each figure, and plotted as red line in the figure.(10/07/2020). The red arrow represents the view point of the following figures for 2D fit plane.

- [x] Side 2d view of trajectory on best fit plane.

Update [SideViewTraj folder](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn), the side view is 3D trajectory which are viewed from norm vector of best fitting 2D Plane. (10/07/2020)

2) velocity analysis.

- [x] Transverse velocity, vertical speed, and total speed.

Velocity profile [VelocityProfile](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn), the u, v hortizontal velocity of camera view plane; w is the vertical velocity. Speed is the overall velocity. (10/07/2020)

- [x] 
Transerse speed with vertical speed [TransverseSpeed](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn). **I found a very interesting behavior about damping. For higher oil fraction, the damping motion start disspiating, and higher viscousity oil will trigger it much earlier. My guess this motion of oil with in the bubble can balance the vortex induced vibration. Higher oil fraction have higher inertia and momantum. And lower viscousity oil can be easier to move inside the bubble, which can balance this vibration motion.** Based on this, we can study **actual damping motion, wavelet analysis, Hilbert transform.**

- [x] vertical  average speed with oil fraction for each case.
Vertical velocity plot with error bar for two cases average.
[VerticalVelocity](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn) (10/09/2020)

3) frequency analysis

- [x] 
Calualte instantaneous frequency based on first conditional spectral moment.
Overall frequency seems to decrease when oil fraction increase. But pure air bubble also has low frequency. **Hard to conclude** Need discuss. (10/09/2020)
[freqAnalysis](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn)
Update the freq vs oil fraction plot. (10/14/2020) [freqAnalysis](https://uofi.box.com/s/sw9vvcwwh0pjfxlhspk6wisby87mabtn)

(shot time Fourier transform)
- Compute spectrogram power spectrum P(t,f).
- Estimate the joint time-frequency moment.

4) Amplitude analysis 

- [ ] velocity amplitude

- [ ] Position amplitude


# Overall process progress report
| Outer needle | Inner needle | Initial oil volume (?L) | deq (mm) | foil | ID           | deq         |  Processing Progress | StartFrame-EndFrame |
| ------------ | ------------ | ----------------------- | -------- | ---- | ------------ | ----------- | -------------------- | ------------------- |
| 8G           | 22G          | 10                      | 4.04     | 0.08 | 1082210X-2   | 3.92869399  | <ul><li>- [x] finished </li>                   |  711-899 (The last frame is around 890 for bubble hitting the top edge, which may caused piv data missing about induced vortex)                  |
| 8G           | 22G          | 10                      | 4.04     | 0.08 | 1082210X-3   | 3.92755005  | <ul><li>- [x] Left seperate trajectory, try Link(09/25/2020) **Solved** (09/28/2020)  </li>                  |1024-1349                     |
| 8G           | 22G          | 20                      | 4.01     | 0.22 | 1082220X-1   | 3.8863055   | <ul><li>- [x] double check right camera 2 traj (09/25/2020) **Solved** (09/28/2020) </li>                     |129-449                     |
| 8G           | 22G          | 20                      | 4.01     | 0.22 | 1082220X-3   | 3.88859096  | <ul><li>- [x] Left Camera 2 trajs (09/25/2020) **Solved** (09/28/2020) </li>                    |1056-1349                     |
| 8G           | 22G          | 30                      | 4.08     | 0.31 | 1082230X-1   | 3.96551573  | <ul><li>- [x] finished </li>                     |190-449                     |
| 8G           | 22G          | 30                      | 4.08     | 0.31 | 1082230X-4   | 3.97278205  | <ul><li>- [x] finished </li>                     |1558- 1799                     |
| 12G          | 22G          | 30                      | 4.02     | 0.38 | 10122230X-3  | 4.17866011  | <ul><li>- [x] Right Camera has two trajectories. need further process **Solved** (09/28/2020) </li>                     |998-1349                     |
| 12G          | 22G          | 30                      | 4.02     | 0.38 | 10122230X-4  | 4.28105654  | <ul><li>- [x] Right Cmaera has two trajectories. (09/28/2020) **Solved** by dynamic minMass filter (09/28/2020) </li>                     |1488-1799                     |
| 14G          | 22G          | 20                      | 4.07     | 0.49 | 10142220X-3  | 4.17326273  | <ul><li>- [x] finished </li>                     |1012-1349                     |
| 14G          | 22G          | 20                      | 4.07     | 0.49 | 10142220X-5  | 4.14609406  | <ul><li>- [x] finished </li>                     |1933-2249                     |
| 14G          | 22G          | 30                      | 4.39     | 0.61 | 10142230X-2  | 4.45358163  | <ul><li>- [x] finished </li>                     |590-899                     |
| 14G          | 22G          | 30                      | 4.39     | 0.61 | 10142230X-4  | 4.42757525  | <ul><li>- [x] finished </li>                     |1472-1799                     |
| 10G          | 22G          | 6.42                    | 4.07     | 0.05 | 10010226X-2  | 7.028534846 | <ul><li>- [x] finished </li>                    |603-899                     |
| 10G          | 22G          | 6.42                    | 4.07     | 0.05 | 10010226X-4  | 6.219493989 | <ul><li>- [x] finished </li>                     |1509-1799                     |
| 10G          | 22G          | 13                      | 4.04     | 0.14 | 100102213X-1 | 13.3943055  | <ul><li>- [x] This case has some problems about LeftCamera PTV tracking, need to double check later (09/24/2020)</li> **Solved** (09/28/2020)                   |148-449                     |
| 10G          | 22G          | 13                      | 4.04     | 0.14 | 100102213X-3 | 14.34755593 | <ul><li>- [x] Similar problem as above case (09/24/2020)</li>  **Solved** (09/28/2020)                   |1067-1349                     |
| 10G          | 22G          | 25.89                   | 4        | 0.21 | 100102226X-2 | 24.65708158 | <ul><li>- [x] finished </li>                    |591-899                     |
| 10G          | 22G          | 25.89                   | 4        | 0.21 | 100102226X-3 | 19.83963865 | <ul><li>- [x] finished </li>                    | 1079-1349                    |
| 10G          | 22G          | 30.49                   | 4.04     | 0.32 | 100102230X-2 | 29.53605068 | <ul><li>- [x] Right Camera tracking get 2 trajectories, need furthur computing (09/24/2020) </li>     **Solved** (09/30/2020)                 |612-899                     |
| 10G          | 22G          | 30.49                   | 4.04     | 0.32 | 100102230X-3 | 30.24797907 | <ul><li>- [x] finished Have issued by trajectory divergence, solved (09/24/2020) </li> **Solved** (09/30/2020) |                    |1058-1349                     |
| 12G          | 22G          | 32.68                   | 4.27     | 0.43 | 100122233X-1 | 32.43544137 | <ul><li>- [x] finished </li>                     |140-449                     |
| 12G          | 22G          | 32.68                   | 4.27     | 0.43 | 100122233X-3 | 31.43128391 | <ul><li>- [x] finished </li>                    |1075-1349                     |
| 14G          | 22G          | 30                      | 4.45     | 0.6  | 100142230X-2 | 33.45791889 | <ul><li>- [x] finished </li>                    |576-899                     |
| 14G          | 22G          | 30                      | 4.45     | 0.6  | 100142230X-3 | 31.61035021 | <ul><li>- [x] finished </li>                     |1019-1349                     |
|              |              |                         |          |      | airbubble-1  |             | <ul><li>- [x] finished For Left Camera the bubble deformed a lot at the begining, and the bubble size is around 75 pixel, too large. Hence at the begining, there are 2 trajectories, need further process to combien to one. All air bubble cases have similar problem. Will try region crop. (09/25/2020) </li>  **Solved** （09/30/2020）                   |     199-449                |
|              |              |                         |          |      | airbubble-2  |             |  <ul><li>- [x] finished </li>                    |638-899                     |
|              |              |                         |          |      | airbubble-3  |             | <ul><li>- [x] finished </li>  Left has 2 traj, should be solved by matlab code (09/30/2020)   wasted (10/02/2020)                |1071-1349                     |
|              |              |                         |          |      | airbubble-4 |             | <ul><li>- [x] finished </li>                      |1515-1799                     |



