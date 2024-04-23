class Teleporter extends Tile {
    PVector dest;

    Teleporter(int i, int j, String t, PVector loc){
        super(i, j, t);
        dest = loc;

		img = loadImage("assets/teleporterEntry.png");
    }

    void teleport(Robot r){
        r.position.x = (dest.y)*50;
        r.position.y = (dest.x-1)*50;
        println("Teleporting to: " + dest.x + ", " + dest.y);
    }

	void render() {
		if(img != null) {
			image(img, position.x, position.y-30, size, size+30);
		}
	}

}