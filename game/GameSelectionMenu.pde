class SelectionMenu {
    PVector pos;
    PVector size;
    SelectionMenu(){
        pos = new PVector(300,250);
        size = new PVector(400,100);
    }

    void update(){
        checkMouse();
    }

    void render(){
        // draw a big rectangle in the middle of the screen with 4 other smaller rectangles inside it
        fill(51);
        rect(pos.x,pos.y,size.x,size.y,30);

        noStroke();
        fill(255);
        rect((size.x/4) * 0 + pos.x + 25 , pos.y+10, 50, 50,30);

        fill(255);
        rect((size.x/4) * 1 + pos.x + 25 , pos.y+10, 50, 50,30);

        fill(255);
        rect((size.x/4) * 2 + pos.x + 25 , pos.y+10, 50, 50,30);

        fill(255);
        rect((size.x/4) * 3 + pos.x + 25 , pos.y+10, 50, 50,30);
        
    }

    // make a function that will check if the mouse is over the rectangle and if it is clicked
    void checkMouse(){
        if(mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y){
            if(mousePressed){
                if(mouseX > (size.x/4) * 0 + pos.x + 25 && mouseX < (size.x/4) * 0 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50){
                    selectedRobot.state = "Explode";
                    selectedRobot.selected = false;
                    selecting = false;
                    println("1");
                    startSpawns();
                }
                if(mouseX > (size.x/4) * 1 + pos.x + 25 && mouseX < (size.x/4) * 1 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50){
                    selectedRobot.state = "Bridge";
                    selectedRobot.selected = false;
                    selecting = false;
                    println("2");
                    startSpawns();
                }
                if(mouseX > (size.x/4) * 2 + pos.x + 25 && mouseX < (size.x/4) * 2 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50){
                    selectedRobot.state = "Swing";
                    selectedRobot.selected = false;
                    selecting = false;
                    println("3");
                    startSpawns();
                }
                if(mouseX > (size.x/4) * 3 + pos.x + 25 && mouseX < (size.x/4) * 3 + pos.x + 25 + 50 && mouseY > pos.y+10 && mouseY < pos.y+10 + 50){
                    selectedRobot.state = "Teleport";
                    selectedRobot.selected = false;
                    selecting = false;
                    println("4");
                    startSpawns();
                }
            }
        }
    }

}   
