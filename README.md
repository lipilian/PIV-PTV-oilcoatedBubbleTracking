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

- [ ] PTV point detection, Gaussian kernel blob detection.
1) Face the problem about the laser light too light for some frames that it hard to detect the blob shape for certain case, which cause trajectory divergent and mixing. <ul><li>- [x]  </li> solved 09/24/2020 by using predictor method, which use the recently nearby velocity to predict the next frame bubble location. For each case, the bubble size need to be rechecked by applying imageJ local maximum detection.
- [ ] Trajectory computing.

- [ ] PIV-PTV Combine.

- [ ] Trajectory analysis.

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
|              |              |                         |          |      | airbubble-1  |             | <ul><li>- [ ] finished For Left Camera the bubble deformed a lot at the begining, and the bubble size is around 75 pixel, too large. Hence at the begining, there are 2 trajectories, need further process to combien to one. All air bubble cases have similar problem. Will try region crop. (09/25/2020) </li>                      |     199-449                |
|              |              |                         |          |      | airbubble-2  |             |  <ul><li>- [ ] finished </li>                    |638-899                     |
|              |              |                         |          |      | airbubble-3  |             | <ul><li>- [ ] finished </li>                     |1071-1349                     |
|              |              |                         |          |      | airbubble-4 |             | <ul><li>- [ ] finished </li>                      |1515-1799                     |



