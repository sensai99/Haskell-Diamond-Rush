<h1>DIAMOND RUSH</h1>
<p>This is a single player game where the user represents a character. The character has to pick up diamonds and solve puzzles. The character wants to collect all the diamonds from temple. This game has multiple stages(worlds), each with multiple levels including a Bonus stage. Each stage in the game has own specific puzzles</p>

<h2>Getting started</h2>
<h3>Prerequisites</h3>
<p>You need to have a git environment in your local machine.<br>
  Enter the following command in terminal to install git:</p>
  
```
  sudo apt install git
```

<h3>Installing</h3>
<p>Stack is a cross-platform program for developing Haskell projects. Inorder to build the project we need it.<br>
  Enter the following command in terminal to install stack:</p>

```
  wget -qO- https://get.haskellstack.org/ | sh
  sudo apt install freeglut3 freeglut3-dev
```

<h2>Cloning and Developing</h2>
<p>A quick introduction of the minimal setup you need to get a copy of the project and running.<br>
  Run the following command in terminal to clone the project:</p>
  
```
  git init
  git clone https://github.com/IITH-SBJoshi/haskell-5.git
```

<p>The repository will be downloaded to the same directory.<br>
  Enter the the folder using command:</p>
  
```
  cd haskell-5/
```

<h2>Build and Run</h2>
<p>Run the following command to build and run the project:</p>
 
```
  stack build
  stack exec diamond-exe
```

<h2>Features</h2>
<p>On executing the above commands, the project starts its execution and asks the user to choose the world to play.</p>

![Main Window](https://user-images.githubusercontent.com/47005255/56812755-2560f500-6859-11e9-8243-2b674b86d0bc.jpg)

<p>Each World has four levels and user need to choose the level - he/she wishes to play.</p>

![Levels](https://user-images.githubusercontent.com/47005255/56815366-c8683d80-685e-11e9-907b-d80bde4d26a3.jpg)

<p>Sample maze is as follows. Character can be moved using 'i', 'j', 'k' and 'l' keys.</p>
  
  ![Sample](https://user-images.githubusercontent.com/47005255/56815584-5cd2a000-685f-11e9-9293-7e803d9c7b0a.png)

<p>Timer is present at the top of the window. It starts when the maze is loaded for the first time.<br>
  Puzzle is completed when the character collects the diamond and new maze is loaded.<br>
  By the time, when the timer goes to zero, if the character does not collect the diamond, a time-out message is popped up as follows.</p>
 
 ![Timeout](https://user-images.githubusercontent.com/47005255/56815430-f6e61880-685e-11e9-86f0-ed357913d304.jpg)

<p>User can exit the application using 'esc' key.</p>

<h2>Testing</h2>
<h3>End to end tests</h3>
<p>End to end tests have been done to check the working of the game.<br>
  By end to end tests, we mean testing of game, when a new function is added to the code.</p>
<h3>Coding style tests</h3>
<p>Coding style is checked using the HLint.<br>
  HLint is a tool which suggests the improvements in the source code and checks the coding style as well.<br>
  The commands used to install it and check the coding style are as follows.</p>

```
  sudo apt install hlint
  hlint <hs-filename>
```

<p>Images required for displaying the levels, mazes etc are downloaded from open source network.<br>
  Links of those images are as follows.<br>
  Human image:<br>
  https://gamegfx.spielaffe.de/attachments/portalgame/380/380314/39760_diamond-rush-spiel-oyun-game11.jpg <br>
  Diamond image:<br>
  https://cdn.apkmody.io/uploads/2018/07/Diamond-Rush-Original-download.jpg <br>
  Time out image:<br>
  https://pbs.twimg.com/profile_images/508025121248796672/i0gT20NN_400x400.jpeg </p>
