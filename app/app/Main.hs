module Main(main) where

    import Graphics.Gloss
    import Graphics.Gloss.Data.ViewPort
    import Graphics.Gloss.Interface.Pure.Game
    import Control.Concurrent

    window :: Display
    window = FullScreen 

    background :: Color
    background = white

    

    -- vertical walls.
    v_wall :: Float -> Float -> Picture
    v_wall x y =
        translate x y $
            color black $
                rectangleSolid 10 100
    
    -- horizontal wall
    h_wall :: Float -> Float -> Picture            
    h_wall x y =
        translate x y $
            color black $
                rectangleSolid 100 10
    


    data Maze = Game
        {
        playerLoc :: (Float,Float),
        playerVel :: (Float,Float),
        squares_val :: (Float,Float,[Int]),
        number_of_grids :: Int,
        timer :: Float,
        out :: (Float,Float),
        x_range :: (Float,Float),
        y_range :: (Float,Float),
        level :: Float,
        level_name :: [Char]
        }deriving (Show)

    initialState :: Maze
    initialState = Game
        {
        playerLoc = (-50,250),
        playerVel = (0,0),
        squares_val = (-250,250,[5,12,0,6,2,6,9,0,7,4,3,3,8,7,0,4,7,3,8,0,7,3,0,7,1,7,0,7,4,3,8,4,7,0,4,7]),
        number_of_grids = 6,
        timer = 20,
        out = (50,-250),
        x_range = (-300,300),
        y_range = (-300,300),
        level = 1.1,
        level_name = "World 1 - Level 1"
        }

    {-bonusState :: Maze
    bonusState = Game
        {
        playerLoc = (0,0),

        }
    -}
    data World = Game2
        {
        level1,level2,level3 :: Maze
        } 
    
    world1 :: World
    world1 = Game2
        {
        level1 = Game
            {
            playerLoc = (-300,-200),
            playerVel = (0,0),
            squares_val = (-300,300,[13,10,6,2,10,10,12,4,3,3,4,0,4,4,1,4,7,0,7,0,3,8,4,3,4,0,3,7,9,0,4,3,3,7,3,8,7,0,0,4,4,3,8,4,7,4,4,7,7]),
            number_of_grids = 7,
            timer = 20,
            out = (350,200),
            x_range = (-350,350),
            y_range = (-350,350),
            level = 1.1,
            level_name = "level 1 - World 1"
            },

        level2 = Game
            {
            playerLoc = (-350,-350),
            playerVel = (0,0),
            squares_val = (-350,350,[5,6,10,10,6,2,10,10,9,4,0,3,3,4,4,3,14,0,7,4,4,4,7,3,1,7,0,4,4,3,0,7,8,3,4,0,3,4,7,3,1,4,3,7,4,4,3,3,8,3,3,0,3,0,0,3,4,7,4,7,4,7,4,7]),
            number_of_grids = 8,
            timer = 60,
            out = (350,350),
            x_range = (-400,400),
            y_range = (-400,400),
            level = 1.2,
            level_name = "level 2 - World 1"
            },

        level3 = Game
            {
            
            }   
        }    
    

    verticalWalls :: [Float] -> [Float] -> [Picture]
    verticalWalls [] [] = []
    verticalWalls (x:xs) (y:ys) = [(v_wall x y)] ++ (verticalWalls xs ys)

    horizontalWalls :: [Float] -> [Float] -> [Picture]
    horizontalWalls [] [] = []
    horizontalWalls (x:xs) (y:ys) = [h_wall x y] ++ (horizontalWalls xs ys)

    draw :: Float -> Float -> Int -> [Picture]
    draw x y 0 = []
    draw x y 1 = [v_wall (x-45) y]
    draw x y 2 = [h_wall x (y+45)]
    draw x y 3 = [v_wall (x+45) y]
    draw x y 4 = [h_wall x (y-45)]
    draw x y 5 = [h_wall x (y+45)] ++ [v_wall (x-45) y] 
    draw x y 6 = [h_wall x (y+45)] ++ [v_wall (x+45) y]
    draw x y 7 = [h_wall x (y-45)] ++ [v_wall (x+45) y]
    draw x y 8 = [h_wall x (y-45)] ++ [v_wall (x-45) y]
    draw x y 9 = [v_wall (x+45) y] ++ [v_wall (x-45) y]
    draw x y 10 = [h_wall x (y-45)] ++ [h_wall (x) (y+45)]
    draw x y 11 = [h_wall x (y+45)] ++ [v_wall (x-45) y] ++ [v_wall (x+45) y]
    draw x y 12 = [h_wall x (y+45)] ++ [h_wall (x) (y-45)] ++ [v_wall (x+45) y]
    draw x y 13 = [h_wall x (y+45)] ++ [h_wall (x) (y-45)] ++ [v_wall (x-45) y]
    draw x y 14 = [h_wall x (y-45)] ++ [v_wall (x-45) y] ++ [v_wall (x+45) y]
    draw x y z = []
    
    squares :: Maze -> Float -> Float -> [Int] -> [Picture]
    squares game a b [] = []
    squares game a b (x:xs) = 
        if a == (-1)*(xin) then (draw a b x) ++ (squares game xin (b-100) xs)
        else (draw a b x) ++ (squares game (a+100) b xs)
            where
                (xin,yin,c) = squares_val game

    player :: Float -> Float -> Picture
    player x y = translate x y $ color red $ rectangleSolid 10 10

    timer_dis :: Float -> Picture
    timer_dis t = translate 400 400 $ text (show t)

    level_dis :: [Char] -> Picture
    level_dis x = translate (-800) 400 $ text (show x)
    
    render :: Maze -> Picture
    render maze = pictures((squares maze a b c ) ++ [player x y] ++ [(timer_dis t)] ++ [(level_dis level)])
        where 
            (x,y) = playerLoc maze
            (a,b,c) = squares_val maze
            t = timer maze
            level = level_name maze
    
    walls_position :: (Float,Float) -> Int -> [(Float,Float,Int,Int)] --left is 0 right is 1 top is 0 bottom is 1
    walls_position (a,b) 0 = []
    walls_position (a,b) 1 = [(a-45,b,1,0)] -- 1 is vertical 0 is horizontal
    walls_position (a,b) 2 = [(a,b+45,0,0)]
    walls_position (a,b) 3 = [(a+45,b,1,1)]
    walls_position (a,b) 4 = [(a,b-45,0,1)]
    walls_position (a,b) 5 = [(a,b+45,0,0)] ++ [(a-45,b,1,0)]
    walls_position (a,b) 6 = [(a,b+45,0,0)] ++ [(a+45,b,1,1)]
    walls_position (a,b) 7 = [(a,b-45,0,1)] ++ [(a+45,b,1,1)]
    walls_position (a,b) 8 = [(a,b-45,0,1)] ++ [(a-45,b,1,0)]
    walls_position (a,b) 9 = [(a-45,b,1,0)] ++ [(a+45,b,1,1)]
    walls_position (a,b) 10 = [(a,b+45,0,0)] ++ [(a,b-45,0,1)]
    walls_position (a,b) 11 = [(a-45,b,1,0)] ++ [(a,b+45,0,0)] ++ [(a+45,b,1,1)]
    walls_position (a,b) 12 = [(a,b-45,0,1)] ++ [(a,b+45,0,0)] ++ [(a+45,b,1,1)]
    walls_position (a,b) 13 = [(a,b-45,0,1)] ++ [(a,b+45,0,0)] ++ [(a-45,b,1,0)]
    walls_position (a,b) 14 = [(a,b-45,0,1)] ++ [(a-45,b,1,0)] ++ [(a+45,b,1,1)]
    
    toInt :: Int -> Float -> Float
    toInt 0 a = a
    toInt a b = 
        if a < 0 then toInt (a+1) (b-1) else toInt (a-1) (b+1)
    
    sqr_position :: Int -> Maze -> (Float,Float)
    sqr_position a game=
        if rem a g == 0 then ((-1)*(xin),(-1)*(xin)+100 - toInt (100*(a `div` g)) 0) else (xin + toInt (100*((rem a g)-1)) 0, (yin-(toInt (100*((a- a `rem` g))) 0) / (toInt g 0)))
            where
                (xin,yin,c) = squares_val game
                g = number_of_grids game
    {-wallcollision :: (Float,Float) -> (Float,Float,Int,Int) -> Float -> Bool
    wallcollision (x,y) (a,b,c,d) 5 = collision
        where 
            collision =
                if c == 0 && d == 0 then --  horizontal top
                    if y + 5 >= b - 5 then True else False
                else if c == 0 && d == 1 then -- horizontal bottom
                    if y - 5 <= b + 5 then True else False   
                else if c == 1 && d == 0 then -- vertical left
                    if x - 5 <= a + 5 then True else False
                else                          -- vertical right
                    if x + 5 >= a - 5 then True else False    
    -}
    

    wallcollision :: (Float,Float) -> (Float,Float,Int,Int) -> (Float,Float) -> Bool
    wallcollision (x,y) (a,b,c,d) (vx,vy) = collision
        where
            collision =
                if vy > 0 then -- moving upwards
                    if c == 0 then -- horizontal wall
                        if y + 5 >= b - 5 && y <= b && a + 55 > x && x > a-55 then True else False
                    else           -- vertical wall
                        if y + 5 >= b - 50 && y <= b && a + 10 > x && x > a - 10 then True else False
                else if vy < 0 then -- moving downwards
                    if c == 0 then
                        if y - 5 <= b + 5 && y >=b &&  a + 55 > x && x > a-55 then True else False
                    else 
                        if y - 5 <= b + 50 && y >=b && a + 10 > x && x > a - 10 then True else False
                else if vx > 0 then -- moving right
                    if c == 0 then
                        if x + 5 >= a - 50 && b + 10 > y && y > b - 10 && x <= a then True else False
                    else 
                        if x + 5 >= a - 5 && b + 55 > y && y > b - 55 && x <= a then True else False
                else
                    if c == 0 then
                        if x - 5 <= a + 50 && b + 10 > y && y > b - 10 && x >= a then True else False
                    else 
                        if x - 5 <= a + 5 && b + 55 > y && y > b - 55 && x >= a then True else False        
    

    all_walls :: Int -> Maze-> [(Float,Float,Int,Int)]
    all_walls 0 game = [] 
    all_walls i game = walls_position (sqr_x,sqr_y) j ++ all_walls (i-1) game
        where
            (sqr_x,sqr_y) = sqr_position i game
            (a,b,c) = squares_val game
            j = c!!(i-1)

    shouldmove :: Maze -> (Float,Float) -> (Float,Float) -> [(Float,Float,Int,Int)] -> Bool
    shouldmove game (a,b) (vx,vy) [] = True
    shouldmove game (a,b) (vx,vy) (x:xs) = if wallcollision (a,b) x (vx,vy) then False else shouldmove game (a,b) (vx,vy) xs 
            
    {-
    movemonster :: Float -> Maze -> Maze
    movemonster seconds game = 
        if ((x,y) == (xout,yout)) then game
        else if (x + vx*seconds >= x_max || x + vx*seconds <= x_min || y + vy*seconds >= y_max || y + vy*seconds <= y_min ) then game
        else    
            if (timer game) > 0 then
                if (shouldmove game (x + vx*seconds,y + vy*seconds) (vx,vy) (all_walls last game))  then 
                    game {monsLoc = (x + vx*seconds,y + vy*seconds),timer = (timer game) - seconds}
                else
                    if vx > 0 then game { vx = 0 , vy = -100}
                    else if vx < 0 then game { vx = 0 , vy = 100}
                    else if vy > 0 then game { vy = 0 , vx = 100 }
                    else game {vy = 0 , vx = -100 }
            else
                game            
            where
                (x,y) = monsLoc game
                (vx,vy) = monsVel game
                (a,b,c) = squares_val game
                (xout,yout) = out game
                g = number_of_grids game
                last = g*g
                (x_min,x_max) = x_range game
                (y_min,y_max) = y_range game
    -}

    moveplayer :: Float -> Maze -> Maze
    moveplayer seconds game = 
        if (y == yout) then -- only y compared
            if l == 1.1 then level2 world1 else game
        else if (x + vx*seconds >= x_max || x + vx*seconds <= x_min || y + vy*seconds >= y_max || y + vy*seconds <= y_min ) then game
        else    
            if (timer game) > 0 then
                if (shouldmove game (x + vx*seconds,y + vy*seconds) (vx,vy) (all_walls last game))  then 
                    game {playerLoc = (x + vx*seconds,y + vy*seconds),timer = (timer game) - seconds}
                else
                    game {playerLoc = (x,y),timer = (timer game) - seconds}    
            else
                --threadDelay 2000000
                initialState            
            where
                (x,y) = playerLoc game
                (vx,vy) = playerVel game
                (a,b,c) = squares_val game
                (xout,yout) = out game
                --i = (floor ((x+300)/100) + (floor((300-y)/100))*5) + 1
                --j = c!!(i-1)
                --(sqr_x,sqr_y) = sqr_position i game
                g = number_of_grids game
                last = g*g
                (x_min,x_max) = x_range game
                (y_min,y_max) = y_range game
                l = level game
            
    handleKeys :: Event -> Maze -> Maze
    
    handleKeys (EventKey(Char 'i') (Down)_ _)game = game {playerVel = (0,100)}
    handleKeys (EventKey(Char 'k') (Down)_ _)game = game {playerVel = (0,(-100))}
    handleKeys (EventKey(Char 'j') (Down)_ _)game = game {playerVel = ((-100),0)}
    handleKeys (EventKey(Char 'l') (Down)_ _)game = game {playerVel = (100,0)}
    handleKeys (EventKey(Char 'i') (Up)_ _)game = if (playerVel game) == (0,100) then game {playerVel = (0,0)} else game
    handleKeys (EventKey(Char 'k') (Up)_ _)game = if playerVel game == (0,(-100)) then game {playerVel = (0,0)} else game
    handleKeys (EventKey(Char 'j') (Up)_ _)game = if playerVel game == (-100,0) then game {playerVel = (0,0)} else game
    handleKeys (EventKey(Char 'l') (Up)_ _)game = if playerVel game == (100,0) then game {playerVel = (0,0)} else game
    handleKeys _ game = game
    
    main :: IO ()
    main = play window background 100 (level1 world1) render handleKeys moveplayer
            