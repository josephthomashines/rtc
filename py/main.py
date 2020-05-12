#!/usr/bin/env python
POINT = 1
VECTOR = 0

class Primitive():
    def __init__(self,t,x=0,y=0,z=0):
        if t == None:
            raise Exception(
                "Primitive must have type specified \
                as either POINT or VECTOR")
        self._x = x
        self._y = y
        self._z = z
        self._w = t

    def __str__(self):
        return f'{self._x} {self._y} {self._z} {self._w} '

    def is_point(self):
        return self._w == POINT
    def is_vector(self):
        return self._w == VECTOR
    def is_valid(self):
        return (not self.is_point()) and (not self.is_vector())

class Point(Primitive):
    def __init__(self,x=0,y=0,z=0):
        super().__init__(POINT,x,y,z)

def main():
    p = Point()
    print(p)

if __name__ == "__main__":
    main()

