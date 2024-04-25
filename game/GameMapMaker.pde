class MapMaker extends Being{

    //a 2d array of tiles
    Tile[][] tiles;
    PImage[] tileIcons;
    MapMaker(){
        super(new PVector(0,0), new PVector(0,0), 0);
        tiles = new Tile[13][20];
        for(int i = 0; i < tiles.length; i++){
            for(int j = 0; j < tiles[0].length; j++){
                tiles[i][j] = new Tile(i, j, " ");
            }
        }
        // String[] tileTypes = {" ", "#", "L", "R", "<", ">", "t"};

        tileIcons = new PImage[9];
        tileIcons[0] = loadImage("assets/solid.png");
        tileIcons[1] = loadImage("assets/leftSolid.png");
        tileIcons[2] = loadImage("assets/rightSolid.png");
        tileIcons[3] = loadImage("assets/turnLeft.png");
        tileIcons[4] = loadImage("assets/turnRight.png");
        tileIcons[5] = loadImage("assets/teleporterEntry.png");
        tileIcons[6] = loadImage("assets/teleporterDest.png");
        tileIcons[7] = loadImage("assets/swingingIcon.png");
        tileIcons[8] = loadImage("assets/finish.png");


        selectedTile = tileTypes[1];

    }

    void update(){
        for(int i = 0; i < tiles.length; i++){
            for(int j = 0; j < tiles[0].length; j++){
                tiles[i][j].update();
            }
        }
    }

    void render(){
        for(int i = 0; i < tiles.length; i++){
            for(int j = 0; j < tiles[0].length; j++){
                tiles[i][j].render();
            }
        }
        // String[] tileTypes = {" ", "#", "L", "R", "<", ">", "t"};
        //draw a small icon image next to cursor to show what tile is selected
        switch(selectedTile){
            case "#":
            image(tileIcons[0], mouseX + 20, mouseY, 20, 20);
            break;
            case "L":
            image(tileIcons[1], mouseX + 20, mouseY, 20, 20);
            break;
            case "R":
            image(tileIcons[2], mouseX + 20, mouseY, 20, 20);
            break;
            case "<":
            image(tileIcons[3], mouseX + 20, mouseY, 20, 20);
            break;
            case ">":
            image(tileIcons[4], mouseX + 20, mouseY, 20, 20);
            break;
            case "t":
            image(tileIcons[6], mouseX + 20, mouseY, 20, 20);
            break;
            

        }


    }

    void setTile(int x, int y, String type){
        tiles[x][y].type = type;
    }

}