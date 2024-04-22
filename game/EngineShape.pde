abstract class Shape {

  abstract boolean collides(Shape other);
  abstract boolean contains(PVector point);
}

/////////////////////////////////

class Circle extends Shape {
  PVector center;
  float radius;

  Circle(PVector c, float r) {
    center = c;
    radius = r;
  }

  boolean collides(Shape other) {
    boolean result = false;
    if (other instanceof Circle) {
      result = this.collidesWith( (Circle)other );
    } else if (other instanceof Rectangle) {
      result =((Rectangle)other).collidesWith(this);
    }
    return result;
  }

  boolean collidesWith(Circle other) {
    return (this.center.dist(other.center)<=this.radius+other.radius);
  }

  boolean contains(PVector point) {
    return (this.center.dist(point)<=this.radius);
  }
}

//////////////////////////////////////

class Rectangle extends Shape {
  float rx;
  float ry;
  float rw;
  float rh;

  Rectangle(PVector c, float w, float h) {
    rx = c.x;
    ry = c.y;
    rw = w;
    rh = h;
  }

  boolean collides(Shape other) {
    boolean result = false;
    if (other instanceof Circle) {
      result = collidesWith( (Circle) other);
    } else if (other instanceof Rectangle) {
      result = collidesWith( (Rectangle) other);
    }
    return result;
  }

  boolean collidesWith(Circle other) {
    // temporary variables to set edges for testing
    float testX = other.center.x;
    float testY = other.center.y;

    // which edge is closest?
    if (other.center.x < rx)         testX = rx;      // test left edge
    else if (other.center.x > rx+rw) testX = rx+rw;   // right edge
    if (other.center.y < ry)         testY = ry;      // top edge
    else if (other.center.y > ry+rh) testY = ry+rh;   // bottom edge

    // get distance from closest edges
    float distX = other.center.x-testX;
    float distY = other.center.y-testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );

    // if the distance is less than the radius, collision!
    if (distance <= other.radius) {
      return true;
    }
    return false;
  }

  boolean collidesWith(Rectangle other) {
    // are the sides of one rectangle touching the other?

    if (rx + rw >= other.rx &&    // r1 right edge past r2 left
      rx <= other.rx + other.rw &&    // r1 left edge past r2 right
      ry + rh >= other.ry &&    // r1 top edge past r2 bottom
      ry <= other.ry + other.rh) {    // r1 bottom edge past r2 top
      return true;
    }
    return false;
  }

  boolean contains(PVector point) {
    // is the point inside the rectangle's bounds?
    if (point.x >= rx &&        // right of the left edge AND
      point.x <= rx + rw &&   // left of the right edge AND
      point.y >= ry &&        // below the top AND
      point.y <= ry + rh) {   // above the bottom
      return true;
    }
    return false;
  }
}
