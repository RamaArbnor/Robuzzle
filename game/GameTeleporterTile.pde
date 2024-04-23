class Teleporter extends Tile {

    PVector dest;

    Teleporter(int i, int j, String t, PVector loc){
        super(i, j, t);
        dest = loc;
    }

    void teleport(Robot r){
        r.position.x = (dest.y)*50;
        r.position.y = (dest.x-1)*50;
        println("Teleporting to: " + dest.x + ", " + dest.y);
    }



}